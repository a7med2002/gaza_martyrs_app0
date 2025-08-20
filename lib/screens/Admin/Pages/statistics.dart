import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/components/custom_button.dart';
import 'package:gaza_martyer_app/controllers/User/statistics_controller.dart';
import 'package:gaza_martyer_app/screens/Admin/Components/custom_statistics_field.dart';
import 'package:get/get.dart';

class Statistics extends StatelessWidget {
  const Statistics({super.key});

  @override
  Widget build(BuildContext context) {
    StatisticsController statisticsController = Get.put(StatisticsController());
    return SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 80, vertical: 40),
          child: Stack(
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(6)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("editStatistics".tr,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                          TextButton(
                              onPressed: () {},
                              child: Text("resetAll".tr,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary)))
                        ],
                      ),
                      SizedBox(height: 32),
                      Column(
                        spacing: 24,
                        children: [
                          Row(
                            spacing: 32,
                            children: [
                              Expanded(
                                child: CustomStatisticsField(
                                    labelText: "martyerNumber".tr,
                                    controller: statisticsController
                                        .martyerNumberController),
                              ),
                              Expanded(
                                child: CustomStatisticsField(
                                    labelText: "maleMartyerNumber".tr,
                                    controller: statisticsController
                                        .maleMartyerController),
                              ),
                              Expanded(
                                child: CustomStatisticsField(
                                    labelText: "femaleMartyerNumber".tr,
                                    controller: statisticsController
                                        .femaleMartyerController),
                              )
                            ],
                          ),
                          Row(
                            spacing: 32,
                            children: [
                              Expanded(
                                child: CustomStatisticsField(
                                    labelText: "woundedNumbers".tr,
                                    controller: statisticsController
                                        .woundedNumbersController),
                              ),
                              Expanded(
                                child: CustomStatisticsField(
                                    labelText: "oldMartyerNumber".tr,
                                    controller: statisticsController
                                        .oldMartyerController),
                              ),
                              Expanded(
                                child: CustomStatisticsField(
                                    labelText: "childrenMartyerNumber".tr,
                                    controller: statisticsController
                                        .childrenMartyerController),
                              )
                            ],
                          ),
                          Row(
                            spacing: 32,
                            children: [
                              Expanded(
                                child: CustomStatisticsField(
                                    labelText: "massacresNumber".tr,
                                    controller: statisticsController
                                        .massacresController),
                              ),
                              Expanded(
                                child: CustomStatisticsField(
                                    labelText: "journalistsMartyerNumber".tr,
                                    controller: statisticsController
                                        .journalistsMartyerController),
                              ),
                              Expanded(
                                child: CustomStatisticsField(
                                    labelText: "doctorMartyerNumber".tr,
                                    controller: statisticsController
                                        .doctorMartyerController),
                              )
                            ],
                          ),
                          Row(
                            spacing: 32,
                            children: [
                              Expanded(
                                child: CustomStatisticsField(
                                    labelText: "missingNumber".tr,
                                    controller:
                                        statisticsController.missingController),
                              ),
                              Expanded(
                                child: CustomStatisticsField(
                                    labelText: "residentialUnitsNumber".tr,
                                    controller: statisticsController
                                        .residentialUnitsController),
                              ),
                              Expanded(
                                child: CustomStatisticsField(
                                    labelText: "prisoners".tr,
                                    controller: statisticsController
                                        .prisonersController),
                              )
                            ],
                          ),
                          SizedBox(height: 8),
                          SizedBox(
                            width: 145,
                            child: CustomButton(
                              text: "save".tr,
                              txtColor: Theme.of(context).colorScheme.onPrimary,
                              btnColor: Theme.of(context).colorScheme.primary,
                              withIcon: false,
                              onTap: () {
                                statisticsController.updateStatistics();
                              },
                              fontSize: 18,
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
              Obx(() => statisticsController.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : SizedBox.shrink())
            ],
          )),
    );
  }
}