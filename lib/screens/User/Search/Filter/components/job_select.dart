import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/controllers/User/filter_controller.dart';
import 'package:get/get.dart';

class JobSelect extends StatelessWidget {
  const JobSelect({super.key});

  @override
  Widget build(BuildContext context) {
    final filterController = Get.put(FilterController());

    final Map<String, String> jobsMap = {
      "Engineer": "engineer".tr,
      "Doctor": "doctor".tr,
      "Teacher": "teacher".tr,
      "Journalist": "journalist".tr,
      "Other": "other".tr
    };

    return Obx(() => DropdownSearch<String>.multiSelection(
          items: (filter, infiniteScrollProps) =>
              ["Engineer", "Doctor", "Teacher", "Journalist", "Other"],
          itemAsString: (item) => jobsMap[item] ?? item,
          selectedItems: filterController.selectedJobs.value,
          onChanged: (newItems) =>
              filterController.selectedJobs.value = newItems,
          dropdownBuilder: (context, selectedItems) {
            return Wrap(
              spacing: 6,
              children: selectedItems.map((item) {
                return Chip(
                  label: Text(
                    jobsMap[item] ?? item,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  deleteIconColor: Colors.white,
                  onDeleted: () {
                    selectedItems.remove(item);
                    filterController.selectedJobs.remove(item);
                  },
                );
              }).toList(),
            );
          },
          popupProps: PopupPropsMultiSelection.menu(
            menuProps: MenuProps(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                elevation: 0),
            constraints: BoxConstraints(
              maxHeight: 160,
            ),
          ),
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              hintText: "selectJob".tr,  
              hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.primaryContainer,
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ));
  }
}