import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/components/custom_button.dart';
import 'package:gaza_martyer_app/screens/User/Submit/components/martyer_city.dart';
import 'package:gaza_martyer_app/screens/User/Submit/components/martyer_story.dart';
import 'package:get/get.dart';

class AddOther extends StatelessWidget {
  const AddOther({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController storyDescController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    return Row(
      spacing: 40,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Story Name
              Text(
                "storyName".tr,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8)),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8)),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.primaryContainer,
                    hintText: "storyName".tr,
                    hintStyle: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.7))),
              ),
              SizedBox(height: 32),
              // Type of Story
              Text(
                "typeOfStory".tr,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              MartyerCity(),
              SizedBox(height: 32),
              // Massacres Image
              Text(
                "storyImage".tr,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              DottedBorder(
                color: Theme.of(context).colorScheme.secondary,
                strokeWidth: 1.5,
                dashPattern: [6, 3],
                borderType: BorderType.RRect,
                radius: Radius.circular(6),
                child: Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Theme.of(context).colorScheme.primaryContainer),
                  child: Column(
                    spacing: 16,
                    children: [
                      Icon(
                        Icons.add_photo_alternate,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      Text("dropTheImageHere".tr,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary)),
                      Text("JPG, PNG ${"sizeNotBigger".tr}",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Massacres Name
              Text(
                "writeAStory".tr,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              MartyerStory(storyDescController: storyDescController),
              SizedBox(height: 165),
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: "cancel".tr,
                      txtColor:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                      btnColor: Theme.of(context).colorScheme.primaryContainer,
                      withIcon: false,
                      onTap: () {},
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: CustomButton(
                      text: "addStory".tr,
                      txtColor: Theme.of(context).colorScheme.onPrimary,
                      btnColor: Theme.of(context).colorScheme.primary,
                      withIcon: false,
                      onTap: () {},
                      fontSize: 18,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}