import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/components/custom_button.dart';
import 'package:gaza_martyer_app/components/custom_text_field.dart';
import 'package:gaza_martyer_app/config/colors.dart';
import 'package:gaza_martyer_app/controllers/User/auth_controller.dart';
import 'package:get/get.dart';

class AdminForgetPassword extends StatelessWidget {
  const AdminForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController forgetPasswordController = TextEditingController();
    final authController = Get.put(AuthController());

    return Scaffold(
      backgroundColor: dPrimaryColor,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(6)),
          padding: EdgeInsets.all(24),
          width: 350,
          height: 300,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_ios)),
                    Text("forgetPassword".tr, style: TextStyle(fontSize: 24)),
                    SizedBox(width: 2)
                  ],
                ),
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
                Spacer(),
                CustomButton(
                  text: "submit".tr,
                  txtColor: Theme.of(context).colorScheme.onPrimary,
                  btnColor: Theme.of(context).colorScheme.primary,
                  withIcon: false,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      authController
                          .adminResetPassword(forgetPasswordController.text);
                    }
                  },
                  fontSize: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}