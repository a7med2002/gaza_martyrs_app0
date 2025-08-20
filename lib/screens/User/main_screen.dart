import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/components/bottom_nav_bar.dart';
import 'package:gaza_martyer_app/controllers/User/bottom_nav_controller.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavController bbottomNavController =
        Get.put(BottomNavController());
    return Scaffold(
      body: Obx(
        () =>
            bbottomNavController.pages[bbottomNavController.currentindex.value],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
