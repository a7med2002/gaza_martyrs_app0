import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeadContainer extends StatelessWidget {
  const HeadContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      height: 100,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Text(
              "bannerTitle".tr,
              style: TextStyle(
                fontFamily: Get.locale?.languageCode == 'ar' 
                    ? 'Jali Arabic' 
                    : "Salsa",
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 11),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              "assets/cover/palestine.png",
              fit: BoxFit.cover,
              width: 100,
              height: 70,
            ),
          ),
        ],
      ),
    );
  }
}