import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaza_martyer_app/controllers/Admin/admin_controller.dart';
import 'package:gaza_martyer_app/screens/User/Notifications/Components/custom_user_notification.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserNotification extends StatelessWidget {
  const UserNotification({super.key});

  @override
  Widget build(BuildContext context) {
    AdminController adminController = Get.put(AdminController());
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: AppBar(
                leadingWidth: 24,
                leading: InkWell(
                  onTap: () => Get.back(),
                  child: SvgPicture.asset(
                    "assets/svgs/Arrow.svg",
                    color: Theme.of(context).colorScheme.primary,
                    width: 24,
                    height: 24,
                  ),
                ),
                centerTitle: true,
                title: Text(
                  "notifications".tr,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                actions: [
                  SvgPicture.asset("assets/svgs/Notification.svg",
                      width: 30,
                      height: 30,
                      color: Theme.of(context).colorScheme.primary),
                ],
              ),
            )),
        body: Padding(
            padding: EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Today
                  Text(
                    "today".tr,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Obx(() {
                    return adminController.isLoading.value
                        ? Center(child: CircularProgressIndicator())
                        : adminController.notificationsList.isEmpty
                            ? Center(
                                child: Text("emptyNofications".tr),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: adminController
                                    .notificationsList.value.length,
                                itemBuilder: (context, index) {
                                  final notify = adminController
                                      .notificationsList.value[index];
                                  return Column(
                                    children: [
                                      CustomUserNotification(
                                          title: notify["title"],
                                          subTitle: notify['body'],
                                          time: DateFormat.jm().format(
                                              (notify['sentAt'] as Timestamp)
                                                  .toDate()),
                                          svgIcon:
                                              "assets/svgs/newNotification.svg"),
                                      SizedBox(height: 8)
                                    ],
                                  );
                                },
                              );
                  })
                ],
              ),
            )));
  }
}