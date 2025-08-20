import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {
  TextEditingController email = TextEditingController();
  RxString message = ''.obs;

  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final user = auth.currentUser;
    if (user != null) {
      email.text = user.email ?? '';
    }
  }

  Future<void> submitMessage() async {
    isLoading.value = true;
    try {
      await FirebaseFirestore.instance.collection("contact_messages").add({
        "email": email.text,
        "message": message.value.trim(),
        "sentAt": FieldValue.serverTimestamp(),
        "userId": FirebaseAuth.instance.currentUser!.uid,
      });

      message.value = ''; // Clear message after sending
      email.text = "";
      isLoading.value = false;
      Get.snackbar(
        "Success".tr,
        "Your message has been sent.".tr,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Error".tr,
        "${"Failed to send message".tr}: $e",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
