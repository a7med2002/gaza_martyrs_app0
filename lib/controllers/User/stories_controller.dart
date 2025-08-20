import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gaza_martyer_app/controllers/Admin/admin_controller.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gaza_martyer_app/controllers/Admin/pagination_controller.dart';
import 'package:gaza_martyer_app/models/martyer_model.dart';
import 'package:get/get.dart';
import 'package:crypto/crypto.dart';

class StoriesController extends GetxController {
  final db = FirebaseFirestore.instance;
   final auth = FirebaseAuth.instance;
  RxList<MartyerModel> postedStories = <MartyerModel>[].obs;
  RxList<MartyerModel> latestStories = <MartyerModel>[].obs;
  RxList<MartyerModel> forYouStories = <MartyerModel>[].obs;
  PaginationController paginationController = Get.put(PaginationController());
  AdminController adminController = Get.put(AdminController());
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadPostedStories();
    loadLatestStories();
    loadForYouStories();
  }

  Future<void> loadPostedStories() async {
    isLoading.value = true;
    final stories = await fetchPostedStories();
    postedStories.assignAll(stories);
    paginationController.allItems.value = postedStories.value;
    isLoading.value = false;
  }

  Future<List<MartyerModel>> fetchPostedStories() async {
    try {
      final snapshot = await db
          .collection("stories")
          .where("status", isEqualTo: "posted")
          .orderBy("submittedAt", descending: true)
          .get();

      return snapshot.docs
          .map((doc) => MartyerModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print("Error fetching posted stories: $e");
      return [];
    }
  }

  // For Latest Stories
  Future<void> loadLatestStories() async {
    isLoading.value = true;
    final latest = await fetchLatestStories();
    latestStories.assignAll(latest);
    isLoading.value = false;
  }

  Future<List<MartyerModel>> fetchLatestStories({int limit = 10}) async {
    isLoading.value = true;
    try {
      final snapshot = await db
          .collection("stories")
          .where("status", isEqualTo: "posted")
          .orderBy("submittedAt", descending: true)
          .limit(limit)
          .get();
      isLoading.value = false;
      return snapshot.docs
          .map((doc) => MartyerModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print("Error fetching posted stories: $e");
      isLoading.value = false;
      return [];
    }
  }

  // For ForYou Stories
  Future<void> loadForYouStories() async {
    isLoading.value = true;
    final forYou = await fetchForYouStories();
    forYouStories.assignAll(forYou);
    isLoading.value = false;
  }

  Future<List<MartyerModel>> fetchForYouStories() async {
    isLoading.value = true;
    try {
      final snapshot = await db
          .collection("stories")
          .where("status", isEqualTo: "posted")
          .orderBy("submittedAt", descending: true)
          .get();
      final forYou = snapshot.docs
          .map((doc) => MartyerModel.fromJson(doc.data()))
          .toList();
      forYou.shuffle();
      isLoading.value = false;
      return forYou;
    } catch (e) {
      print("Error fetching posted stories: $e");
      isLoading.value = false;
      return [];
    }
  }

  // For Requsted Stories
  Future<List<MartyerModel>> fetchRequstedStories() async {
    try {
      final snapshot = await db
          .collection("stories")
          .where("status", isEqualTo: "pending")
          .orderBy("submittedAt", descending: true)
          .get();

      return snapshot.docs
          .map((doc) => MartyerModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print("Error fetching posted stories: $e");
      return [];
    }
  }

  // For Admin Reject Story
  Future<void> rejectDeleteStory(String storyId) async {
    isLoading.value = true;
    try {
      // ❶ نحصل على بيانات القصة عشان نجيب رابط الصورة
      final storyData = await db.collection("stories").doc(storyId).get();
      if (!storyData.exists) {
        return;
      }

      final imageUrl = storyData.data()?['photoUrl'];
      if (imageUrl != null && imageUrl.toString().isNotEmpty) {
        final deleted = await deleteImageFromCloudinary(imageUrl);
        if (!deleted) {
          print("Failed to delete image from Cloudinary.");
          return;
        }
      }

      // ❷ نحذف القصة من Firestore
      await db.collection("stories").doc(storyId).delete();

      final userId = storyData['submittedBy'];

      // Fetch fcmToken for this user to send notification
      final userDoc = await db.collection("users").doc(userId).get();
      final userData = userDoc.data();

      if (userData != null && userData['fcmToken'] != null) {
        final fcmToken = userData['fcmToken'];

        adminController.sendPushNotificationToToken(
            token: fcmToken,
            title: "Your story has been rejected".tr,
            body:
                "${"Your story for the martyer".tr} ${storyData['firstName']} ${storyData['midName']} ${storyData['lastName']} ${"has been rejected because it does not comply with the terms and conditions.".tr}");
        //------------------------------------------------
        // before => Delete old notification for the user
        await adminController
            .deleteOldNotificationsForUser(auth.currentUser!.uid);
        final notificationsRef = FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('notifications');

        await notificationsRef.add({
          'title': "Your story has been rejected".tr,
          'body':
              "${"Your story for the martyer".tr} ${storyData['firstName']} ${storyData['midName']} ${storyData['lastName']} ${"has been rejected because it does not comply with the terms and conditions.".tr}",
          'sentAt': Timestamp.now(),
          'read': false,
        });

        Get.snackbar(
          "Story Deleted".tr,
          "Succefully delete these stories..".tr,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );

        await loadPostedStories();
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Field Delete!!".tr,
        "Erorr .. please try again later.".tr,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    }
  }

  // For Delete Story
  Future<void> deleteStory(String storyId) async {
    isLoading.value = true;
    try {
      // ❶ نحصل على بيانات القصة عشان نجيب رابط الصورة
      final storyDoc = await db.collection("stories").doc(storyId).get();
      if (!storyDoc.exists) {
        print("Story not found");
        return;
      }

      final imageUrl = storyDoc.data()?['photoUrl'];
      if (imageUrl != null && imageUrl.toString().isNotEmpty) {
        final deleted = await deleteImageFromCloudinary(imageUrl);
        if (!deleted) {
          print("Failed to delete image from Cloudinary.");
          return;
        }
      }

      // ❷ نحذف القصة من Firestore
      await db.collection("stories").doc(storyId).delete();

      // ❸ نحذف من المفضلة
      final favSnapshot = await db.collection("favorites").get();
      for (final userDoc in favSnapshot.docs) {
        final userId = userDoc.id;
        final userFavorites = await db
            .collection("Favorites")
            .doc(userId)
            .collection("stories")
            .where(FieldPath.documentId, isEqualTo: storyId)
            .get();
        for (final favDoc in userFavorites.docs) {
          await favDoc.reference.delete();
        }
      }
      Get.snackbar(
        "Story Deleted".tr,
        "Succefully delete these stories..".tr,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
      await loadPostedStories();
      isLoading.value = false;
    } catch (e) {
      print("Faild to delete this story: $e");
      isLoading.value = false;
      Get.snackbar(
        "Field Delete!!".tr,
        "Erorr .. please try again later.".tr,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    }
  }

  String extractPublicId(String imageUrl) {
    final uri = Uri.parse(imageUrl);
    final segments = uri.pathSegments;

    // ابحث عن "upload" وخذ الجزء اللي بعده (تجاهل version)
    final uploadIndex = segments.indexOf('upload');
    if (uploadIndex != -1 && uploadIndex + 2 < segments.length) {
      final publicId =
          segments[uploadIndex + 2].replaceAll(RegExp(r'\.(jpg|jpeg|png)'), '');
      return publicId;
    }
    return '';
  }

  Future<bool> deleteImageFromCloudinary(String imageUrl) async {
    final cloudName = 'dqxdy9cdc';
    final apiKey = '854578155543932';
    final apiSecret = 'txc19WKCdIM1H0g8GFpxAQeAQVo';
    final publicId = extractPublicId(imageUrl);
    print("publicId: $publicId");

    final timestamp = (DateTime.now().millisecondsSinceEpoch / 1000).round();

    final signatureString =
        'public_id=$publicId&timestamp=$timestamp$apiSecret';

    final signature = sha1.convert(utf8.encode(signatureString)).toString();

    final url =
        Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/destroy');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'public_id': publicId,
        'resource_type': 'image',
        'timestamp': timestamp.toString(),
        'signature': signature,
        'api_key': apiKey,
      },
    );

    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['result'] == 'ok';
    } else {
      return false;
    }
  }
}
