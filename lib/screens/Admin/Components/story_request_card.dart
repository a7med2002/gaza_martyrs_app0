import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaza_martyer_app/components/custom_button.dart';
import 'package:gaza_martyer_app/controllers/User/stories_controller.dart';
import 'package:gaza_martyer_app/controllers/User/submit_story_controller.dart';
import 'package:gaza_martyer_app/models/martyer_model.dart';
import 'package:gaza_martyer_app/screens/Admin/Components/my_dialog.dart';
import 'package:get/get.dart';

class StoryRequestCard extends StatelessWidget {
  final MartyerModel martyerModel;
  const StoryRequestCard({super.key, required this.martyerModel});

  @override
  Widget build(BuildContext context) {
    final SubmitStoryController submitStoryController =
        Get.put(SubmitStoryController());
    final StoriesController storiesController = Get.find<StoriesController>();

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        spacing: 16,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 2.0,
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                ),
              ),
            ),
            child: Row(
              spacing: 16,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.only(topLeft: Radius.circular(10)),
                  child: Image.network(
                    martyerModel.photoUrl,
                    fit: BoxFit.cover,
                    width: 70,
                    height: 105,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.image_not_supported, size: 70);
                    },
                  ),
                ),
                Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${martyerModel.firstName} ${martyerModel.lastName}",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${double.parse(martyerModel.martyerAge).toInt()} ${"years".tr} . ${martyerModel.martyerCity} . ${martyerModel.monthMartyer} ${martyerModel.yearMartyer}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              martyerModel.story,
              overflow: TextOverflow.ellipsis,
              maxLines: 8,
            ),
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.only(bottom: 24),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              spacing: 8,
              children: [
                // Reject Button
                Expanded(
                  child: CustomButton(
                    text: "reject".tr,
                    txtColor: Theme.of(context).colorScheme.onPrimary,
                    btnColor: Colors.red,
                    withIcon: false,
                    onTap: () {
                      showMyDialog(
                        context,
                        Colors.red,
                        "Are you sure about Reject a story?".tr,
                        "Once the story is rejected, the user will be notified that the story has been rejected and will be asked to read the terms and conditions in order to be able to post again"
                            .tr,
                        "Reject".tr,
                        Colors.red,
                        () {
                          storiesController.rejectDeleteStory(martyerModel.id);
                          Get.snackbar(
                            "success".tr,
                            "storyUpdatedSuccessfully".tr,
                            snackPosition: SnackPosition.TOP,
                            duration: const Duration(seconds: 3),
                          );
                          storiesController.loadPostedStories();
                          storiesController.fetchRequstedStories();
                          Get.back();
                        },
                      );
                    },
                    fontSize: 16,
                  ),
                ),

                // Accept Button
                Expanded(
                  child: CustomButton(
                    text: "accept".tr,
                    txtColor: Theme.of(context).colorScheme.onPrimary,
                    btnColor: Colors.green,
                    withIcon: false,
                    fontSize: 16,
                    onTap: () {
                      showMyDialog(
                        context,
                        Theme.of(context).colorScheme.secondary,
                        "sureAcceptStoryTitle".tr,
                        "sureAcceptStorySubTitle".tr.tr,
                        "accept".tr,
                        Colors.green,
                        () {
                          submitStoryController.updateStoryRequest(
                              martyerModel.id, "posted");
                          Get.snackbar(
                            "success".tr,
                            "storyPostedSuccessfully".tr,
                            snackPosition: SnackPosition.TOP,
                            duration: const Duration(seconds: 3),
                          );
                          storiesController.loadPostedStories();
                          storiesController.fetchRequstedStories();
                          Get.back();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
