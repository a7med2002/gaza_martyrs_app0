import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/components/custom_button.dart';
import 'package:gaza_martyer_app/controllers/Admin/admin_controller.dart';
import 'package:gaza_martyer_app/controllers/User/submit_story_controller.dart';
import 'package:gaza_martyer_app/screens/User/Submit/components/martyer_age.dart';
import 'package:gaza_martyer_app/screens/User/Submit/components/martyer_city.dart';
import 'package:gaza_martyer_app/screens/User/Submit/components/martyer_gender.dart';
import 'package:gaza_martyer_app/screens/User/Submit/components/martyer_job.dart';
import 'package:gaza_martyer_app/screens/User/Submit/components/martyer_month.dart';
import 'package:gaza_martyer_app/screens/User/Submit/components/martyer_story.dart';
import 'package:gaza_martyer_app/screens/User/Submit/components/martyer_year.dart';
import 'package:get/get.dart';

class EditStory extends StatelessWidget {
  const EditStory({super.key});

  @override
  Widget build(BuildContext context) {
    AdminController adminController = Get.put(AdminController());
    SubmitStoryController submitStoryController =
        Get.put(SubmitStoryController());
    TextEditingController firstNameController = TextEditingController();
    TextEditingController midNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController storyDescController = TextEditingController();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    adminController.storySelectedIndex.value = 0;
                  },
                  icon: Icon(Icons.arrow_back_ios, size: 24)),
              SizedBox(width: 16),
              Text("editStory".tr,
                  style: TextStyle(
                      fontSize: 32,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 32),
          Obx(() {
            final story = adminController.selectedStory.value;
            if (story != null) {
              submitStoryController.initEditFields(story);
              firstNameController.text = story.firstName;
              midNameController.text = story.midName;
              lastNameController.text = story.lastName;
              storyDescController.text = story.story;
            }
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(6)),
              child: Row(
                spacing: 64,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Martyer Name
                        Text(
                          "martyerName".tr,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                        Row(
                          spacing: 16,
                          children: [
                            Expanded(
                                child: TextFormField(
                              controller: firstNameController,
                              onChanged: (value) =>
                                  submitStoryController.firstName.value = value,
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
                            )),
                            Expanded(
                                child: TextFormField(
                              controller: midNameController,
                              onChanged: (value) =>
                                  submitStoryController.midName.value = value,
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
                            )),
                            Expanded(
                                child: TextFormField(
                              controller: lastNameController,
                              onChanged: (value) =>
                                  submitStoryController.lastName.value = value,
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
                            )),
                          ],
                        ),

                        SizedBox(height: 32),
                        // Martyer Gender
                        Text(
                          "martyerGender".tr,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                        MartyerGender(),
                        SizedBox(height: 32),
                        // Martyer City
                        Text(
                          "martyerCity".tr,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                        MartyerCity(),
                        SizedBox(height: 32),
                        // Martyer Age
                        Text(
                          "martyerAge".tr,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                        MartyerAge(),
                        SizedBox(height: 32),
                        // Martyer Date
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

                        SizedBox(height: 32),
                        // Martyer Job
                        Text(
                          "martyerJob".tr,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                        MartyerJob(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Martyer Image
                        Text(
                          "martyerImage".tr,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                        InkWell(
                          onTap: () => Future.delayed(Duration.zero, () {
                            submitStoryController.pickImage();
                          }),
                          child: DottedBorder(
                            color: Theme.of(context).colorScheme.secondary,
                            strokeWidth: 1.5,
                            dashPattern: [6, 3],
                            borderType: BorderType.RRect,
                            radius: Radius.circular(6),
                            child: Container(
                              padding: EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer),
                              child: Column(
                                spacing: 16,
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: submitStoryController
                                                .imagePickedPath
                                                .value
                                                .isNotEmpty
                                            ? (kIsWeb
                                                ? Image.network(
                                                    submitStoryController
                                                        .imagePickedPath.value,
                                                    width: 45,
                                                    height: 45,
                                                    fit: BoxFit.cover)
                                                : Image.file(
                                                    File(submitStoryController
                                                        .imagePickedPath.value),
                                                    width: 45,
                                                    height: 45,
                                                    fit: BoxFit.cover))
                                            : Image.network(
                                                story?.photoUrl ?? "",
                                                width: 45,
                                                height: 45,
                                                fit: BoxFit.cover),
                                      ),
                                      Container(
                                          width: 45,
                                          height: 45,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white
                                                  .withOpacity(0.5))),
                                      Positioned(
                                          top: 11,
                                          left: 11,
                                          child: Icon(
                                            Icons.image_search_rounded,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                          ))
                                    ],
                                  ),
                                  Text("dropTheImageHere".tr),
                                  Text("sizeNotBigger".tr)
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 32),
                        // Martyer Story Review
                        Text(
                          "martyerStory".tr,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                        MartyerStory(storyDescController: storyDescController),
                        SizedBox(height: 170),
                        // Action Buttons
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                text: "cancel".tr,
                                txtColor: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                                btnColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                withIcon: false,
                                onTap: () {},
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: CustomButton(
                                text: "update".tr,
                                txtColor:
                                    Theme.of(context).colorScheme.onPrimary,
                                btnColor: Theme.of(context).colorScheme.primary,
                                withIcon: false,
                                onTap: () {
                                  submitStoryController.updateStory(story!.id);
                                },
                                fontSize: 18,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}