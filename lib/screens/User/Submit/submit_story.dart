import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaza_martyer_app/components/custom_button.dart';
import 'package:gaza_martyer_app/controllers/User/submit_story_controller.dart';
import 'package:gaza_martyer_app/screens/User/Submit/components/martyer_age.dart';
import 'package:gaza_martyer_app/screens/User/Submit/components/martyer_city.dart';
import 'package:gaza_martyer_app/screens/User/Submit/components/martyer_gender.dart';
import 'package:gaza_martyer_app/screens/User/Submit/components/martyer_job.dart';
import 'package:gaza_martyer_app/screens/User/Submit/components/martyer_month.dart';
import 'package:gaza_martyer_app/screens/User/Submit/components/martyer_photo.dart';
import 'package:gaza_martyer_app/screens/User/Submit/components/martyer_story.dart';
import 'package:gaza_martyer_app/screens/User/Submit/components/martyer_year.dart';
import 'package:get/get.dart';

class SubmitStory extends StatelessWidget {
  const SubmitStory({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController firstNameController = TextEditingController();
    TextEditingController midNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController storyDescController = TextEditingController();
    final submitStoryController = Get.put(SubmitStoryController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
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
              "submitStory".tr,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              SizedBox(width: 16),
              InkWell(
                onTap: () {},
                child: SvgPicture.asset("assets/svgs/Heart.svg",
                    width: 30,
                    height: 30,
                    color: Theme.of(context).colorScheme.primary),
              ),
              SizedBox(width: 16),
              InkWell(
                onTap: () {},
                child: SvgPicture.asset("assets/svgs/Notification.svg",
                    width: 30,
                    height: 30,
                    color: Theme.of(context).colorScheme.primary),
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 0),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "writeStoryAbout".tr,
                        style: TextStyle(
                          fontFamily: "Jali Arabic",
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.secondary,
                        )),
                    TextSpan(
                        text: "martyer".tr,
                        style: TextStyle(
                          fontFamily: "Jali Arabic",
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                    TextSpan(
                        text: "martyerSubmitTitle".tr,
                        style: TextStyle(
                          fontFamily: "Jali Arabic",
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.secondary,
                        ))
                  ])),
                  SizedBox(height: 16),
                  // Submit Story Form
                  Form(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "martyerName".tr,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: firstNameController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(8)),
                                  disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(8)),
                                  filled: true,
                                  fillColor: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  hintText: "firstName".tr,
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withOpacity(0.7))),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: midNameController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(8)),
                                  disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(8)),
                                  filled: true,
                                  fillColor: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  hintText: "midName".tr,
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withOpacity(0.7))),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: lastNameController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(8)),
                                  disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(8)),
                                  filled: true,
                                  fillColor: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  hintText: "lastName".tr,
                                  hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withOpacity(0.7))),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "city".tr,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                MartyerCity(),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "gender".tr,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                MartyerGender(),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "age".tr,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                MartyerAge(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        "dateOfMartyrdom".tr,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(child: MartyerMonth()),
                          SizedBox(width: 8),
                          Expanded(child: MartyerYear()),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "martyerJob".tr,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                MartyerJob(),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "martyerPhoto".tr,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                MartyerPhoto(),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        "martyerStory".tr,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      MartyerStory(storyDescController: storyDescController),
                      SizedBox(height: 32),
                      CustomButton(
                          text: "submitStory".tr,
                          txtColor: Theme.of(context).colorScheme.onPrimary,
                          btnColor: Theme.of(context).colorScheme.primary,
                          withIcon: false,
                          onTap: () {
                            submitStoryController.firstName.value =
                                firstNameController.text;
                            submitStoryController.midName.value =
                                midNameController.text;
                            submitStoryController.lastName.value =
                                lastNameController.text;
                            submitStoryController.storyMartyer.value =
                                storyDescController.text;

                            if (!submitStoryController.validateFormFields())
                              return;
                            submitStoryController.submitStory();
                            firstNameController.clear();
                            midNameController.clear();
                            lastNameController.clear();
                            storyDescController.clear();
                          },
                          fontSize: 16),
                      SizedBox(height: 24),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "beforeSubmitCondition".tr,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "beforeSubmitCondition2".tr,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                          )
                        ],
                      )
                    ],
                  ))
                ],
              ),
              Obx(() {
                print("Loading: ${submitStoryController.isLoading.value}");
                return submitStoryController.isLoading.value
                    ? Positioned.fill(
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : const SizedBox.shrink();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
