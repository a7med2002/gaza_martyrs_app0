import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/controllers/User/filter_controller.dart';
import 'package:get/get.dart';

class YearSelect extends StatelessWidget {
  const YearSelect({super.key});

  @override
  Widget build(BuildContext context) {
    final filterController = Get.put(FilterController());

    return DropdownSearch<String>(
      items: (filter, loadProps) => ["2023", "2024", "2025"],
      selectedItem: filterController.selectedYear.isEmpty
          ? null
          : filterController.selectedYear.value,
      onChanged: (newSelect) {
        filterController.selectedYear.value = newSelect.toString();
        print(filterController.selectedYear.value);
      },
      popupProps: PopupProps.menu(
        menuProps: MenuProps(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8)),
            elevation: 0),
        fit: FlexFit.loose,
        constraints: BoxConstraints(maxHeight: 110),
        itemBuilder: (context, item, isDisabled, isSelected) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text(
              item.toString(),
              style: TextStyle(fontSize: 16),
            ),
          );
        },
      ),
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          hintText: "year".tr,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
          filled: true,
          fillColor: Theme.of(context).colorScheme.primaryContainer,
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}