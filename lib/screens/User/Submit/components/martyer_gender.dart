import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/controllers/User/submit_story_controller.dart';
import 'package:get/get.dart';

class MartyerGender extends StatelessWidget {
  const MartyerGender({super.key});

  @override
  Widget build(BuildContext context) {
    final submitStoryController = Get.put(SubmitStoryController());

    Map<String, String> genderMap = {"male": "male".tr, "female": "female".tr};

    return Obx(() => DropdownSearch<String>(
          items: (filter, loadProps) => ["male", "female"],
          itemAsString: (item) => genderMap[item] ?? item,
          selectedItem: submitStoryController.martyerGender.isEmpty
              ? null
              : submitStoryController.martyerGender.value,
          onChanged: (newSelect) {
            submitStoryController.martyerGender.value = newSelect.toString();
          },
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              hintText: "gender".tr,
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
                  genderMap[item] ?? item,
                  style: TextStyle(fontSize: 16),
                ),
              );
            },
          ),
        ));
  }
}
