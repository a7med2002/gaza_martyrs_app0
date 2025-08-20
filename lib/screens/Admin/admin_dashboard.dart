import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/controllers/Admin/admin_controller.dart';
import 'package:gaza_martyer_app/screens/Admin/Widgets/my_header.dart';
import 'package:gaza_martyer_app/screens/Admin/Widgets/sidebar.dart';
import 'package:get/get.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    AdminController adminController = Get.put(AdminController());
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Row(
        children: [
          // Sidebar
          Sidebar(),
          // Main content
          Expanded(
            child: Column(
              children: [
                Obx(() => MyHeader(
                      title: adminController
                          .titlePages[adminController.selectedIndex.value].tr,
                    )),
                Expanded(
                  child: Obx(() {
                    adminController.storySelectedIndex.value = 0;
                    return adminController
                        .pages[adminController.selectedIndex.value];
                  }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
