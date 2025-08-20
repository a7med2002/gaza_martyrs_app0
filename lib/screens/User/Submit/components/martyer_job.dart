import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/controllers/User/submit_story_controller.dart';
import 'package:get/get.dart';

class MartyerJob extends StatelessWidget {
  const MartyerJob({super.key});

  @override
  Widget build(BuildContext context) {
    final submitStoryController = Get.put(SubmitStoryController());
    final Map<String, String> jobsMap = {
      "engineer": "engineer".tr,
      "doctor": "doctor".tr,
      "teacher": "teacher".tr,
      "journalist": "journalist".tr,
      "other": "other".tr
    };
    return Obx(() => DropdownSearch<String>(
          items: (filter, loadProps) =>
              ["engineer", "doctor", "teacher", "journalist", "other"],
          itemAsString: (item) => jobsMap[item] ?? item,
          selectedItem: submitStoryController.jobMartyer.isEmpty
              ? null
              : submitStoryController.jobMartyer.value,
          onChanged: (newSelect) {
            submitStoryController.jobMartyer.value = newSelect.toString();
            print(submitStoryController.jobMartyer.value);
          },
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              hintText: "job".tr,
              hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                overflow: TextOverflow.ellipsis,
              ),
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
                  jobsMap[item] ?? item,
                  style: TextStyle(fontSize: 16),
                ),
              );
            },
          ),
        ));
  }
}
