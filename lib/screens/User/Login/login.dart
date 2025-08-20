import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/components/cover_image.dart';
import 'package:gaza_martyer_app/components/custom_button.dart';
import 'package:gaza_martyer_app/components/custom_text_field.dart';
import 'package:gaza_martyer_app/config/colors.dart';
import 'package:gaza_martyer_app/controllers/User/auth_controller.dart';
import 'package:gaza_martyer_app/screens/User/Login/components/custom_popup_container.dart';
import 'package:gaza_martyer_app/screens/User/Login/components/header.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final authController = Get.put(AuthController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(() => authController.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                CoverImage(),
                CustomPopupContainer(
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Header(text: "login".tr),
                        SizedBox(height: 20),
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                CustomTextField(
                                  hintText: "email".tr,
                                  svgSuffixIcon: 'assets/svgs/email.svg',
                                  controller: emailController,
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "emailEmpty".tr;
                                    }
                                    return null;
                                  },
                                  isSecure: false,
                                ),
                                SizedBox(height: 16),
                                CustomTextField(
                                  hintText: 'password'.tr,
                                  svgSuffixIcon: 'assets/svgs/Lock.svg',
                                  controller: passwordController,
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return "passwordEmpty".tr;
                                    }
                                    return null;
                                  },
                                  isSecure: true,
                                ),
                                SizedBox(height: 16),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: InkWell(
                                    onTap: () => Get.toNamed("/forgetPassword"),
                                    child: Text(
                                      "forgetPassword".tr,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                CustomButton(
                                  text: "login".tr,
                                  txtColor:
                                      Theme.of(context).colorScheme.onPrimary,
                                  btnColor:
                                      Theme.of(context).colorScheme.primary,
                                  withIcon: false,
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      authController.login(emailController.text,
                                          passwordController.text);
                                      print("success");
                                    }
                                  },
                                  fontSize: 16,
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("dontHaveAccount".tr,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        )),
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed("/signup");
                                      },
                                      child: Text("signUp".tr,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    )
                                  ],
                                ),
                                SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Divider(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                    ),
                                    Text(
                                      "or".tr,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                    ),
                                    Expanded(
                                        child: Divider(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary))
                                  ],
                                ),
                                SizedBox(height: 16),
                                CustomButton(
                                    text: "continueWithGoogle".tr,
                                    txtColor:
                                        Theme.of(context).colorScheme.secondary,
                                    btnColor: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    withIcon: true,
                                    svgicon: 'assets/svgs/google.svg',
                                    svgColor: dPrimaryColor,
                                    onTap: () {
                                      authController.signInWithGoogle();
                                    },
                                    fontSize: 16),
                                // SizedBox(height: 12),
                                // CustomButton(
                                //     text: "continueWithApple".tr,
                                //     txtColor:
                                //         Theme.of(context).colorScheme.onPrimary,
                                //     btnColor: Theme.of(context)
                                //         .colorScheme
                                //         .onPrimaryContainer,
                                //     withIcon: true,
                                //     svgicon: 'assets/svgs/apple.svg',
                                //     onTap: () {},
                                //     fontSize: 16)
                              ],
                            ))
                      ],
                    ),
                  ),
                )
              ],
            )),
    );
  }
}
