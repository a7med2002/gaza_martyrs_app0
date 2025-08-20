import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaza_martyer_app/components/custom_button.dart';
import 'package:gaza_martyer_app/controllers/User/filter_controller.dart';
import 'package:gaza_martyer_app/screens/User/Search/Filter/components/job_select.dart';
import 'package:gaza_martyer_app/screens/User/Search/Filter/components/year_select.dart';
import 'package:gaza_martyer_app/screens/User/Search/Filter/components/age_slider.dart';
import 'package:gaza_martyer_app/screens/User/Search/Filter/components/city_select.dart';
import 'package:gaza_martyer_app/screens/User/Search/Filter/components/gender_check.dart';
import 'package:gaza_martyer_app/screens/User/Search/Filter/components/month_select.dart';
import 'package:get/get.dart';

class FilterSearch extends StatelessWidget {
  const FilterSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final filterController = Get.put(FilterController());
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
                    "assets/svgs/close-circle.svg",
                    color: Theme.of(context).colorScheme.primary,
                    width: 24,
                    height: 24,
                  ),
                ),
                centerTitle: true,
                title: Text(
                  "filter".tr,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                actions: [
                  SvgPicture.asset("assets/svgs/Heart.svg",
                      width: 30,
                      height: 30,
                      color: Theme.of(context).colorScheme.primary),
                ],
              ))),
      body: Padding(
          padding: EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Gender CheckBox
                    Text(
                      "gender".tr,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                            child: GenderCheck(
                          gender: 'Male', label: "male".tr,
                        )),
                        SizedBox(width: 16),
                        Expanded(
                            child: GenderCheck(
                          gender: 'Female', label: "female".tr,
                        ))
                      ],
                    ),
                    SizedBox(height: 32),

                    // Age RangeSlider
                    AgeSlider(),
                    SizedBox(height: 32),
                    // City Select
                    Text(
                      "city".tr,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    CitySelect(),
                    SizedBox(height: 32),

                    // Date of martyrdom
                    Text(
                      "dateOfMartyrdom".tr,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: MonthSelect()),
                        SizedBox(width: 8),
                        Expanded(child: YearSelect()),
                      ],
                    ),
                    SizedBox(height: 32),

                    // Job Select
                    Text(
                      "job".tr,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    JobSelect(),
                    SizedBox(height: 32),

                    // Apply Filter
                    CustomButton(
                        text: "applyFilter".tr,
                        txtColor: Theme.of(context).colorScheme.onPrimary,
                        btnColor: Theme.of(context).colorScheme.primary,
                        withIcon: false,
                        onTap: () {
                          filterController.applyFilter();
                        },
                        fontSize: 16),
                    SizedBox(height: 8),

                    // Clear Filter
                    CustomButton(
                        text: "clearAll".tr,
                        txtColor: Theme.of(context).colorScheme.secondary,
                        btnColor: Theme.of(context).colorScheme.onPrimary,
                        withIcon: false,
                        onTap: () {
                          filterController.clearAll();
                        },
                        fontSize: 16)
                  ],
                )
              ],
            ),
          )),
    );
  }
}