import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/components/custom_button.dart';
import 'package:gaza_martyer_app/controllers/User/stories_controller.dart';
import 'package:gaza_martyer_app/screens/Admin/Components/story_request_card.dart';
import 'package:get/get.dart';

class RequestStories extends StatelessWidget {
  const RequestStories({super.key});

  @override
  Widget build(BuildContext context) {
    StoriesController storiesController = Get.put(StoriesController());
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(6)),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
          child: FutureBuilder(
            future: storiesController.fetchRequstedStories(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              }
              final martyerStory = snapshot.data ?? [];
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${"storyRequest".tr} (${martyerStory.length})",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: CustomButton(
                            text: "sort".tr,
                            txtColor: Theme.of(context).colorScheme.onPrimary,
                            btnColor: Theme.of(context).colorScheme.primary,
                            withIcon: true,
                            onTap: () {},
                            fontSize: 18,
                            svgicon: "assets/svgs/sort.svg",
                            svgColor: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  martyerStory.length == 0
                      ? Center(
                          child: Text("emptyRequestStory".tr,
                              style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      Theme.of(context).colorScheme.secondary)))
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: martyerStory.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                  childAspectRatio: 4 / 4.6),
                          itemBuilder: (context, index) {
                            return StoryRequestCard(
                                martyerModel: martyerStory[index]);
                          },
                        ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
