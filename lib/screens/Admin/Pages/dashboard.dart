import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaza_martyer_app/controllers/Admin/admin_controller.dart';
import 'package:gaza_martyer_app/controllers/User/stories_controller.dart';
import 'package:gaza_martyer_app/screens/Admin/Components/custom_container.dart';
import 'package:gaza_martyer_app/screens/Admin/Components/my_dialog.dart';
import 'package:gaza_martyer_app/screens/Admin/Widgets/story_rate_chart.dart';
import 'package:gaza_martyer_app/screens/Admin/Widgets/visitors_chart.dart';
import 'package:get/get.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    AdminController adminController = Get.put(AdminController());
    StoriesController storiesController = Get.put(StoriesController());
    return SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 80),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomContainer(
                      title: "users".tr, userNumber: 14353, percentage: 5.26),
                  SizedBox(width: 24),
                  CustomContainer(
                      title: "activeUsers".tr, userNumber: 646, percentage: 3.26),
                  SizedBox(width: 24),
                  CustomContainer(
                      title: "newUsers".tr, userNumber: 49, percentage: 1.03),
                  SizedBox(width: 24),
                  CustomContainer(
                      title: "visits".tr, userNumber: 3274, percentage: 2.22),
                ],
              ),
              SizedBox(height: 32),
              Row(
                children: [
                  Expanded(flex: 2, child: StoryRateChart()),
                  SizedBox(width: 24),
                  Expanded(flex: 1, child: VisitorsChart())
                ],
              ),
              SizedBox(height: 32),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 28, vertical: 48),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("recentStory".tr,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          InkWell(
                              onTap: () {
                                adminController.selectedIndex.value = 1;
                              },
                              child: Text("viewAll".tr,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary))),
                        ],
                      ),
                      const SizedBox(height: 28),

                      // Header
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 8),
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.8),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6),
                                topRight: Radius.circular(6))),
                        child: Row(children: [
                          Expanded(
                              child: Center(
                                  child: Text("image".tr,
                                      style: TextStyle(color: Colors.white)))),
                          Expanded(
                              child: Center(
                                  child: Text("name".tr,
                                      style: TextStyle(color: Colors.white)))),
                          Expanded(
                              child: Center(
                                  child: Text("age".tr,
                                      style: TextStyle(color: Colors.white)))),
                          Expanded(
                              child: Center(
                                  child: Text("city".tr,
                                      style: TextStyle(color: Colors.white)))),
                          Expanded(
                              child: Center(
                                  child: Text("dateOfMartyrdom".tr,
                                      style: TextStyle(color: Colors.white)))),
                          Expanded(
                              child: Center(
                                  child: Text("story".tr,
                                      style: TextStyle(color: Colors.white)))),
                          Expanded(
                              child: Center(
                                  child: Text("edit".tr,
                                      style: TextStyle(color: Colors.white)))),
                          Expanded(
                              child: Center(
                                  child: Text("delete".tr,
                                      style: TextStyle(color: Colors.white)))),
                        ]),
                      ),

                      // Rows (repeat this Row for each item)
                      Obx(() {
                        final recentFiveStory =
                            storiesController.postedStories.value.length > 5
                                ? storiesController.postedStories.value
                                    .sublist(0, 5)
                                : storiesController.postedStories.value;
                        return recentFiveStory.isEmpty
                            ? Center(
                                child: Text("emptyStories".tr,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary)))
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: recentFiveStory.length,
                                itemBuilder: (context, index) {
                                  final story = recentFiveStory[index];
                                  return Column(
                                    children: [
                                      Container(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primaryContainer
                                            .withOpacity(0.3),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12),
                                        child: Row(
                                          children: [
                                            // Image
                                            Expanded(
                                                child: Center(
                                                    child: CircleAvatar(
                                                        radius: 20,
                                                        backgroundImage:
                                                            NetworkImage(story
                                                                .photoUrl)))),
                                            // Name
                                            Expanded(
                                                child: Center(
                                                    child: Text(
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        "${story.firstName} ${story.lastName}"))),
                                            // Age
                                            Expanded(
                                                child: Center(
                                                    child: Text(
                                                        "${double.parse(story.martyerAge).toInt()} ${"years".tr}"))),
                                            // City
                                            Expanded(
                                                child: Center(
                                                    child: Text(
                                                        story.martyerCity))),
                                            // Date of death
                                            Expanded(
                                                child: Center(
                                                    child: Text(
                                                        "${story.monthMartyer.tr}. ${story.yearMartyer}"))),
                                            // View story
                                            Expanded(
                                              child: Center(
                                                  child: InkWell(
                                                onTap: () async {
                                                  adminController
                                                      .selectedIndex.value = 1;
                                                  // لتأجيل التغيير والتحويل للصفحات
                                                  WidgetsBinding.instance
                                                      .addPostFrameCallback(
                                                          (_) {
                                                    adminController
                                                        .storySelectedIndex
                                                        .value = 1;
                                                    adminController
                                                        .selectedStory
                                                        .value = story;
                                                  });
                                                },
                                                child: Text("view".tr,
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        decoration:
                                                            TextDecoration
                                                                .underline)),
                                              )),
                                            ),
                                            // Edit
                                            Expanded(
                                              child: Center(
                                                child: InkWell(
                                                  onTap: () => adminController
                                                      .storySelectedIndex
                                                      .value = 2,
                                                  child: SvgPicture.asset(
                                                      "assets/svgs/Edit.svg",
                                                      width: 22,
                                                      height: 22),
                                                ),
                                              ),
                                            ),
                                            // Delete
                                            Expanded(
                                              child: Center(
                                                child: InkWell(
                                                  onTap: () {
                                                    showMyDialog(
                                                        context,
                                                        Colors.red,
                                                        "deleteDialogTitle".tr,
                                                        "deleteDialogSubTitle".tr,
                                                        "delete".tr,
                                                        Colors.red, () {
                                                      storiesController
                                                          .deleteStory(
                                                              story.id);
                                                      Get.back();
                                                    });
                                                  },
                                                  child: SizedBox(
                                                    child: SvgPicture.asset(
                                                        "assets/svgs/Delete.svg",
                                                        width: 22,
                                                        height: 22),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Divider
                                      Container(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primaryContainer
                                            .withOpacity(0.3),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 28),
                                        child: Divider(color: Colors.grey[300]),
                                      )
                                    ],
                                  );
                                },
                              );
                      })
                    ],
                  ))
            ],
          )),
    );
  }
}