import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/components/martyer_card.dart';
import 'package:gaza_martyer_app/controllers/User/stories_controller.dart';
import 'package:gaza_martyer_app/screens/User/Story/story_details.dart';
import 'package:get/get.dart';

class Result extends StatelessWidget {
  final String searchName;
  const Result({super.key, required this.searchName});

  @override
  Widget build(BuildContext context) {
    StoriesController storiesController = Get.put(StoriesController());
    final filteredStories = storiesController.postedStories.where((story) {
      final fullName = "${story.firstName} ${story.lastName}";
      return fullName.toLowerCase().contains(searchName.toLowerCase());
    }).toList();

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24),
          Text(
            "results".tr,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.58,
              ),
              itemCount: filteredStories.length,
              itemBuilder: (context, index) {
                final story = filteredStories[index];
                return MartyerCard(
                  martyerModel: story,
                  onTap: () {
                    Get.to(() => StoryDetails(martyerModel: story));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}