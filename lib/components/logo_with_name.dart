import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/locale/locale_controller.dart';
import 'package:get/get.dart';

class LogoWithName extends StatelessWidget {
  const LogoWithName({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        Image.asset(
          "assets/logo/logo.png",
          width: 50,
          height: 50,
        ),
        Text(
          "gazaMartyer".tr,
          style: TextStyle(
              fontFamily:
                  Get.find<LocaleController>().language.value == "English"
                      ? "Revalia"
                      : "Jali Arabic",
              color: Theme.of(context).colorScheme.primary,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
