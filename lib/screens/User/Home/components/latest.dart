import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/components/martyer_card.dart';
import 'package:gaza_martyer_app/controllers/User/stories_controller.dart';
import 'package:gaza_martyer_app/screens/User/Story/story_details.dart';
import 'package:get/get.dart';

class Latest extends StatelessWidget {
  const Latest({super.key});

  @override
  Widget build(BuildContext context) {
    StoriesController storiesController = Get.put(StoriesController());
    return RefreshIndicator(
      onRefresh: () async {
        await storiesController.loadLatestStories();
      },
      child: Obx(() => Stack(
            children: [
              Column(
                children: [
                  Expanded(
                      child: storiesController.latestStories.length == 0
                          ? Center(
                              child: Text(
                              "emptyStories".tr,
                              style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ))
                          : GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 0.58,
                              ),
                              itemCount: storiesController.latestStories.length,
                              itemBuilder: (context, index) {
                                return MartyerCard(
                                  martyerModel:
                                      storiesController.latestStories[index],
                                  onTap: () {
                                    Get.to(() => StoryDetails(
                                        martyerModel: storiesController
                                            .latestStories[index]));
                                  },
                                );
                              },
                            ))
                ],
              ),
              storiesController.isLoading.value
                  ? Positioned.fill(
                      child: Center(child: CircularProgressIndicator()))
                  : SizedBox.shrink()
            ],
          )),
    );
  }
}