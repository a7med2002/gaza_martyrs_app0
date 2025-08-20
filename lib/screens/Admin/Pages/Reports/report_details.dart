import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/components/custom_button.dart';
import 'package:gaza_martyer_app/controllers/Admin/admin_controller.dart';
import 'package:gaza_martyer_app/controllers/User/report_controller.dart';
import 'package:gaza_martyer_app/screens/Admin/Components/my_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReportDetails extends StatelessWidget {
  const ReportDetails({super.key});

  @override
  Widget build(BuildContext context) {
    AdminController adminController = Get.put(AdminController());
    ReportController reportController = Get.put(ReportController());
    return Obx(() => Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      adminController.reportStorySelectedIndex.value = 0;
                    },
                    icon: Icon(Icons.arrow_back_ios, size: 24)),
                SizedBox(width: 16),
                Text("reportStoryDetails".tr,
                    style: TextStyle(
                        fontSize: 32,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 32),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(6)),
                child: Column(
                  spacing: 32,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 24,
                          children: [
                            // Reporting
                            Row(
                              children: [
                                Text(
                                  "${"reporting".tr}:    ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                ),
                                Text(
                                  adminController.emailReporter.value,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer),
                                ),
                              ],
                            ),
                            // Issue Type
                            Row(
                              children: [
                                Text(
                                  "${"issueType".tr}:   ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                ),
                                Text(
                                  reportController
                                      .selectedReport.value!.reportType.tr,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer),
                                ),
                              ],
                            ),
                            // Issue Desc
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${"issueDesc".tr}:   ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                ),
                                SizedBox(
                                  width: 350,
                                  child: Text(
                                    reportController
                                        .selectedReport.value!.message,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimaryContainer),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          spacing: 64,
                          children: [
                            SizedBox(
                              height: 150,
                              child: VerticalDivider(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                            Column(
                              spacing: 24,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Story Number
                                Row(
                                  children: [
                                    Text(
                                      "${"storyNumber".tr}: ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                    ),
                                    Text(
                                      "#1245",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimaryContainer),
                                    ),
                                  ],
                                ),
                                //Story History
                                Row(
                                  children: [
                                    Text(
                                      "${"storyHistory".tr}: ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                    ),
                                    Text(
                                      DateFormat('dd MMM yyyy').format(
                                          reportController.selectedStory.value!
                                              .submittedAt),
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimaryContainer),
                                    ),
                                  ],
                                ),
                                // Status
                                Row(
                                  children: [
                                    Text(
                                      "${"status".tr} : ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: Colors.lightGreen
                                              .withOpacity(0.2)),
                                      child: Text(
                                        reportController
                                            .selectedStory.value!.status,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.lightGreen),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    Divider(color: Theme.of(context).colorScheme.secondary),
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
                                  withIcon: false,
                                  onTap: () {
                                    adminController.selectedStory.value =
                                        reportController.selectedStory.value;

                                    adminController.selectedIndex.value = 1;

                                    Future.delayed(Duration(milliseconds: 200),
                                        () {
                                      adminController.storySelectedIndex.value =
                                          2;
                                    });
                                  },
                                  fontSize: 16),
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
                                      reportController.deleteReport(
                                          reportController
                                              .selectedReport.value!.id);
                                      adminController
                                          .reportStorySelectedIndex.value = 0;
                                    });
                                  },
                                  fontSize: 16,
                                  svgicon: "assets/svgs/Delete.svg"),
                            ),
                          ],
                        ),
                      ],
                    ),
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
                                    child: Image.network(
                                        reportController
                                            .selectedStory.value!.photoUrl,
                                        fit: BoxFit.cover,
                                        width: 40,
                                        height: 40)),
                                Text(
                                  "${reportController.selectedStory.value!.firstName} ${reportController.selectedStory.value!.lastName}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer),
                                ),
                                Text(
                                  "${reportController.selectedStory.value!.martyerAge} ${"years".tr}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer),
                                ),
                                Text(
                                  reportController
                                      .selectedStory.value!.martyerCity,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer),
                                ),
                                Text(
                                  "${reportController.selectedStory.value!.monthMartyer}, ${reportController.selectedStory.value!.yearMartyer}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer),
                                ),
                                Text(
                                  reportController
                                      .selectedStory.value!.jobMartyer,
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
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                              Text(
                                '''${reportController.selectedStory.value!.story}''',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                )),
          ],
        ));
  }
}
