import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/controllers/Admin/admin_controller.dart';
import 'package:get/get.dart';

class Stories extends StatelessWidget {
  const Stories({super.key});

  @override
  Widget build(BuildContext context) {
    final adminController = Get.put(AdminController());
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 80),
        child: Obx(() => adminController.storiesPages[adminController.storySelectedIndex.value])
        );
  }
}