import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/components/cover_image.dart';
import 'package:gaza_martyer_app/components/custom_button.dart';
import 'package:gaza_martyer_app/components/custom_text_field.dart';
import 'package:gaza_martyer_app/controllers/User/auth_controller.dart';
import 'package:gaza_martyer_app/screens/User/Login/components/custom_popup_container.dart';
import 'package:gaza_martyer_app/screens/User/Login/components/header.dart';
import 'package:get/get.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController forgetPasswordController = TextEditingController();
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final authController = Get.put(AuthController());

    return Scaffold(
      body: Stack(
        children: [
          CoverImage(),
          CustomPopupContainer(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(text: "forgetPassword".tr),
                  SizedBox(height: 32),
                  Text(
                    "enterEmailRecoverAccount".tr,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer),
                  ),
                  SizedBox(height: 24),
                  CustomTextField(
                    hintText: "email".tr,
                    svgSuffixIcon: 'assets/svgs/email.svg',
                    controller: forgetPasswordController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "emailEmpty".tr;
                      }
                      return null;
                    },
                    isSecure: false,
                  ),
                  SizedBox(height: 220),
                  CustomButton(
                    text: "submit".tr,
                    txtColor: Theme.of(context).colorScheme.onPrimary,
                    btnColor: Theme.of(context).colorScheme.primary,
                    withIcon: false,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        authController
                            .resetPassword(forgetPasswordController.text);
                      }
                    },
                    fontSize: 16,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}