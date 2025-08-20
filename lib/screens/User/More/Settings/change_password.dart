import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/components/custom_button.dart';
import 'package:gaza_martyer_app/components/custom_my_app_bar.dart';
import 'package:gaza_martyer_app/components/custom_text_field.dart';
import 'package:gaza_martyer_app/controllers/User/auth_controller.dart';
import 'package:get/get.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController currentPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmNewPasswordController = TextEditingController();
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    AuthController authController = Get.put(AuthController());

    return Scaffold(
      appBar: CustomMyAppBar(title: "changePassword".tr),
      body: Padding(
          padding: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                Column(
                  children: [
                    CustomTextField(
                      hintText: "currentPassword".tr,
                      svgSuffixIcon: "assets/svgs/Lock.svg",
                      controller: currentPasswordController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "emptyCurrentPassword".tr;
                        }
                        return null;
                      },
                      onChanged: (val) {
                        authController.currentPassword.value = val;
                      },
                      isSecure: true,
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      hintText: "newPassword".tr,
                      svgSuffixIcon: "assets/svgs/Lock.svg",
                      controller: newPasswordController,
                      validator: (String? value) {
                        if (authController.currentPassword.value == value) {
                          return "usedPassword".tr;
                        } else {
                          return authController.validatePassword(value);
                        }
                      },
                      onChanged: (val) {
                        authController.newPassword.value = val;
                      },
                      isSecure: true,
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      hintText: "confirmNewPassword".tr,
                      svgSuffixIcon: "assets/svgs/Lock.svg",
                      controller: confirmNewPasswordController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "pleaseConfirmPassword".tr;
                        } else if (authController.newPassword.value !=
                            authController.confirmNewPassword.value) {
                          return "passwordDontMatch".tr;
                        }
                        return null;
                      },
                      onChanged: (val) {
                        authController.confirmNewPassword.value = val;
                      },
                      isSecure: true,
                    ),
                    SizedBox(height: 24),
                    CustomButton(
                        text: "change".tr,
                        txtColor: Theme.of(context).colorScheme.onPrimary,
                        btnColor: Theme.of(context).colorScheme.primary,
                        withIcon: false,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            authController.changePassword(
                                currentPassword: currentPasswordController.text,
                                newPassword: newPasswordController.text);
                            currentPasswordController.clear();
                            confirmNewPasswordController.clear();
                            newPasswordController.clear();
                          }
                        },
                        fontSize: 16)
                  ],
                ),
                Obx(() => authController.isLoading.value
                    ? Positioned.fill(
                        child: Center(child: CircularProgressIndicator()))
                    : SizedBox.square())
              ],
            ),
          )),
    );
  }
}