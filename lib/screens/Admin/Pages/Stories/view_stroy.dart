import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/components/custom_button.dart';
import 'package:gaza_martyer_app/controllers/Admin/admin_controller.dart';
import 'package:gaza_martyer_app/controllers/User/stories_controller.dart';
import 'package:gaza_martyer_app/screens/Admin/Components/my_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ViewStroy extends StatelessWidget {
  const ViewStroy({super.key});

  @override
  Widget build(BuildContext context) {
    AdminController adminController = Get.put(AdminController());
    StoriesController storiesController = Get.put(StoriesController());
    return Obx(() {
      final story = adminController.selectedStory.value;
      final storyNumber = storiesController.postedStories
              .indexWhere((element) => element.id == story!.id) +
          1;
      if (story == null) {
        return Center(child: Text("noStorySelected".tr));
      }
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      adminController.storySelectedIndex.value = 0;
                    },
                    icon: Icon(Icons.arrow_back_ios, size: 24)),
                SizedBox(width: 16),
                Text("storyDetails".tr,
                    style: TextStyle(
                        fontSize: 32,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 32),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(6)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${"email".tr}: ",
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                          adminController.selectedStory.value!.submittedBy ==
                                  "admin"
                              ? Text(
                                  "admin".tr,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer),
                                )
                              : FutureBuilder(
                                  future: adminController
                                      .getUSerPulishedStory(story.submittedBy),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Text(
                                        "loading".tr,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimaryContainer),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text(
                                        "error".tr,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimaryContainer),
                                      );
                                    } else {
                                      final email = snapshot.data!;

                                      return Text(
                                        email,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimaryContainer),
                                      );
                                    }
                                  },
                                ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "${"storyNumber".tr}: ",
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                          Text(
                            "#$storyNumber",
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "${"storyHistory".tr}: ",
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                          Text(
                            DateFormat('dd MMM yyyy').format(story.submittedAt),
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "${"status".tr} : ",
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.lightGreen.withOpacity(0.2)),
                            child: Text(
                              story.status,
                              style: TextStyle(
                                  fontSize: 20, color: Colors.lightGreen),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 26),
                      child: Divider(
                          color: Theme.of(context).colorScheme.secondary)),
                  SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("storyInformation".tr,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 50,
                            child: CustomButton(
                                text: "edit".tr,
                                txtColor:
                                    Theme.of(context).colorScheme.secondary,
                                btnColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                withIcon: true,
                                onTap: () {
                                  adminController.storySelectedIndex.value = 2;
                                  adminController.selectedStory.value = story;
                                },
                                fontSize: 16,
                                svgColor:
                                    Theme.of(context).colorScheme.secondary,
                                svgicon: "assets/svgs/Edit.svg"),
                          ),
                          SizedBox(width: 16),
                          SizedBox(
                            width: 120,
                            height: 50,
                            child: CustomButton(
                                text: "delete".tr,
                                txtColor:
                                    Theme.of(context).colorScheme.onPrimary,
                                svgColor:
                                    Theme.of(context).colorScheme.onPrimary,
                                btnColor: Colors.red,
                                withIcon: true,
                                onTap: () {
                                  showMyDialog(
                                      context,
                                      Colors.red,
                                      "deleteStoryTitle".tr,
                                      "deleteStorySubTitle".tr,
                                      "delete".tr,
                                      Colors.red, () {
                                    storiesController.deleteStory(story.id);
                                    Get.back();
                                    adminController.storySelectedIndex.value =
                                        0;
                                  });
                                },
                                fontSize: 16,
                                svgicon: "assets/svgs/Delete.svg"),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 80,
                    children: [
                      Row(
                        spacing: 32,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 40,
                            children: [
                              Text(
                                "${"image".tr}: ",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                              Text(
                                "${"name".tr}: ",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                              Text(
                                "${"age".tr}: ",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                              Text(
                                "${"city".tr}: ",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                              Text(
                                "${"dateOfMartyrdom".tr}: ",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                              Text(
                                "${"job".tr}: ",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 40,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(story.photoUrl,
                                      fit: BoxFit.cover,
                                      width: 40,
                                      height: 40)),
                              Text(
                                "${story.firstName} ${story.midName} ${story.lastName}",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer),
                              ),
                              Text(
                                "${double.parse(story.martyerAge).toInt()} ${"years".tr}",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer),
                              ),
                              Text(
                                story.martyerCity,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer),
                              ),
                              Text(
                                "${story.monthMartyer}, ${story.yearMartyer}",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer),
                              ),
                              Text(
                                story.jobMartyer,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          spacing: 24,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${"storyDesc".tr} : ",
                              style: TextStyle(
                                  fontSize: 18,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                            Text(
                              '''${story.story}''',
                              style: TextStyle(
                                  fontSize: 18,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}