import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaza_martyer_app/controllers/Admin/theme_controller.dart';
import 'package:get/get.dart';

class CustomSubStatistics extends StatelessWidget {
  final String textSubStatistics;
  final int numberSubStatistics;
  const CustomSubStatistics({
    super.key,
    required this.textSubStatistics,
    required this.numberSubStatistics,
  });

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.find<ThemeController>();
    final double containerWidth = (MediaQuery.of(context).size.width / 2) - 30;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border:
            Border.all(color: Theme.of(context).colorScheme.primaryContainer),
      ),
      height: 80,
      width: containerWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset("assets/svgs/node.svg",
              color: themeController.isDark.value ? Colors.red : null),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TweenAnimationBuilder<int>(
                tween: IntTween(begin: 0, end: numberSubStatistics),
                duration: const Duration(seconds: 3),
                builder: (context, value, child) {
                  return Text(
                    "$value",
                    style: TextStyle(
                      fontSize: 20,
                      color: themeController.isDark.value
                          ? Theme.of(context).colorScheme.onPrimaryContainer
                          : Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              Text(
                textSubStatistics,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: themeController.isDark.value
                      ? const Color.fromARGB(255, 255, 162, 182)
                      : Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
          SvgPicture.asset("assets/svgs/node.svg",
              color: themeController.isDark.value ? Colors.red : null),
        ],
      ),
    );
  }
}
