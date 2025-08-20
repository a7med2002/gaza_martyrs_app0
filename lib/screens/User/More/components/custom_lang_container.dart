import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaza_martyer_app/locale/locale_controller.dart';
import 'package:get/get.dart';

class CustomLangContainer extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final String imagePath;
  const CustomLangContainer(
      {super.key,
      required this.title,
      required this.onTap,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    LocaleController changeLanguageController =
        Get.put(LocaleController());
    return Obx(() => InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
                color: changeLanguageController.language.value == title
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(6)),
            width: double.infinity,
            height: 60,
            child: ListTile(
              leading: Image.asset(
                imagePath,
                width: 34,
                height: 34,
              ),
              title: Text(
                title,
                style: TextStyle(
                    color: changeLanguageController.language.value == title
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold),
              ),
              trailing: SvgPicture.asset(
                  changeLanguageController.language.value == title
                      ? "assets/svgs/check-circle.svg"
                      : "assets/svgs/tick-circle.svg"),
            ),
          ),
        ));
  }
}
