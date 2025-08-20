import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:gaza_martyer_app/controllers/User/submit_story_controller.dart';
import 'package:get/get.dart';

class MartyerAge extends StatelessWidget {
  const MartyerAge({super.key});

  @override
  Widget build(BuildContext context) {
    final submitStoryController = Get.put(SubmitStoryController());
    return SpinBox(
      min: 1,
      max: 120,
      value: double.tryParse(submitStoryController.martyerAge.value) ?? 1,
      textStyle: TextStyle(fontSize: 14),
      incrementIcon: Icon(Icons.add, size: 18),
      decrementIcon: Icon(Icons.remove, size: 18),
      decoration: InputDecoration(
        hintText: "age".tr,
        hintStyle: TextStyle(fontSize: 14),
        filled: true,
        fillColor: Theme.of(context).colorScheme.primaryContainer,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide.none),
      ),
      onChanged: (value) {
        submitStoryController.martyerAge.value = value.toString();
      },
    );
  }
}
