import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/controllers/Admin/admin_controller.dart';
import 'package:gaza_martyer_app/models/user_model.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final fMsg = FirebaseMessaging.instance;
  RxBool isLoading = false.obs;

// For Sign Up
  RxString password = ''.obs;
  RxString confirmPassword = ''.obs;

// For Change Password
  RxString currentPassword = ''.obs;
  RxString newPassword = ''.obs;
  RxString confirmNewPassword = ''.obs;

  RxBool canChangePassword = false.obs;

  AdminController adminController = Get.put(AdminController());

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a password".tr;
    }

    if (value.length < 8) {
      return "Password must be at least 8 characters".tr;
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return "Must contain at least one lowercase letter".tr;
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "Must contain at least one digit".tr;
    }

    return null;
  }

  Future<void> createAccount(String email, String password, String name) async {
    isLoading.value = true;
    try {
      // Create Account
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // Email Verification
      await auth.currentUser!.sendEmailVerification();
      // Alert User
      Get.snackbar(
        "Verification Email Sent".tr,
        "Please check your email to verify your account.".tr,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );

      Get.offAllNamed("/login");

      initialUser(name, email, "email");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // Alert User
        Get.snackbar(
          "Weak Password".tr,
          "The password provided is too weak.".tr,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        // Alert User
        Get.snackbar(
          "Account Exists".tr,
          "The account already exists for that email.".tr,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
  }

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      await auth.currentUser!.reload();

      // check if account email isn't verified
      if (!auth.currentUser!.emailVerified) {
        Get.snackbar(
          "Email not verified".tr,
          "Please verify your email before logging in.".tr,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
        await auth.signOut();
        isLoading.value = false;
        return;
      }
      final userId = auth.currentUser!.uid;
      // check if account is disabled
      final userDoc = await db.collection("users").doc(userId).get();
      if (userDoc.exists && userDoc.data()!["status"] == "disabled") {
        Get.snackbar(
          "Account Disabled".tr,
          "Your account has been disabled by the admin.".tr,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
        await auth.signOut();
        isLoading.value = false;
        return;
      }
      // Update Login Date
      await db.collection("users").doc(userId).update({
        "loginDate": DateTime.now(),
      });
      await fMsg.subscribeToTopic('all');
      saveFcmTokenForCurrentUser(userId);
      Get.offAllNamed("/mainScreen");
      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          "User not found".tr,
          "No user found for that email.".tr,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
        isLoading.value = false;
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          "Wrong password".tr,
          "Wrong password provided for that user.".tr,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
        isLoading.value = false;
      }
    }
  }

  Future<void> initialUser(
      String name, String email, String signInMethod) async {
    final newUser = UserModel(
        name: name,
        email: email,
        id: auth.currentUser!.uid,
        role: "user",
        createdAt: DateTime.now(),
        loginDate: DateTime.now(),
        status: "active",
        signInMethod: signInMethod);
    try {
      await db
          .collection("users")
          .doc(auth.currentUser!.uid)
          .set(newUser.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    isLoading.value = true;

    // 1️⃣ Initialize Google Sign-In
    await GoogleSignIn.instance.initialize(
      clientId: Platform.isAndroid
          ? "559171186326-67emdauaa91vjd4d61t2f5pggna4p87e.apps.googleusercontent.com"
          : "559171186326-s96cb65a1qcgjas9antihn1vlcsbffsk.apps.googleusercontent.com",
      serverClientId:
          "559171186326-ofuik0rs57djqbi01jektnnrnllakjkh.apps.googleusercontent.com",
    );

    // 2️⃣ Force sign out to always show account picker
    await GoogleSignIn.instance.signOut();

    try {
      // 3️⃣ Start sign-in flow
      final googleUser = await GoogleSignIn.instance.authenticate();

      // 4️⃣ Get authentication tokens
      final googleAuth = await googleUser.authentication;

      // 5️⃣ Create Firebase credential
      final credential = GoogleAuthProvider.credential(
        // accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 6️⃣ Sign in to Firebase
      final userCredential = await auth.signInWithCredential(credential);
      final user = auth.currentUser;

      // 7️⃣ Check if user exists in Firestore
      final doc = await db.collection("users").doc(user!.uid).get();
      if (!doc.exists) {
        await initialUser(
          googleUser.displayName ?? "No Name",
          googleUser.email,
          "google",
        );
      }

      final userId = auth.currentUser!.uid;

      // 8️⃣ Check if account is disabled
      final userDoc = await db.collection("users").doc(userId).get();
      if (userDoc.exists && userDoc.data()!["status"] == "disabled") {
        Get.snackbar(
          "Account Disabled".tr,
          "Your account has been disabled by the admin.".tr,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
        await auth.signOut();
        isLoading.value = false;
        return userCredential;
      }

      // 9️⃣ Update Login Date
      await db.collection("users").doc(userId).update({
        "loginDate": DateTime.now(),
      });

      // 🔟 Subscribe to notifications
      await fMsg.subscribeToTopic('all');
      saveFcmTokenForCurrentUser(userId);

      // 1️⃣1️⃣ Navigate to home
      Get.offAllNamed("/mainScreen");
      isLoading.value = false;

      return userCredential;
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future<void> resetPassword(String email) async {
    isLoading.value = true;
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.snackbar(
        "Reset Email Sent".tr,
        "Please check your inbox or spam folder.".tr,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
      Get.offAllNamed("/login1");
      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          "Error".tr,
          "No user found for that email.".tr,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
      } else {
        Get.snackbar(
          "Error".tr,
          e.message ?? "Something went wrong".tr,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
      }
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    isLoading.value = true;
    try {
      final user = auth.currentUser;
      //-------------------------------------------------------
      // لازم نكون متأكدين من إن المستخدم مش null
      if (user == null || user.email == null) {
        isLoading.value = false;
        throw FirebaseAuthException(
          code: 'user-not-logged-in',
          message: 'User is not logged in.',
        );
      }
      //-------------------------------------------------------
      // Get Current User Details
      final currenUserDetails =
          await db.collection("users").doc(auth.currentUser!.uid).get();
      //-------------------------------------------------------
      // Get fcmToken For current user
      final fcmToken = currenUserDetails.data()!["fcmToken"];
      //-------------------------------------------------------
      // 🔐 إعادة التحقق من هوية المستخدم
      final cred = EmailAuthProvider.credential(
          email: user.email!, password: currentPassword);
      await user.reauthenticateWithCredential(cred);
      //-------------------------------------------------------
      // ✅ تحديث كلمة المرور
      await user.updatePassword(newPassword);
      isLoading.value = false;
      Get.snackbar(
        "Success".tr,
        "Password changed successfully!".tr,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
      //-------------------------------------------------------
      // Send notification for this user
      adminController.sendPushNotificationToToken(
          token: fcmToken,
          title: "Password changed".tr,
          body: "your password changed successfully".tr);
      //-------------------------------------------------------
      // before => Delete old notification for the user
      await adminController
          .deleteOldNotificationsForUser(auth.currentUser!.uid);
      //-------------------------------------------------------
      // store notification in user collection for this user
      final notificationsRef = FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('notifications');
      await notificationsRef.add({
        'title': "Password changed".tr,
        'body': "your password changed successfully".tr,
        'sentAt': Timestamp.now(),
        'read': false,
      });
      //-------------------------------------------------------
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        isLoading.value = false;
        Get.snackbar(
          "Error".tr,
          "Current password is incorrect.".tr,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
      } else {
        isLoading.value = false;
        Get.snackbar(
          "Error".tr,
          e.message ?? "An error occurred.".tr,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Error".tr,
        "Something went wrong".tr,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    }
  }

  Future<void> deleteUserAccount(String userId) async {
    try {
      await db.collection("users").doc(userId).update({
        "status": "disabled",
      });
    } catch (e) {
      print("${"Error delete account".tr}: $e");
    }
  }

  Future<void> adminLogin(String email, String password) async {
    isLoading.value = true;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      await auth.currentUser!.reload();

      // check if account email isn't verified
      if (!auth.currentUser!.emailVerified) {
        Get.snackbar(
          "Email not verified".tr,
          "Please verify your email before logging in.".tr,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
        await auth.currentUser!.sendEmailVerification();
        await auth.signOut();
        isLoading.value = false;
        return;
      }
      final userId = auth.currentUser!.uid;
      // check if account is disabled
      final userDoc = await db.collection("users").doc(userId).get();
      if (userDoc.exists && userDoc.data()!["status"] == "disabled") {
        Get.snackbar(
          "Account Disabled".tr,
          "Your account has been disabled by the admin.".tr,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
        await auth.signOut();
        isLoading.value = false;
        return;
      }
      // check if ==> Admin Or Not !!
      if (userDoc.exists && userDoc.data()!["role"] != "admin") {
        Get.snackbar(
          "Access Denied".tr,
          "You are not an admin".tr,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
        await auth.signOut();
        isLoading.value = false;
        return;
      }
      // Update Login Date
      await db.collection("users").doc(userId).update({
        "loginDate": DateTime.now(),
      });
      saveFcmTokenForCurrentUser(userId);

      Get.offAllNamed("/adminDahsboard");

      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Get.snackbar(
          "Admin not found".tr,
          "No Admin found for that email.".tr,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
        isLoading.value = false;
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          "Wrong password".tr,
          "Wrong password provided for that user.".tr,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
        isLoading.value = false;
      }
    }
  }

  Future<void> adminResetPassword(String email) async {
    isLoading.value = true;
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.snackbar(
        "Reset Email Sent".tr,
        "Please check your inbox or spam folder.".tr,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
      Get.offAllNamed("/adminLogin");
      isLoading.value = false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          "Error".tr,
          "No admin found for that email.".tr,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
      } else {
        Get.snackbar(
          "Error".tr,
          e.message ?? "Something went wrong".tr,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
      }
    }
  }

  Future<void> saveFcmTokenForCurrentUser(String userId) async {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        final token = await fMsg.getToken();
        if (token != null) {
          await db.collection('users').doc(userId).update({
            'fcmToken': token,
          });
          print("✅ FCM token saved: $token");
        } else {
          print("❌ Failed to get FCM token.");
        }
      } else {
        // على Desktop أو Web -> تجاهل التوكن
        debugPrint('FCM token not supported on this platform');
      }
    } catch (e) {
      print("Error Svaing Token: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      canChangePassword.value = FirebaseAuth.instance.currentUser!.providerData
          .any((element) => element.providerId == "password");
    }
  }
}


  // Future<UserCredential> signInWithGoogle() async {
  //   isLoading.value = true;
  //   // ⭐️ Force sign out to always show account picker
  //   await GoogleSignIn().signOut();

  //   // Step 1: Start sign-in flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //   if (googleUser == null) throw Exception("User cancelled sign in");

  //   final GoogleSignInAuthentication googleAuth =
  //       await googleUser.authentication;

  //   // Step 2: Create credential and sign in
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );

  //   final userCredential = await auth.signInWithCredential(credential);
  //   final user = auth.currentUser;

  //   // Step 3: Check if user exists in Firestore
  //   final doc = await db.collection("users").doc(user!.uid).get();

  //   if (!doc.exists) {
  //     // Step 4: Add to Firestore if not found
  //     await initialUser(
  //         googleUser.displayName ?? "No Name", googleUser.email, "google");
  //   }
  //   final userId = auth.currentUser!.uid;

  //   // check if account is disabled
  //   final userDoc = await db.collection("users").doc(userId).get();
  //   if (userDoc.exists && userDoc.data()!["status"] == "disabled") {
  //     Get.snackbar(
  //       "Account Disabled".tr,
  //       "Your account has been disabled by the admin.".tr,
  //       snackPosition: SnackPosition.TOP,
  //       duration: const Duration(seconds: 3),
  //     );
  //     await auth.signOut();
  //     isLoading.value = false;
  //   }
  //   // Update Login Date
  //   await db.collection("users").doc(userId).update({
  //     "loginDate": DateTime.now(),
  //   });
  //   await fMsg.subscribeToTopic('all');
  //   saveFcmTokenForCurrentUser(userId);
  //   // Step 5: Navigate to home
  //   Get.offAllNamed("/mainScreen");
  //   isLoading.value = false;

  //   return userCredential;
  // }