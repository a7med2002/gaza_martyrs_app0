import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/controllers/User/splash_controller.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final splashController = Get.put(SplashController());    
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: AnimatedBuilder(
            animation: splashController.animationController,
            builder: (context, child) {
              return Opacity(
                  opacity: splashController.fadeAnimation.value,
                  child: Transform.scale(
                    scale: splashController.scaleAnimation.value,
                    child: Transform.rotate(
                      angle: splashController.rotationAnimation.value,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset("assets/logo/app-logo.jpg",
                              width: 150, height: 150)),
                    ),
                  ));
            },
          ),
        ));
  }
}
