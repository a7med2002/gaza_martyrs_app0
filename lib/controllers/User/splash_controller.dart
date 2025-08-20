import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;
  late Animation<double> rotationAnimation;

  bool isMobile() => !kIsWeb && (Platform.isAndroid || Platform.isIOS);
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    super.onInit();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    fadeAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeIn),
    );

    scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.elasticOut),
    );

    rotationAnimation = Tween<double>(begin: 0.0, end: 0.1).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    animationController.forward();

    Future.delayed(Duration(seconds: 2), () => checkUserRoleAndRedirect());
  }

  void checkUserRoleAndRedirect() async {
    final prefs = await SharedPreferences.getInstance();
    bool seenOnBoarding = prefs.getBool("seenOnBoarding") ?? false;
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      isMobile()
          ? (seenOnBoarding
              ? Get.offAllNamed("/login1")
              : Get.offAllNamed("/onBoarding"))
          : Get.offAllNamed("/adminLogin");
      return;
    }

    final userDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get();

    if (!userDoc.exists) {
      await FirebaseAuth.instance.signOut();
      isMobile() ? Get.offAllNamed("/login1") : Get.offAllNamed("/adminLogin");
      return;
    }

    final role = userDoc.data()!["role"];

    if (isMobile() && role == "user") {
      Get.offAllNamed("/mainScreen");
    } else if (!isMobile() && role == "admin") {
      Get.offAllNamed("/adminDahsboard");
    } else {
      await FirebaseAuth.instance.signOut();
      isMobile() ? Get.offAllNamed("/login1") : Get.offAllNamed("/adminLogin");
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
