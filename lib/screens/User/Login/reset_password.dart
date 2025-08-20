import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/components/cover_image.dart';
import 'package:gaza_martyer_app/components/custom_button.dart';
import 'package:gaza_martyer_app/components/custom_text_field.dart';
import 'package:gaza_martyer_app/screens/User/Login/components/custom_popup_container.dart';
import 'package:gaza_martyer_app/screens/User/Login/components/header.dart';
import 'package:get/get.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
     TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    return Scaffold(
      body: Stack(
        children: [
          CoverImage(),
          CustomPopupContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(text: "Reset Password".tr),
                SizedBox(height: 32),
                Text(
                  "Enter your email to recover your account".tr,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
                SizedBox(height: 24),
                CustomTextField(
                    hintText: "New Password".tr,
                    svgSuffixIcon: 'assets/svgs/Lock.svg', controller: newPasswordController, validator: (String? value) {
                      return null;
                      }, isSecure: true,),
                SizedBox(height: 12),
                CustomTextField(
                    hintText: "Confirm Password".tr,
                    svgSuffixIcon: 'assets/svgs/Lock.svg', controller: confirmPasswordController, validator: (String? value) {
                      return null;
                      }, isSecure: true,),
                SizedBox(height: 150),
                CustomButton(
                  text: "Change".tr,
                  txtColor: Theme.of(context).colorScheme.onPrimary,
                  btnColor: Theme.of(context).colorScheme.primary,
                  withIcon: false,
                  onTap: () {
                    Get.offAllNamed('/login1');
                    Future.delayed(
                      Duration(milliseconds: 50),
                      () => Get.toNamed('login'),
                    );
                  },
                  fontSize: 16,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
