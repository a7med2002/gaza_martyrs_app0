import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gaza_martyer_app/controllers/Admin/admin_controller.dart';
import 'package:gaza_martyer_app/controllers/User/stories_controller.dart';
import 'package:gaza_martyer_app/models/martyer_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';

import 'package:gaza_martyer_app/controllers/User/Helper/image_helper.dart';

class SubmitStoryController extends GetxController {
  RxString firstName = ''.obs;
  RxString midName = ''.obs;
  RxString lastName = ''.obs;
  RxString martyerCity = ''.obs;
  RxString martyerAge = ''.obs;
  RxString martyerGender = ''.obs;
  RxString monthMartyer = ''.obs;
  RxString yearMartyer = ''.obs;
  RxString jobMartyer = ''.obs;
  RxString photoMartyer = ''.obs;
  RxString storyMartyer = ''.obs;
  Rx<Uint8List?> uploadedBytes = Rx<Uint8List?>(null); // للويب فقط

  ImagePicker picker = ImagePicker();
  RxString imagePickedPath = ''.obs;

  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  var uuid = Uuid();
  StoriesController storiesController = Get.put(StoriesController());
  AdminController adminController = Get.put(AdminController());

  RxBool isLoading = false.obs;

  void initEditFields(MartyerModel story) {
    firstName.value = story.firstName;
    midName.value = story.midName;
    lastName.value = story.lastName;
    storyMartyer.value = story.story;

    martyerGender.value = story.martyerGender;
    martyerCity.value = story.martyerCity;
    martyerAge.value = story.martyerAge;
    monthMartyer.value = story.monthMartyer;
    yearMartyer.value = story.yearMartyer;
    jobMartyer.value = story.jobMartyer;
    photoMartyer.value = story.photoUrl;
  }

  // Pick iamge from Gallery
  Future<void> pickImage() async {
    // Pick an image from Gal.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Check size limit (5MB = 5 * 1024 * 1024 bytes)
      final int sizeInBytes = await image.length();
      const int maxSizeInBytes = 5 * 1024 * 1024;

      if (sizeInBytes > maxSizeInBytes) {
        print("Image is larger than 5MB!");
        Get.snackbar(
          "Image Too Large".tr,
          "Please select an image smaller than 5 MB.".tr,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
        return;
      }
      if (kIsWeb) {
        final bytes = await image.readAsBytes();
        uploadedBytes.value = bytes;

        imagePickedPath.value = createWebImageUrl(bytes);
      } else {
        imagePickedPath.value = image.path;
        print("Image Path: ${image.path}");
      }
    } else {
      print("No Image Selected!");
    }
  }

