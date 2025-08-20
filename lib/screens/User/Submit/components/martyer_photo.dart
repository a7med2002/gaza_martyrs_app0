import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaza_martyer_app/controllers/User/submit_story_controller.dart';
import 'package:get/get.dart';

class MartyerPhoto extends StatelessWidget {
  const MartyerPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    final submitStoryController = Get.put(SubmitStoryController());
    return Obx(() => submitStoryController.imagePickedPath.isEmpty
        ? InkWell(
            onTap: () async {
              await submitStoryController.pickImage();
              print(submitStoryController.imagePickedPath.value);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              height: 60,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "putAPicture".tr,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  SvgPicture.asset(
                    "assets/svgs/link-2.svg",
                    width: 24,
                    height: 24,
                  )
                ],
              ),
            ),
          )
        : InkWell(
            onTap: () {
              submitStoryController.imagePickedPath.value = '';
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              height: 60,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "uploded".tr,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  SvgPicture.asset(
                    "assets/svgs/close-circle.svg",
                    color: Theme.of(context).colorScheme.primary,
                    width: 24,
                    height: 24,
                  )
                ],
              ),
            ),
          ));
  }
}