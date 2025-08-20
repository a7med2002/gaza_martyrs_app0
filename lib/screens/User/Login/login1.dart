import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/components/cover_image.dart';
import 'package:gaza_martyer_app/components/custom_button.dart';
import 'package:gaza_martyer_app/components/logo_with_name.dart';
import 'package:gaza_martyer_app/screens/User/Login/components/custom_popup_container.dart';
import 'package:get/get.dart';

class Login1 extends StatelessWidget {
  const Login1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        CoverImage(),
        CustomPopupContainer(
            child: Column(
          children: [
            SizedBox(height: 20),
            LogoWithName(),
            SizedBox(height: 100),
            CustomButton(
              text: "login".tr,
              txtColor: Theme.of(context).colorScheme.onPrimary,
              btnColor: Theme.of(context).colorScheme.primary,
              withIcon: false,
              onTap: () {
                Get.toNamed("/login");
              },
              fontSize: 16,
            ),
            SizedBox(height: 16),
            CustomButton(
              text: "signUp".tr,
              txtColor: Theme.of(context).colorScheme.onPrimary,
              btnColor: Theme.of(context).colorScheme.primary,
              withIcon: false,
              onTap: () {
                Get.toNamed("/signup");
              },
              fontSize: 16,
            ),
            SizedBox(height: 100)
          ],
        ))
      ],
    ));
  }
}