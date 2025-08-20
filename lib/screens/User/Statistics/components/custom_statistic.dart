import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaza_martyer_app/controllers/Admin/theme_controller.dart';
import 'package:get/instance_manager.dart';

class CustomStatistic extends StatelessWidget {
  final String statisticText;
  final int statisticNumber;
  const CustomStatistic(
      {super.key, required this.statisticText, required this.statisticNumber});

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.find<ThemeController>();
    return Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: themeController.isDark.value
                  ? Colors.grey.withOpacity(0.7)
                  : Theme.of(context).colorScheme.primaryContainer,
            )),
        height: 100,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: SvgPicture.asset(
                  "assets/svgs/statistic-left.svg",
                  color: themeController.isDark.value ? Colors.red : null,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TweenAnimationBuilder<int>(
                    tween: IntTween(begin: 0, end: statisticNumber),
                    duration: const Duration(seconds: 3),
                    builder: (context, value, child) {
                      return Text(
                        "$value",
                        style: TextStyle(
                            fontSize: 24,
                            color: themeController.isDark.value
                                ? Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer
                                : Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  Text(
                    statisticText,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: themeController.isDark.value
                          ? const Color.fromARGB(255, 255, 162, 182)
                          : Theme.of(context).colorScheme.secondary,
                    ),
                  )
                ],
              ),
            ),
            Positioned(
                top: 0,
                right: 0,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: SvgPicture.asset(
                      "assets/svgs/statistic-right.svg",
                      color: themeController.isDark.value ? Colors.red : null,
                    )))
          ],
        ));
  }
}
