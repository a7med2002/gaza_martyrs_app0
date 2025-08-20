import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/components/cover_image.dart';
import 'package:gaza_martyer_app/components/custom_button.dart';
import 'package:gaza_martyer_app/components/custom_text_field.dart';
import 'package:gaza_martyer_app/config/colors.dart';
import 'package:gaza_martyer_app/controllers/User/auth_controller.dart';
import 'package:gaza_martyer_app/screens/User/Login/components/custom_popup_container.dart';
import 'package:gaza_martyer_app/screens/User/Login/components/header.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    AuthController authController = Get.put(AuthController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          CoverImage(),
          CustomPopupContainer(
              child: Column(
            children: [
              Header(text: "signUp".tr),
              SizedBox(height: 20),
              Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomTextField(
                          hintText: "name".tr,
                          svgSuffixIcon: 'assets/svgs/email.svg',
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "nameEmpty".tr;
                            }
                            return null;
                          },
                          isSecure: false,
                        ),
                        SizedBox(height: 16),
                        CustomTextField(
                          hintText: "email".tr,
                          svgSuffixIcon: 'assets/svgs/email.svg',
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "emailEmpty".tr;
                            }
                            return null;
                          },
                          isSecure: false,
                        ),
                        SizedBox(height: 16),
                        CustomTextField(
                          hintText: "password".tr,
                          svgSuffixIcon: 'assets/svgs/Lock.svg',
                          controller: passwordController,
                          validator: (value) {
                            return authController.validatePassword(value);
                          },
                          onChanged: (val) {
                            authController.password.value = val;
                          },
                          isSecure: true,
                        ),
                        SizedBox(height: 16),
                        CustomTextField(
                          hintText: "confirmPassword".tr,
                          svgSuffixIcon: 'assets/svgs/Lock.svg',
                          controller: confirmPasswordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "confirmPasswordEmpty".tr;
                            } else if (authController.password.value !=
                                authController.confirmPassword.value) {
                              return "passwordDontMmatch".tr;
                            }
                            return null;
                          },
                          onChanged: (val) {
                            authController.confirmPassword.value = val;
                          },
                          isSecure: true,
                        ),
                        SizedBox(height: 16),
                        // Create Account Button
                        CustomButton(
                          text: "createAccount".tr,
                          txtColor: Theme.of(context).colorScheme.onPrimary,
                          btnColor: Theme.of(context).colorScheme.primary,
                          withIcon: false,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              authController.createAccount(emailController.text,
                                  passwordController.text, nameController.text);
                              print(emailController.text);
                              print("success data");
                            }
                          },
                          fontSize: 16,
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                            Text(
                              "or".tr,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
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
                            txtColor: Theme.of(context).colorScheme.secondary,
                            btnColor:
                                Theme.of(context).colorScheme.primaryContainer,
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
                        //     txtColor: Theme.of(context).colorScheme.onPrimary,
                        //     btnColor: Theme.of(context)
                        //         .colorScheme
                        //         .onPrimaryContainer,
                        //     withIcon: true,
                        //     svgicon: 'assets/svgs/apple.svg',
                        //     onTap: () {},
                        //     fontSize: 16)
                      ],
                    ),
                  ))
            ],
          ))
        ],
      ),
    );
  }
}
