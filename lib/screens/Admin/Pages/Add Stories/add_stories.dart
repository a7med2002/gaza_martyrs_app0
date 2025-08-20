import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/controllers/Admin/tab_add_story_controller.dart';
import 'package:gaza_martyer_app/screens/Admin/Pages/Add%20Stories/widgets/add_martyer_story.dart';
import 'package:gaza_martyer_app/screens/Admin/Pages/Add%20Stories/widgets/add_massacre.dart';
import 'package:gaza_martyer_app/screens/Admin/Pages/Add%20Stories/widgets/add_other.dart';
import 'package:get/get.dart';

class AddStories extends StatelessWidget {
  const AddStories({super.key});

  @override
  Widget build(BuildContext context) {
    TabAddStoryController tabAddStoryController =
        Get.put(TabAddStoryController());
    return DefaultTabController(
      length: 3,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Martyer / Massacres / Other Story".tr,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 32),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 32),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: 600,
                      child: TabBar(
                        onTap: (tabIndex) => tabAddStoryController
                            .selectedTabIndex.value = tabIndex,
                        unselectedLabelColor:
                            Theme.of(context).colorScheme.secondary,
                        indicatorColor: Theme.of(context).colorScheme.primary,
                        dividerColor: Colors.transparent,
                        labelStyle:
                            TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        tabs: [
                          Tab(text: "addMartyer".tr),
                          Tab(text: "addMassacres".tr),
                          Tab(text: "otherStory".tr),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    Obx(() {
                      if (tabAddStoryController.selectedTabIndex.value == 0) {
                        return AddMartyerStory();
                      } else if (tabAddStoryController.selectedTabIndex.value ==
                          1) {
                        return AddMassacre();
                      } else {
                        return AddOther();
                      }
                    })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}