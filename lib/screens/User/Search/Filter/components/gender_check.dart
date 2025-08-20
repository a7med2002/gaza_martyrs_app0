import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaza_martyer_app/controllers/User/filter_controller.dart';
import 'package:get/get.dart';

class GenderCheck extends StatelessWidget {
  final String gender;
  final String label;
  const GenderCheck({super.key, required this.gender, required this.label});

  @override
  Widget build(BuildContext context) {
    final filterController = Get.put(FilterController());

    return Obx(() {
      bool isSelected = filterController.selectedGender.contains(gender);

      return InkWell(
        onTap: () {
          if (!isSelected) {
            filterController.selectedGender.add(gender);
          } else {
            filterController.selectedGender.remove(gender);
          }
          print(filterController.selectedGender);
        },
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            height: 40,
            decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                SvgPicture.asset(
                  isSelected
                      ? "assets/svgs/check-circle.svg"
                      : "assets/svgs/tick-circle.svg",
                  width: 30,
                  height: 30,
                ),
                SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isSelected
                        ? Theme.of(context).colorScheme.onSecondaryContainer
                        : Theme.of(context).colorScheme.secondaryContainer,
                  ),
                )
              ],
            )),
      );
    });
  }
}
