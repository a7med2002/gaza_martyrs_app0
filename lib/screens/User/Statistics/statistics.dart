import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/components/custom_my_app_bar.dart';
import 'package:gaza_martyer_app/controllers/User/statistics_controller.dart';
import 'package:gaza_martyer_app/screens/User/Statistics/components/custom_statistic.dart';
import 'package:gaza_martyer_app/screens/User/Statistics/components/custom_sub_statistics.dart';
import 'package:get/get.dart';

class Statistics extends StatelessWidget {
  const Statistics({super.key});

  @override
  Widget build(BuildContext context) {
    final statisticsController = Get.put(StatisticsController());
    RxBool isShowSub = statisticsController.isShowSubStatistics;
    return Scaffold(
      appBar: CustomMyAppBar(title: "statistics".tr),
      body: Padding(
        padding: const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 0),
        child: SingleChildScrollView(
          child: Obx(() => Stack(
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          isShowSub.value = !isShowSub.value;
                          print(isShowSub);
                        },
                        child: CustomStatistic(
                          statisticText: "martyerNumber".tr,
                          statisticNumber:
                              statisticsController.martyerNumber.value,
                        ),
                      ),
                      isShowSub.value
                          ? Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                CustomSubStatistics(
                                    textSubStatistics: "males".tr,
                                    numberSubStatistics:
                                        statisticsController.maleMartyer.value),
                                CustomSubStatistics(
                                    textSubStatistics: "females".tr,
                                    numberSubStatistics: statisticsController
                                        .femaleMartyer.value),
                                CustomSubStatistics(
                                    textSubStatistics: "children".tr,
                                    numberSubStatistics: statisticsController
                                        .childrenMartyer.value),
                                CustomSubStatistics(
                                    textSubStatistics: "old".tr,
                                    numberSubStatistics:
                                        statisticsController.oldMartyer.value),
                                CustomSubStatistics(
                                    textSubStatistics: "journalists".tr,
                                    numberSubStatistics: statisticsController
                                        .journalistsMartyer.value),
                                CustomSubStatistics(
                                    textSubStatistics: "doctors".tr,
                                    numberSubStatistics: statisticsController
                                        .doctorMartyer.value),
                              ],
                            )
                          : SizedBox.shrink(),
                      CustomStatistic(
                        statisticText: "woundedNumbers".tr,
                        statisticNumber:
                            statisticsController.woundedNumbers.value,
                      ),
                      CustomStatistic(
                        statisticText: "massacres".tr,
                        statisticNumber: statisticsController.massacres.value,
                      ),
                      CustomStatistic(
                        statisticText: "missing".tr,
                        statisticNumber: statisticsController.missing.value,
                      ),
                      CustomStatistic(
                        statisticText: "residentialUnits".tr,
                        statisticNumber:
                            statisticsController.residentialUnits.value,
                      ),
                      CustomStatistic(
                        statisticText: "prisoners".tr,
                        statisticNumber: statisticsController.prisoners.value,
                      )
                    ],
                  ),
                  statisticsController.isLoading.value
                      ? Positioned.fill(
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : SizedBox.shrink()
                ],
              )),
        ),
      ),
    );
  }
}
