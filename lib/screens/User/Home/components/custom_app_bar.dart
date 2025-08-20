import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaza_martyer_app/screens/User/Favorite/favorite.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                "assets/logo/logo.png",
                width: 36,
                height: 36,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              "gazaMartyer".tr,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: Get.locale?.languageCode == 'ar'
                    ? "Jali Arabic"
                    : "Revalia",
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18,
              ),
            ),
          ],
        ),
        Row(
          children: [
            InkWell(
              onTap: () => Get.to(() => const Favorite()),
              child: SvgPicture.asset(
                "assets/svgs/Heart.svg",
                width: 30,
                height: 30,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 16),
            InkWell(
              onTap: () => Get.toNamed("/userNotifications"),
              child: SvgPicture.asset(
                "assets/svgs/Notification.svg",
                width: 30,
                height: 30,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}