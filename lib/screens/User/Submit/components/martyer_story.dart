import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/controllers/User/submit_story_controller.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MartyerStory extends StatelessWidget {
  TextEditingController storyDescController = TextEditingController();
  SubmitStoryController submitStoryController =
      Get.put(SubmitStoryController());
  MartyerStory({super.key, required this.storyDescController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: storyDescController,
      onChanged: (value) => submitStoryController.storyMartyer.value = value,
      maxLines: 6,
      decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8)),
          filled: true,
          fillColor: Theme.of(context).colorScheme.primaryContainer,
          hintText: "Write a story".tr,
          hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.7))),
    );
  }
}