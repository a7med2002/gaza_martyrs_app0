import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/components/cover_image.dart';
import 'package:gaza_martyer_app/components/custom_button.dart';
import 'package:gaza_martyer_app/components/custom_text_field.dart';
import 'package:gaza_martyer_app/screens/User/Login/components/custom_popup_container.dart';
import 'package:gaza_martyer_app/screens/User/Login/components/header.dart';
import 'package:get/get.dart';

class OtpCode extends StatelessWidget {
  const OtpCode({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController otpController = TextEditingController();
    return Scaffold(
      body: Stack(
        children: [
          CoverImage(),
          CustomPopupContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(text: "Enter OTP Code"),
                SizedBox(height: 32),
                Text(
                  "We sent code to your Email, Please Enter the code",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
                SizedBox(height: 24),
                CustomTextField(
                    hintText: "000000", svgSuffixIcon: 'assets/svgs/email.svg', controller: otpController, validator: (String? value) {
                      return null;
                      }, isSecure: false,),
                SizedBox(height: 220),
                CustomButton(
                  text: "Continue",
                  txtColor: Theme.of(context).colorScheme.onPrimary,
                  btnColor: Theme.of(context).colorScheme.primary,
                  withIcon: false,
                  onTap: () {
                    Get.toNamed("/resetPassword");
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
