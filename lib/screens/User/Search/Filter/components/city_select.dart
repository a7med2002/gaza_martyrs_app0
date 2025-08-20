import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/controllers/User/filter_controller.dart';
import 'package:get/get.dart';

class CitySelect extends StatelessWidget {
  const CitySelect({super.key});

  @override
  Widget build(BuildContext context) {
    final filterController = Get.put(FilterController());
    Map<String, String> cityMaps = {
      "North Gaza": "North Gaza".tr,
      "Gaza": "Gaza".tr,
      "Deir al-Balah": "Deir al-Balah".tr,
      "Khanyunis": "Khanyunis".tr,
      "Rafah": "Rafah".tr,
    };
    return Obx(() => DropdownSearch<String>.multiSelection(
          items: (filter, infiniteScrollProps) =>
              ["North Gaza", "Gaza", "Deir al-Balah", "Khanyunis", "Rafah"],
          selectedItems: filterController.selectedCities.value,
          itemAsString: (item) => cityMaps[item] ?? item,
          onChanged: (newItems) =>
              filterController.selectedCities.value = newItems,
          dropdownBuilder: (context, selectedItems) {
            return Wrap(
              spacing: 6,
              children: selectedItems.map((item) {
                return Chip(
                  label: Text(
                    cityMaps[item] ?? item,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  deleteIconColor: Colors.white,
                  onDeleted: () {
                    selectedItems.remove(item);
                    filterController.selectedCities.remove(item);
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
              maxHeight: 240,
            ),
          ),
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              hintText: "selectCity".tr,
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
