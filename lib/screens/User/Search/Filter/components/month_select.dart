import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/controllers/User/filter_controller.dart';
import 'package:get/get.dart';

class MonthSelect extends StatelessWidget {
  const MonthSelect({super.key});

  @override
  Widget build(BuildContext context) {
    final filterController = Get.put(FilterController());
    final Map<String, String> monthsMap = {
      "January": "January".tr,
      "February": "February".tr,
      "March": "March".tr,
      "April": "April".tr,
      "May": "May".tr,
      "June": "June".tr,
      "July": "July".tr,
      "August": "August".tr,
      "September": "September".tr,
      "October": "October".tr,
      "November": "November".tr,
      "December": "December".tr,
    };

    return DropdownSearch<String>(
      items: (filter, loadProps) => [
        "January",
        'February',
        "March",
        "April",
        "May",
        "June",
        "July",
        'August',
        "September",
        "October",
        "November",
        'December'
      ],
      itemAsString: (item) => monthsMap[item] ?? item,
      selectedItem: filterController.selectedMonth.isEmpty
          ? null
          : filterController.selectedMonth.value,
      onChanged: (newSelect) {
        filterController.selectedMonth.value = newSelect.toString();
      },
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          hintText: "month".tr,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text(
              monthsMap[item] ?? item,
              style: TextStyle(fontSize: 16),
            ),
          );
        },
      ),
    );
  }
}
