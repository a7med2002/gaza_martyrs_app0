import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/controllers/User/submit_story_controller.dart';
import 'package:get/get.dart';

class MartyerYear extends StatelessWidget {
  const MartyerYear({super.key});

  @override
  Widget build(BuildContext context) {
    final submitStoryController = Get.put(SubmitStoryController());
    return Obx(() => DropdownSearch<String>(
          items: (filter, loadProps) => [
            "2023",
            '2024',
            "2025",
          ],
          selectedItem: submitStoryController.yearMartyer.isEmpty
              ? null
              : submitStoryController.yearMartyer.value,
          onChanged: (newSelect) {
            submitStoryController.yearMartyer.value = newSelect.toString();
            print(submitStoryController.yearMartyer.value);
          },
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              hintText: "year".tr,
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