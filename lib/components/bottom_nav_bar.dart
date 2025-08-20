import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaza_martyer_app/controllers/User/bottom_nav_controller.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavController = Get.put(BottomNavController());
    return Obx(() => BottomNavigationBar(
            onTap: (value) => bottomNavController.changeTap(value),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              buildNavItem(
                  svgIcon: "assets/svgs/Home.svg",
                  label: "home".tr,
                  index: 0,
                  currentIndex: bottomNavController.currentindex,
                  context: context),
              buildNavItem(
                  svgIcon: "assets/svgs/Search.svg",
                  label: "search".tr,
                  index: 1,
                  currentIndex: bottomNavController.currentindex,
                  context: context),
              buildNavItem(
                  svgIcon: "assets/svgs/Paper.svg",
                  label: "submit".tr,
                  index: 2,
                  currentIndex: bottomNavController.currentindex,
                  context: context),
              buildNavItem(
                  svgIcon: "assets/svgs/Graph.svg",
                  label: "statistics".tr,
                  index: 3,
                  currentIndex: bottomNavController.currentindex,
                  context: context),
              buildNavItem(
                  svgIcon: "assets/svgs/Category.svg",
                  label: "more".tr,
                  index: 4,
                  currentIndex: bottomNavController.currentindex,
                  context: context)
            ]));
  }
}

BottomNavigationBarItem buildNavItem({
  required String svgIcon,
  required String label,
  required int index,
  required RxInt currentIndex,
  required BuildContext context,
}) {
  final bool isSelected = index == currentIndex.value;
  return BottomNavigationBarItem(
    icon: isSelected
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(svgIcon,
                    width: 24,
                    height: 24,
                    color: Theme.of(context).colorScheme.primary),
                SizedBox(height: 10),
                Text(label,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 14)),
              ],
            ),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(svgIcon,
                  width: 24,
                  height: 24,
                  color: Theme.of(context).colorScheme.secondary),
              SizedBox(height: 10),
              Text(label,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 14)),
            ],
          ),
    label: '',
  );
}