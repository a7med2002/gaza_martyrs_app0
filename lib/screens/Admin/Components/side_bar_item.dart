import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaza_martyer_app/controllers/Admin/admin_controller.dart';
import 'package:get/get.dart';

class SideBarItem extends StatelessWidget {
  final String title;
  final String svgPath;
  final int index;
  const SideBarItem({super.key, required this.title, required this.svgPath, required this.index});

  @override
  Widget build(BuildContext context) {
    AdminController adminController = Get.put(AdminController());
    return Obx(() {
      final isSelected = adminController.selectedIndex.value == index;
      return Container(
        color: isSelected
            ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
            : Theme.of(context).colorScheme.onPrimary,
        height: 60,
        child: Center(
          child: ListTile(
            onTap: () => adminController.selectedIndex.value = index,
            leading: SvgPicture.asset(svgPath,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey[600]),
            title: Text(
              title,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondary),
            ),
          ),
        ),
      );
    });
  }
}
