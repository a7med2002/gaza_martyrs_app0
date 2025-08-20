import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/components/custom_my_app_bar.dart';
import 'package:get/get.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomMyAppBar(title: "aboutUs".tr),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset("assets/cover/aboutUs-image.png"),
              SizedBox(height: 16),
              Text(
                "aboutUsDetails".tr,
                style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onPrimaryContainer
                      .withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}