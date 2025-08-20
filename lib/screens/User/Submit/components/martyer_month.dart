import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/controllers/User/submit_story_controller.dart';
import 'package:get/get.dart';

class MartyerMonth extends StatelessWidget {
  const MartyerMonth({super.key});

  @override
  Widget build(BuildContext context) {
    final submitStoryController = Get.put(SubmitStoryController());

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
      selectedItem: submitStoryController.monthMartyer.isEmpty
          ? null
          : submitStoryController.monthMartyer.value,
      onChanged: (newSelect) {
        submitStoryController.monthMartyer.value = newSelect.toString();
        print(submitStoryController.monthMartyer.value);
      },
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          hintText: "month".tr,
          hintStyle: TextStyle(
              overflow: TextOverflow.ellipsis,
              color: Theme.of(context).colorScheme.secondary),
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
