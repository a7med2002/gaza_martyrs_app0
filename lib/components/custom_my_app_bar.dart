import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaza_martyer_app/screens/User/Favorite/favorite.dart';
import 'package:get/get.dart';

class CustomMyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomMyAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: AppBar(
          leadingWidth: 24,
          leading: InkWell(
            onTap: () => Get.back(),
            child: SvgPicture.asset(
              "assets/svgs/Arrow.svg",
              color: Theme.of(context).colorScheme.primary,
              width: 24,
              height: 24,
            ),
          ),
          centerTitle: true,
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            SizedBox(width: 16),
            InkWell(
              onTap: () {
                Get.to(() => const Favorite());
              },
              child: SvgPicture.asset("assets/svgs/Heart.svg",
                  width: 30,
                  height: 30,
                  color: Theme.of(context).colorScheme.primary),
            ),
            SizedBox(width: 16),
            InkWell(
              onTap: () => Get.toNamed("/userNotifications"),
              child: SvgPicture.asset("assets/svgs/Notification.svg",
                  width: 30,
                  height: 30,
                  color: Theme.of(context).colorScheme.primary),
            )
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
