import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/components/custom_button.dart';
import 'package:gaza_martyer_app/components/custom_text_field.dart';
import 'package:gaza_martyer_app/config/colors.dart';
import 'package:gaza_martyer_app/controllers/User/auth_controller.dart';
import 'package:get/get.dart';

class AdminLogin extends StatelessWidget {
  const AdminLogin({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final authController = Get.put(AuthController());
    return Scaffold(
      backgroundColor: dPrimaryColor,
      resizeToAvoidBottomInset: false,
      body: Obx(() => authController.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(6)),
                padding: EdgeInsets.all(24),
                width: 350,
                height: 380,
                child: Column(
                  children: [
                    Text("adminLogin".tr, style: TextStyle(fontSize: 24)),
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
                              hintText: "password".tr,
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
                                onTap: () =>
                                    Get.toNamed("/adminForgetPassword"),
                                child: Text(
                                  "forgetPassword".tr,
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            CustomButton(
                              text: "login".tr,
                              txtColor: Theme.of(context).colorScheme.onPrimary,
                              btnColor: Theme.of(context).colorScheme.primary,
                              withIcon: false,
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  authController.adminLogin(
                                      emailController.text,
                                      passwordController.text);
                                }
                              },
                              fontSize: 16,
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            )),
    );
  }
}