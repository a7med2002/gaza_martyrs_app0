import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaza_martyer_app/components/custom_button.dart';
import 'package:gaza_martyer_app/controllers/Admin/admin_controller.dart';
import 'package:gaza_martyer_app/controllers/User/report_controller.dart';
import 'package:gaza_martyer_app/models/martyer_model.dart';
import 'package:gaza_martyer_app/screens/Admin/Components/my_dialog.dart';
import 'package:get/get.dart';

class ReportTable extends StatelessWidget {
  const ReportTable({super.key});

  @override
  Widget build(BuildContext context) {
    AdminController adminController = Get.put(AdminController());
    ReportController reportController = Get.put(ReportController());
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(6)),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Text(
                    "${"storyReport".tr} (${reportController.reports.length})",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
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
          SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6), topRight: Radius.circular(6))),
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
                      child: Text("report".tr,
                          style: TextStyle(color: Colors.white)))),
              Expanded(
                  child: Center(
                      child: Text("numReport".tr,
                          style: TextStyle(color: Colors.white)))),
              Expanded(
                  child: Center(
                      child: Text("delete".tr,
                          style: TextStyle(color: Colors.white)))),
            ]),
          ),
          // Repeat Reports
          Obx(() {
            final reports = reportController.reports;
            return reports.length == 0
                ? Center(
                    child: Text(
                    "emptyReports".tr,
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.secondary),
                  ))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: reports.length,
                    itemBuilder: (context, index) {
                      final report = reports[index];
                      final reportNumber =
                          reportController.reportCountPerStory(report.storyId);
                      return FutureBuilder<MartyerModel>(
                        future: reportController.getStoryById(report.storyId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting)
                            return Center(child: Text("loading".tr));
                          final story = snapshot.data!;
                          return Column(
                            children: [
                              Container(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer
                                    .withOpacity(0.3),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Row(
                                  children: [
                                    // Image
                                    Expanded(
                                        child: Center(
                                            child: CircleAvatar(
                                                radius: 20,
                                                backgroundImage: NetworkImage(
                                                    story.photoUrl)))),
                                    // Name
                                    Expanded(
                                        child: Center(
                                            child: Text(
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                "${story.firstName} ${story.lastName}"))),
                                    // Age
                                    Expanded(
                                        child: Center(
                                            child: Text(
                                                "${story.martyerAge} ${"years".tr}"))),
                                    // City
                                    Expanded(
                                        child: Center(
                                            child: Text(story.martyerCity))),
                                    // Date of death
                                    Expanded(
                                        child: Center(
                                            child: Text(
                                                "${story.monthMartyer.tr} . ${story.yearMartyer}"))),
                                    // View Report
                                    Expanded(
                                      child: Center(
                                          child: InkWell(
                                        onTap: () {
                                          adminController
                                              .reportStorySelectedIndex
                                              .value = 1;
                                          adminController.getEmailReporter(
                                              report.reporterId);
                                          reportController
                                              .selectedReport.value = report;
                                          reportController.selectedStory.value =
                                              story;
                                        },
                                        child: Text("view".tr,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                fontWeight: FontWeight.bold,
                                                decoration:
                                                    TextDecoration.underline)),
                                      )),
                                    ),
                                    // Report Number
                                    Expanded(
                                        child: Center(
                                            child: Text("$reportNumber"))),
                                    // Delete
                                    Expanded(
                                      child: Center(
                                        child: InkWell(
                                          onTap: () {
                                            showMyDialog(
                                                context,
                                                Colors.red,
                                                "deleteStoryTitle".tr,
                                                "deleteReportSubTitle".tr,
                                                "delete".tr,
                                                Colors.red, () {
                                              reportController
                                                  .deleteReport(report.id);
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 28),
                                child: Divider(color: Colors.grey[300]),
                              )
                            ],
                          );
                        },
                      );
                    },
                  );
          }),
        ],
      ),
    );
  }
}
