import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/controllers/Admin/admin_controller.dart';
import 'package:get/get.dart';

class Report extends StatelessWidget {
  const Report({super.key});

  @override
  Widget build(BuildContext context) {
    AdminController adminController = Get.put(AdminController());
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 40),
        child: Obx(() => adminController
            .reportsPages[adminController.reportStorySelectedIndex.value]),
      ),
    );
  }
}
