import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/controllers/User/filter_controller.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class AgeSlider extends StatelessWidget {
  const AgeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final filterController = Get.put(FilterController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "age".tr,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Obx(() => SfRangeSlider(
            min: 1,
            max: 120,
            values: filterController.selectedAgeRange.value,
            showTicks: true,
            showLabels: true,
            enableTooltip: true,
            minorTicksPerInterval: 1,
            activeColor: Theme.of(context).colorScheme.primary,
            inactiveColor:
                Theme.of(context).colorScheme.secondary.withOpacity(0.5),
            onChanged: (SfRangeValues values) {
              filterController.selectedAgeRange.value = SfRangeValues(
                values.start.roundToDouble(),
                values.end.roundToDouble(),
              );
            },
            tooltipTextFormatterCallback:
                (dynamic actualValue, String formattedText) {
              return actualValue.toInt().toString();
            })),
      ],
    );
  }
}