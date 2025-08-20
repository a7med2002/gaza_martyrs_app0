import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/controllers/User/massacres_controller.dart';
import 'package:get/get.dart';

class LocationSelect extends StatelessWidget {
  const LocationSelect({super.key});

  @override
  Widget build(BuildContext context) {
    final massacresController = Get.put(MassacresController());
    Map<String, String> locationMaps = {
      "North Gaza" : "North Gaza".tr,
      "Gaza" : "Gaza".tr,
      "Deir al-Balah" : "Deir al-Balah".tr,
      "Khanyunis" : "Khanyunis".tr,
      "Rafah" : "Rafah".tr
    };

    return Obx(() => DropdownSearch<String>(
          items: (filter, loadProps) =>
              ["North Gaza", "Gaza", "Deir al-Balah", "Khanyunis", "Rafah"],
              itemAsString: (item) => locationMaps[item] ?? item,
          selectedItem: massacresController.massacresLocation.isEmpty
              ? null
              : massacresController.massacresLocation.value,
          onChanged: (newSelect) {
            massacresController.massacresLocation.value = newSelect.toString();
          },
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              hintText: "location".tr,
              hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.secondary, fontSize: 14),
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
                  item.toString(),
                  style: TextStyle(fontSize: 16),
                ),
              );
            },
          ),
        ));
  }
}