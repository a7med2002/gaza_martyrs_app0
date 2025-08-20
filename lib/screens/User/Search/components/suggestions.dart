import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/components/martyer_card.dart';
import 'package:gaza_martyer_app/controllers/User/stories_controller.dart';
import 'package:gaza_martyer_app/screens/User/Story/story_details.dart';
import 'package:get/get.dart';

class Suggestions extends StatelessWidget {
  const Suggestions({super.key});

  @override
  Widget build(BuildContext context) {
    StoriesController storiesController = Get.put(StoriesController());
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24),
          Text(
            "suggestions".tr,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Expanded(
            child: storiesController.postedStories.length == 0
                ? Center(
                    child: Text("emptyStories".tr,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 16)))
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.58,
                    ),
                    itemCount: storiesController.postedStories.length > 6
                        ? 6
                        : storiesController.postedStories.length,
                    itemBuilder: (context, index) {
                      return MartyerCard(
                        martyerModel: storiesController.postedStories[index],
                        onTap: () {
                          Get.to(() => StoryDetails(
                              martyerModel:
                                  storiesController.postedStories[index]));
                        },
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}
