import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/components/custom_button.dart';
import 'package:gaza_martyer_app/controllers/User/submit_story_controller.dart';
import 'package:gaza_martyer_app/screens/Admin/Pages/Add%20Stories/Components/photo_martyer.dart';
import 'package:gaza_martyer_app/screens/User/Submit/components/martyer_age.dart';
import 'package:gaza_martyer_app/screens/User/Submit/components/martyer_city.dart';
import 'package:gaza_martyer_app/screens/User/Submit/components/martyer_gender.dart';
import 'package:gaza_martyer_app/screens/User/Submit/components/martyer_job.dart';
import 'package:gaza_martyer_app/screens/User/Submit/components/martyer_month.dart';
import 'package:gaza_martyer_app/screens/User/Submit/components/martyer_story.dart';
import 'package:gaza_martyer_app/screens/User/Submit/components/martyer_year.dart';
import 'package:get/get.dart';

class AddMartyerStory extends StatelessWidget {
  const AddMartyerStory({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController firstNameController = TextEditingController();
    TextEditingController midNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController storyDescController = TextEditingController();
    SubmitStoryController submitStoryController =
        Get.put(SubmitStoryController());
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
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
                    // First Name
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
                            fillColor:
                                Theme.of(context).colorScheme.primaryContainer,
                            hintText: "firstName".tr,
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.7))),
                      ),
                    ),
                    // Mid Name
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
                            fillColor:
                                Theme.of(context).colorScheme.primaryContainer,
                            hintText: "midName".tr,
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.7))),
                      ),
                    ),
                    // Last Name
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
                            fillColor:
                                Theme.of(context).colorScheme.primaryContainer,
                            hintText: "lastName".tr,
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.7))),
                      ),
                    )
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
                PhotoMartyer(),
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
                SizedBox(height: 190),
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: "cancel".tr,
                        txtColor:
                            Theme.of(context).colorScheme.onPrimaryContainer,
                        btnColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        withIcon: false,
                        onTap: () {},
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: CustomButton(
                        text: "addMartyer".tr,
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
                          submitStoryController.submitStory(isAdmin: true);
                          firstNameController.clear();
                          midNameController.clear();
                          lastNameController.clear();
                          storyDescController.clear();
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
  }
}