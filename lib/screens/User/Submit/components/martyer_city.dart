import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/controllers/User/submit_story_controller.dart';
import 'package:get/get.dart';

class MartyerCity extends StatelessWidget {
  const MartyerCity({super.key});

  @override
  Widget build(BuildContext context) {
    final submitStoryController = Get.put(SubmitStoryController());

    Map<String, String> cityMap = {
      "North Gaza": "North Gaza".tr,
      "Gaza": "Gaza".tr,
      "Deir al-Balah": "Deir al-Balah".tr,
      "Khanyunis": "Khanyunis".tr,
      "Rafah": "Rafah".tr
    };

    return Obx(() => DropdownSearch<String>(
          items: (filter, loadProps) =>
              ["North Gaza", "Gaza", "Deir al-Balah", "Khanyunis", "Rafah"],
          itemAsString: (item) => cityMap[item] ?? item,
          selectedItem: submitStoryController.martyerCity.isEmpty
              ? null
              : submitStoryController.martyerCity.value,
          onChanged: (newSelect) {
            submitStoryController.martyerCity.value = newSelect.toString();
          },
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              hintText: "city".tr,
              hintStyle: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 14),
              filled: true,
              fillColor: Theme.of(context).colorScheme.primaryContainer,
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
          popupProps: PopupProps.menu(
            fit: FlexFit.loose,
            menuProps: MenuProps(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
                elevation: 0),
            constraints: BoxConstraints(maxHeight: 110),
            itemBuilder: (context, item, isDisabled, isSelected) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Text(
                  cityMap[item] ?? item,
                  style: TextStyle(fontSize: 16),
                ),
              );
            },
          ),
        ));
  }
}