  // Upload image to Cloudinary
  Future<String?> uploadImageToCloudinary(File? imageFile) async {
    final cloudinaryUrl =
        "https://api.cloudinary.com/v1_1/dqxdy9cdc/image/upload";
    final presetName = "pinned_stories";

    final request = http.MultipartRequest('POST', Uri.parse(cloudinaryUrl))
      ..fields['upload_preset'] = presetName;

    if (kIsWeb) {
      if (uploadedBytes.value == null) return null;

      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          uploadedBytes.value!,
          filename: 'upload.jpg',
          contentType: MediaType('image', 'jpeg'),
        ),
      );
    } else {
      if (imageFile == null) return null;

      request.files.add(
        await http.MultipartFile.fromPath('file', imageFile.path),
      );
    }

    final response = await request.send();
    final res = await http.Response.fromStream(response);

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      return data['secure_url'];
    } else {
      print("Upload failed: ${res.body}");
      return null;
    }
  }

  // Submit Story
  Future<void> submitStory({bool isAdmin = false}) async {
    isLoading.value = true;
    try {
      if (imagePickedPath.value.isEmpty) {
        Get.snackbar(
          "Missing Image".tr,
          "Please pick an image before submitting.".tr,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
        return;
      }

      String? uploadedUrl;

      if (kIsWeb) {
        uploadedUrl = await uploadImageToCloudinary(null);
      } else {
        uploadedUrl =
            await uploadImageToCloudinary(File(imagePickedPath.value));
      }

      if (uploadedUrl == null) {
        Get.snackbar(
          "Upload Failed".tr,
          "Could not upload image.".tr,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
        return;
      }

      photoMartyer.value = uploadedUrl;
      final storyId = uuid.v4();

      final martyer = MartyerModel(
        id: storyId,
        firstName: firstName.value,
        midName: midName.value,
        lastName: lastName.value,
        martyerCity: martyerCity.value,
        martyerGender: martyerGender.value,
        martyerAge: martyerAge.value,
        monthMartyer: monthMartyer.value,
        yearMartyer: yearMartyer.value,
        jobMartyer: jobMartyer.value,
        photoUrl: uploadedUrl,
        story: storyMartyer.value,
        submittedBy: isAdmin ? "admin" : auth.currentUser!.uid,
        submittedAt: DateTime.now(),
        status: isAdmin ? "posted" : "pending",
      );

      // Get Current User Details
      final currenUserDetails =
          await db.collection("users").doc(auth.currentUser!.uid).get();

      // Get fcmToken For current user
      final fcmToken = currenUserDetails.data()!["fcmToken"];
      await db.collection("stories").doc(storyId).set(martyer.toJson());
      isLoading.value = false;
      if (isAdmin) {
        await adminController.sendNotificationToAllUsers(
            title: "📢 New Story",
            body:
                "${firstName.value} ${midName.value} ${lastName.value} added to martyers stories.");
      } else {
        await adminController.sendPushNotificationToToken(
            token: fcmToken,
            title: "Submit Your Request Story".tr,
            body:
                "it will be reviewed and examined by the work team, and you will receive a notification if it is accepted or rejected."
                    .tr);
        // before => Delete old notification for the user
        await adminController
            .deleteOldNotificationsForUser(auth.currentUser!.uid);
        final notificationsRef = FirebaseFirestore.instance
            .collection('users')
            .doc(auth.currentUser!.uid)
            .collection('notifications');

        await notificationsRef.add({
          'title': "Submit Your Request Story".tr,
          'body':
              "it will be reviewed and examined by the work team, and you will receive a notification if it is accepted or rejected."
                  .tr,
          'sentAt': Timestamp.now(),
          'read': false,
        });
      }
      Get.snackbar(
        "Success".tr,
        isAdmin
            ? "Story posted successfully.".tr
            : "Story submitted successfully.".tr,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
      storiesController.loadPostedStories();
      clear();
    } catch (e) {
      print("Error submitting story: $e");
      isLoading.value = false;
      Get.snackbar(
        "Error".tr,
        isAdmin ? "Failed to post story.".tr : "Failed to submit story.".tr,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    }
  }

  // Validate Submit Story Form
  bool validateFormFields() {
    if (firstName.value.trim().isEmpty ||
        midName.value.trim().isEmpty ||
        lastName.value.trim().isEmpty ||
        martyerCity.value.trim().isEmpty ||
        martyerGender.value.trim().isEmpty ||
        martyerAge.value.trim().isEmpty ||
        monthMartyer.value.trim().isEmpty ||
        yearMartyer.value.trim().isEmpty ||
        jobMartyer.value.trim().isEmpty ||
        storyMartyer.value.trim().isEmpty ||
        (photoMartyer.value.isEmpty && imagePickedPath.value.isEmpty)) {
      Get.snackbar(
        "Error".tr,
        "Please fill all required fields.".tr,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
      return false;
    }
    return true;
  }

  void clear() {
    firstName.value = "";
    midName.value = "";
    lastName.value = "";
    jobMartyer.value = "";
    martyerAge.value = "";
    martyerGender.value = "";
    martyerCity.value = "";
    monthMartyer.value = "";
    photoMartyer.value = "";
    storyMartyer.value = "";
    imagePickedPath.value = "";
  }

  Future<String?> uploadBase64ToCloudinary(String base64Image) async {
    final cloudinaryUrl =
        "https://api.cloudinary.com/v1_1/dqxdy9cdc/image/upload";
    final presetName = "pinned_stories";

    final response = await http.post(
      Uri.parse(cloudinaryUrl),
      body: {
        'file': base64Image,
        'upload_preset': presetName,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['secure_url'];
    } else {
      print("Upload failed: ${response.body}");
      return null;
    }
  }

  Future<void> updateStory(String storyId) async {
    isLoading.value = true;
    try {
      if (!validateFormFields()) return;
      // رفع صورة جديدة لو تم تغييرها
      String? updatedPhotoUrl = photoMartyer.value;
      if (imagePickedPath.value.isNotEmpty &&
          !photoMartyer.value.startsWith("http")) {
        // يعني المستخدم اختار صورة جديدة
        updatedPhotoUrl = kIsWeb
            ? await uploadImageToCloudinary(null)
            : await uploadImageToCloudinary(File(imagePickedPath.value));

        if (updatedPhotoUrl == null) {
          Get.snackbar(
            "Upload Failed".tr,
            "Failed to upload image.".tr,
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 3),
          );
          return;
        }
      }

      await db.collection("stories").doc(storyId).update({
        "firstName": firstName.value,
        "midName": midName.value,
        "lastName": lastName.value,
        "martyerCity": martyerCity.value,
        "martyerGender": martyerGender.value,
        "martyerAge": martyerAge.value,
        "monthMartyer": monthMartyer.value,
        "yearMartyer": yearMartyer.value,
        "jobMartyer": jobMartyer.value,
        "photoUrl": photoMartyer.value,
        "story": storyMartyer.value,
        "updatedAt": DateTime.now(), // field for tracking updates
      });
      isLoading.value = false;
      Get.snackbar(
        "Success".tr,
        "Story updated successfully.".tr,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
      storiesController.loadPostedStories();
    } catch (error) {
      print("Error updating story: $error");
      isLoading.value = false;
      Get.snackbar(
        "Error".tr,
        "Failed to update story.".tr,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    }
  }

  Future<void> updateStoryRequest(String storyId, String status) async {
    isLoading.value = true;
    try {
      final storyDoc = await db.collection("stories").doc(storyId).get();
      final storyData = storyDoc.data();
      if (storyData == null) {
        isLoading.value = false;
        return;
      }

      final userId = storyData['submittedBy'];

      // Update story status
      await db.collection("stories").doc(storyId).update({
        "status": status,
      });

      // Fetch fcmToken for this user to send notification
      final userDoc = await db.collection("users").doc(userId).get();
      final userData = userDoc.data();

      if (userData != null && userData['fcmToken'] != null) {
        final fcmToken = userData['fcmToken'];

        adminController.sendPushNotificationToToken(
            token: fcmToken,
            title: status == "reject"
                ? "Your story has been rejected".tr
                : "Your story has been accepted".tr,
            body: status == "reject"
                ? "${"Your story for the martyer".tr} ${storyData['firstName']} ${storyData['midName']} ${storyData['lastName']} ${"has been rejected because it does not comply with the terms and conditions.".tr}"
                : "${"Your story for the martyer".tr} ${storyData['firstName']} ${storyData['midName']} ${storyData['lastName']} ${"has been published successfully and is now live for others to see.".tr}");
        //------------------------------------------------
        // before => Delete old notification for the user
        await adminController
            .deleteOldNotificationsForUser(auth.currentUser!.uid);
        final notificationsRef = FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('notifications');

        await notificationsRef.add({
          'title': status == "reject"
              ? "Your story has been rejected".tr
              : "Your story has been accepted".tr,
          'body': status == "reject"
              ? "${"Your story for the martyer".tr} ${storyData['firstName']} ${storyData['midName']} ${storyData['lastName']} ${"has been rejected because it does not comply with the terms and conditions.".tr}"
              : "${"Your story for the martyer".tr} ${storyData['firstName']} ${storyData['midName']} ${storyData['lastName']} ${"has been published successfully and is now live for others to see.".tr}",
          'sentAt': Timestamp.now(),
          'read': false,
        });
        //------------------------------------------------
        if (status == "posted") {
          adminController.sendNotificationToAllUsers(
              title: "📢 New Story",
              body:
                  "${storyData['firstName']} ${storyData['midName']} ${storyData['lastName']} ${"added to martyers stories.".tr}");
        }
      }
    } catch (e) {
      print("Error updating story and sending notification: $e");
    }
    isLoading.value = false;
  }
}
