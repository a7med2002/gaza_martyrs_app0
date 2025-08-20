import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/config/colors.dart';
import 'package:gaza_martyer_app/screens/User/Home/home.dart';
import 'package:gaza_martyer_app/screens/User/More/more.dart';
import 'package:gaza_martyer_app/screens/User/Search/search.dart';
import 'package:gaza_martyer_app/screens/User/Statistics/statistics.dart';
import 'package:gaza_martyer_app/screens/User/Submit/submit_story.dart';
import 'package:get/get.dart';

class BottomNavController extends GetxController {
  RxInt currentindex = 0.obs;
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  void changeTap(int index) {
    currentindex.value = index;
  }

  final pages = [
    Home(),
    Search(),
    SubmitStory(),
    Statistics(),
    More(),
  ];

  Future<void> checkUserStatus() async {
    if (auth.currentUser != null) {
      final userDocs =
          await db.collection("users").doc(auth.currentUser!.uid).get();
      if (userDocs.data()?['status'] == "disabled") {
        await auth.signOut();
        Get.snackbar(
          "Account Disabled".tr,
          "Your account has been disabled by the admin.".tr,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
        Get.offAllNamed("/login");
      }
    }
  }

  @override
  void onInit() {
    checkUserStatus();
    super.onInit();
  }
}