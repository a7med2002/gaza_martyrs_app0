import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/components/custom_button.dart';
import 'package:gaza_martyer_app/controllers/User/massacres_controller.dart';
import 'package:gaza_martyer_app/screens/Admin/Pages/Add%20Stories/Components/location_select.dart';
import 'package:gaza_martyer_app/screens/Admin/Pages/Add%20Stories/Components/number_select_field.dart';
import 'package:gaza_martyer_app/screens/Admin/Pages/Add%20Stories/Components/photo_massacre.dart';
import 'package:get/get.dart';

class AddMassacre extends StatelessWidget {
  const AddMassacre({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    MassacresController massacresController = Get.put(MassacresController());
    GlobalKey<FormState> _formKrey = GlobalKey<FormState>();
    return Stack(
      children: [
        Row(
          spacing: 40,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Form(
                key: _formKrey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Massacres Name
                    Text(
                      "massacresName".tr,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: nameController,
                      onChanged: (value) =>
                          massacresController.massacresName.value = value,
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
                          hintText: "storyName".tr,
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.7))),
                    ),
                    SizedBox(height: 32),
                    // Date of Massacres
                    Text(
                      "dateOfMassacres".tr,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: massacresController.dateController,
                      onChanged: (value) {
                        massacresController.massacresDate.value = value;
                        print(value);
                      },
                      readOnly: true,
                      onTap: () async {
                        await massacresController.showPickerofDate(context);
                      },
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
                          hintText: "chooseDate".tr,
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.7)),
                          suffixIcon: Icon(Icons.calendar_month_rounded,
                              color: Theme.of(context).colorScheme.secondary)),
                    ),
                    SizedBox(height: 32),
                    // Martyrs Number
                    Text(
                      "martyrsNumber".tr,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    NumberSelectField(
                        hintTxt: "enterANumber".tr,
                        min: 1,
                        max: 100000,
                        value: 1000,
                        onChange: (double value) => massacresController
                            .massacresMartyer.value = value.toInt()),
                    SizedBox(height: 32),
                    // Martyrs Number
                    Text(
                      "woundedNumber".tr,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    NumberSelectField(
                        hintTxt: "enterANumber".tr,
                        min: 1,
                        max: 100000,
                        value: 200,
                        onChange: (double value) => massacresController
                            .massacresWounded.value = value.toInt()),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "massacresLocation".tr,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  LocationSelect(),
                  SizedBox(height: 32),
                  // Massacres Image
                  Text(
                    "massacresImage".tr,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  PhotoMassacre(),
                  SizedBox(height: 85),
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
                          text: "addMassacres".tr,
                          txtColor: Theme.of(context).colorScheme.onPrimary,
                          btnColor: Theme.of(context).colorScheme.primary,
                          withIcon: false,
                          onTap: () {
                            if (!massacresController.validateFormFields())
                              return;
                            massacresController.addMassacres();
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
        // Loading Overlay
        Obx(() => massacresController.isLoading.value
            ? Container(
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : const SizedBox.shrink()),
      ],
    );
  }
}