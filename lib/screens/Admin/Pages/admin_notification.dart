import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/screens/Admin/Components/custom_notification.dart';
import 'package:get/get.dart';

class AdminNotification extends StatelessWidget {
  const AdminNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DefaultTabController(
        length: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
          child: Column(
            spacing: 24,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "notifications".tr,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  TabBar(
                    indicator: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6)),
                    isScrollable: true,
                    labelColor: Theme.of(context).colorScheme.primary,
                    labelStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    unselectedLabelColor:
                        Theme.of(context).colorScheme.secondary,
                    indicatorColor: Colors.transparent,
                    dividerColor: Colors.transparent,
                    tabs: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        child: Tab(text: "all".tr),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        child: Tab(text: "notRead".tr),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.5)),
              SizedBox(
                  height: 1000,
                  child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        // All Notification Content
                        Column(
                          spacing: 24,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Today
                            Text(
                              "today".tr,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            CustomNotification(
                              svgIcon: 'assets/svgs/newNotification.svg',
                              title: "requestToPublishStory".tr,
                              subTitle: "requestDetails".tr,
                              dateTime: '08:38 PM',
                            ),
                            CustomNotification(
                              svgIcon: 'assets/svgs/newNotification.svg',
                              title: "requestToPublishStory".tr,
                              subTitle: "requestDetails".tr,
                              dateTime: '08:38 PM',
                            ),
                            // This Week
                            Text(
                              "thisWeek".tr,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            CustomNotification(
                              svgIcon: 'assets/svgs/newNotification.svg',
                              title: "requestToPublishStory".tr,
                              subTitle: "requestDetails".tr,
                              dateTime: '08:38 PM',
                            ),
                            CustomNotification(
                              svgIcon: 'assets/svgs/newNotification.svg',
                              title: "requestToPublishStory".tr,
                              subTitle: "requestDetails".tr,
                              dateTime: '08:38 PM',
                            ),
                            // This Month
                            Text(
                              "thisMonth".tr,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            CustomNotification(
                              svgIcon: 'assets/svgs/newNotification.svg',
                              title: "requestToPublishStory".tr,
                              subTitle: "requestDetails".tr,
                              dateTime: '08:38 PM',
                            ),
                            CustomNotification(
                              svgIcon: 'assets/svgs/newNotification.svg',
                              title: "requestToPublishStory".tr,
                              subTitle: "requestDetails".tr,
                              dateTime: '08:38 PM',
                            ),
                          ],
                        ),
                        Center(
                          child: Text("notRead".tr),
                        )
                      ]))
            ],
          ),
        ),
      ),
    );
  }
}