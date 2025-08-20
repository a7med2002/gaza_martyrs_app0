import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/components/martyer_card.dart';
import 'package:gaza_martyer_app/controllers/User/stories_controller.dart';
import 'package:gaza_martyer_app/screens/User/Story/story_details.dart';
import 'package:get/get.dart';

class ForYou extends StatelessWidget {
  const ForYou({super.key});

  @override
  Widget build(BuildContext context) {
    StoriesController storiesController = Get.put(StoriesController());
    return RefreshIndicator(
      onRefresh: () async {
        await storiesController.loadForYouStories();
      },
      child: Obx(() => Stack(
            children: [
              Column(
                children: [
                  Expanded(
                      child: storiesController.forYouStories.isEmpty
                          ? Center(
                              child: Text(
                              "emptyStories".tr,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.secondary),
                            ))
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 0.58,
                              ),
                              itemCount: storiesController.forYouStories.length,
                              itemBuilder: (context, index) {
                                return MartyerCard(
                                  martyerModel:
                                      storiesController.forYouStories[index],
                                  onTap: () {
                                    Get.to(() => StoryDetails(
                                        martyerModel: storiesController
                                            .forYouStories[index]));
                                  },
                                );
                              },
                            ))
                ],
              ),
              storiesController.isLoading.value
                  ? const Positioned.fill(
                      child: Center(child: CircularProgressIndicator()))
                  : const SizedBox.shrink()
            ],
          )),
    );
  }
}