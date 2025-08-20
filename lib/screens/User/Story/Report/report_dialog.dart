import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaza_martyer_app/components/custom_button.dart';
import 'package:gaza_martyer_app/controllers/User/report_controller.dart';
import 'package:gaza_martyer_app/models/martyer_model.dart';
import 'package:gaza_martyer_app/screens/User/Story/Report/components/issue_text_field.dart';
import 'package:gaza_martyer_app/screens/User/Story/Report/components/reason_report_select.dart';
import 'package:get/get.dart';

class ReportDialog extends StatelessWidget {
  final MartyerModel martyerModel;
  const ReportDialog({super.key, required this.martyerModel});

  @override
  Widget build(BuildContext context) {
    TextEditingController issueController = TextEditingController();
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final reportController = Get.put(ReportController());
    return InkWell(
      onTap: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          barrierColor: Colors.grey.shade200.withOpacity(0.8),
          builder: (context) {
            return Stack(
              children: [
                Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () => Get.back(),
                                  child: SvgPicture.asset(
                                    "assets/svgs/close-circle.svg",
                                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "reportIssue".tr,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox.shrink()
                              ],
                            ),
                            SizedBox(height: 16),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                                children: [
                                  TextSpan(text: "${"reportTitle".tr} "),
                                  TextSpan(
                                    text: "communityGuidelines".tr,
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 24),
                            Text(
                              "reasonForReporting".tr,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            ReasonReportSelect(),
                            SizedBox(height: 24),
                            Text(
                              "describeYourIssue".tr,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            IssueTextField(issueDescController: issueController),
                            SizedBox(height: 24),
                            Form(
                              child: CustomButton(
                                text: "report".tr,
                                txtColor: Theme.of(context).colorScheme.onPrimary,
                                btnColor: Theme.of(context).colorScheme.primary,
                                withIcon: false,
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    reportController.reportDescription.value = issueController.text;
                                    reportController.submitReport(storyId: martyerModel.id);
                                    issueController.clear();
                                    reportController.reportType.value = "";
                                  }
                                },
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(() => reportController.isLoading.value
                    ? Positioned.fill(
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : SizedBox.shrink())
              ],
            );
          },
        );
      },
      child: SvgPicture.asset(
        "assets/svgs/flag.svg",
        width: 30,
        height: 30,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}