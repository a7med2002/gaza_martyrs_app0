import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/models/martyer_model.dart';
import 'package:gaza_martyer_app/models/user_model.dart';
import 'package:gaza_martyer_app/screens/Admin/Pages/Reports/report_details.dart';
import 'package:gaza_martyer_app/screens/Admin/Pages/Reports/report_table.dart';
import 'package:gaza_martyer_app/screens/Admin/Pages/Stories/edit_story.dart';
import 'package:gaza_martyer_app/screens/Admin/Pages/Stories/stories_table.dart';
import 'package:gaza_martyer_app/screens/Admin/Pages/Stories/view_stroy.dart';
import 'package:gaza_martyer_app/screens/Admin/Pages/Users/user_details.dart';
import 'package:gaza_martyer_app/screens/Admin/Pages/Users/users_table.dart';
import 'package:gaza_martyer_app/screens/Admin/Pages/Add%20Stories/add_stories.dart';
import 'package:gaza_martyer_app/screens/Admin/Pages/admin_notification.dart';
import 'package:gaza_martyer_app/screens/Admin/Pages/dashboard.dart';
import 'package:gaza_martyer_app/screens/Admin/Pages/Reports/report.dart';
import 'package:gaza_martyer_app/screens/Admin/Pages/request_stories.dart';
import 'package:gaza_martyer_app/screens/Admin/Pages/static_pages.dart';
import 'package:gaza_martyer_app/screens/Admin/Pages/statistics.dart';
import 'package:gaza_martyer_app/screens/Admin/Pages/Stories/stories.dart';
import 'package:gaza_martyer_app/screens/Admin/Pages/Users/users.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AdminController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;

  RxInt selectedIndex = 0.obs;
  final List<Widget> pages = [
    Dashboard(),
    Stories(),
    RequestStories(),
    AddStories(),
    Report(),
    Users(),
    Statistics(),
    StaticPages(),
    AdminNotification(),
  ];

  final List<String> titlePages = [
    "Dashboard".tr,
    "Stories".tr,
    "Req. Stories".tr,
    "Add Story".tr,
    "Report".tr,
    "Users".tr,
    "Statistics".tr,
    "Static Pages".tr,
    "Notification".tr
  ];

  // For Stories Pages
  RxInt storySelectedIndex = 0.obs;
  final List<Widget> storiesPages = [StoriesTable(), ViewStroy(), EditStory()];

  // For Reports Of Story
  RxInt reportStorySelectedIndex = 0.obs;
  Rx<MartyerModel?> selectedStory = Rx<MartyerModel?>(null);
  final List<Widget> reportsPages = [ReportTable(), ReportDetails()];

  RxString emailReporter = ''.obs;

  // For Users
  RxInt userSelectedIndex = 0.obs;
  final List<Widget> usersPages = [UsersTable(), UserDetails()];

  RxList<Map<String, dynamic>> notificationsList = <Map<String, dynamic>>[].obs;

  // Get User Puplished Selected Story
  Future<String> getUSerPulishedStory(String userId) async {
    final snapshot = await db.collection("users").doc(userId).get();
    final user = UserModel.fromJson(snapshot.data()!);
    return user.email!;
  }

  // Get Email Reporter
  void getEmailReporter(String userId) async {
    try {
      final snapshot = await db.collection("users").doc(userId).get();

      if (!snapshot.exists || snapshot.data() == null) {
        print("User with ID $userId does not exist.");
        emailReporter.value = "Unknown User";
        return;
      }

      final user = UserModel.fromJson(snapshot.data()!);
      emailReporter.value = user.email ?? "No Email";
    } catch (e) {
      print("Error: $e");
      emailReporter.value = "Error fetching email";
    }
  }

  // Delete Notification after 7 Days
  Future<void> deleteOldNotifications(
      {Duration maxAge = const Duration(days: 7)}) async {
    final cutoff = Timestamp.fromDate(DateTime.now().subtract(maxAge));

    final oldNotifications = await db
        .collection("notifications")
        .where('sentAt', isLessThan: cutoff)
        .get();

    for (final doc in oldNotifications.docs) {
      await doc.reference.delete();
    }
  }

  Future<void> sendNotificationToAllUsers({
    required String title,
    required String body,
  }) async {
    // Delete old notification at first
    await deleteOldNotifications();

    final serviceAccount = await getServiceAccountFromFirestore();

    if (serviceAccount == null) {
      print("🛑 Service account not found, aborting sendPushNotification");
      return;
    }

    final clientEmail = serviceAccount['client_email'] as String;
    final privateKey =
        (serviceAccount['private_key'] as String).replaceAll(r'\n', '\n');
    final projectId = serviceAccount['project_id'] as String;

    // 2. الحصول على access token
    final accessToken = await getAccessToken(clientEmail, privateKey);

    // 3. إرسال إشعار لتوبيك "all"
    final url = Uri.parse(
        'https://fcm.googleapis.com/v1/projects/$projectId/messages:send');

    final message = {
      "message": {
        "topic": "all",
        "notification": {
          "title": title,
          "body": body,
        },
        "android": {
          "notification": {
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
            "icon": "ic_notification_white",
            "channel_id": "high_importance_channel",
            "sound": "default"
          },
        },
        "apns": {
          "payload": {
            "aps": {
              "contentAvailable": true,
            },
          },
        },
      }
    };

    final response = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      await db.collection("notifications").add({
        'title': title,
        'body': body,
        'sentAt': Timestamp.now(),
        'type': 'general',
      });
      print('Notification sent to topic "all" successfully.');
    } else {
      print('Failed to send notification: ${response.body}');
    }
  }

  Future<String> getAccessToken(String clientEmail, String privateKey) async {
    final iat = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final exp = iat + 3600;

    final jwt = JWT(
      {
        'iss': clientEmail,
        'scope': 'https://www.googleapis.com/auth/firebase.messaging',
        'aud': 'https://oauth2.googleapis.com/token',
        'iat': iat,
        'exp': exp,
      },
      issuer: clientEmail,
    );

    final token = jwt.sign(
      RSAPrivateKey(privateKey),
      algorithm: JWTAlgorithm.RS256,
    );

    final response = await http.post(
      Uri.parse('https://oauth2.googleapis.com/token'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'grant_type': 'urn:ietf:params:oauth:grant-type:jwt-bearer',
        'assertion': token,
      },
    );

    final data = jsonDecode(response.body);
    return data['access_token'];
  }

  // Delete Notification for user after 7 Days
  Future<void> deleteOldNotificationsForUser(String userId,
      {Duration maxAge = const Duration(days: 7)}) async {
    final cutoff = Timestamp.fromDate(DateTime.now().subtract(maxAge));

    final oldNotifications = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .where('sentAt', isLessThan: cutoff)
        .get();

    for (final doc in oldNotifications.docs) {
      await doc.reference.delete();
    }
  }

  Future<void> sendPushNotificationToToken({
    required String token,
    required String title,
    required String body,
  }) async {
    try {
      final serviceAccount = await getServiceAccountFromFirestore();

      if (serviceAccount == null) {
        print("🛑 Service account not found, aborting sendPushNotification");
        return;
      }

      final clientEmail = serviceAccount['client_email'] as String;
      final privateKey =
          (serviceAccount['private_key'] as String).replaceAll(r'\n', '\n');
      final projectId = serviceAccount['project_id'] as String;

      final accessToken = await getAccessToken(
        clientEmail,
        privateKey,
      );
      final url = Uri.parse(
          'https://fcm.googleapis.com/v1/projects/$projectId/messages:send');

      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "message": {
            "token": token,
            "notification": {
              "title": title,
              "body": body,
            },
            "android": {
              "notification": {
                "click_action": "FLUTTER_NOTIFICATION_CLICK",
                "icon": "ic_notification_white",
                "channel_id": "high_importance_channel",
                "sound": "default"
              }
            },
            "data": {
              "click_action": "FLUTTER_NOTIFICATION_CLICK",
            }
          }
        }),
      );

      if (response.statusCode == 200) {
        print("✅ Notification sent to $token");
      } else {
        print("❌ Failed to send to $token: ${response.body}");
      }
    } catch (e) {
      print("Error fetching service account: $e");
    }
  }

  Future<Map<String, dynamic>?> getServiceAccountFromFirestore() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('config')
          .doc('serviceAccount')
          .get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        final credentials = data['credentials'] as Map<String, dynamic>;
        print("✅ Credentials loaded successfully");
        return credentials;
      } else {
        print("🛑 Service account doc not found");
        return null;
      }
    } catch (e) {
      print("❌ Error fetching service account: $e");
      return null;
    }
  }

  Future<void> getAllNotifications(String userId) async {
    isLoading.value = true;
    try {
      final publicStream = db
          .collection("notifications")
          .orderBy("sentAt", descending: true)
          .snapshots();

      final privateStream = db
          .collection("users")
          .doc(userId)
          .collection("notifications")
          .orderBy("sentAt", descending: true)
          .snapshots();

      RxList<Map<String, dynamic>> combinedList = <Map<String, dynamic>>[].obs;

      // نستمع للـ 2 Streams ونحدث القائمة المشتركة
      publicStream.listen((publicSnapshot) {
        final publicList =
            publicSnapshot.docs.map((doc) => doc.data()).toList();

        privateStream.listen((privateSnapshot) {
          final privateList =
              privateSnapshot.docs.map((doc) => doc.data()).toList();

          final all = [...publicList, ...privateList];

          // ترتيب حسب التاريخ
          all.sort((a, b) =>
              (b['sentAt'] as Timestamp).compareTo(a['sentAt'] as Timestamp));

          combinedList.value = all;
        });
      });

      notificationsList = combinedList;
      isLoading.value = false;
    } catch (e) {
      print("❌ Error fetching all notifications: $e");
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    final user = auth.currentUser;
    if (user != null) {
      getAllNotifications(user.uid);
    } else {
      print("🔴 No user is currently logged in.");
    }
    super.onInit();
  }
}
