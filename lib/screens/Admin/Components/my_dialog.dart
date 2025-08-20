import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaza_martyer_app/components/custom_button.dart';
import 'package:get/get.dart';

void showMyDialog(
    BuildContext context,
    Color iconColor,
    String title,
    String content,
    String txtConfirmBtn,
    Color colorConfirmBtn,
    VoidCallback onConfirm) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.3),
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Container(
            width: 450,
            padding: EdgeInsets.symmetric(horizontal: 48, vertical: 36),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  "assets/svgs/solar_danger-circle-outline.svg",
                  width: 135,
                  height: 135,
                  color: iconColor,
                ),
                SizedBox(height: 24),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 16),
                Text(
                  content,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: "cancel".tr,
                        txtColor: Theme.of(context).colorScheme.secondary,
                        btnColor: Theme.of(context).colorScheme.primaryContainer,
                        withIcon: false,
                        onTap: () => Get.back(),
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: CustomButton(
                        text: txtConfirmBtn,
                        txtColor: Theme.of(context).colorScheme.onPrimary,
                        btnColor: colorConfirmBtn,
                        withIcon: false,
                        onTap: onConfirm,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}