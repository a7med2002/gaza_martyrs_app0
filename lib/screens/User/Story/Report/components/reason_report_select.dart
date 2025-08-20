import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/controllers/User/report_controller.dart';
import 'package:get/get.dart';

class ReasonReportSelect extends StatelessWidget {
  const ReasonReportSelect({super.key});

  @override
  Widget build(BuildContext context) {
    final reportController = Get.put(ReportController());

    final Map<String, String> reportTypesMap = {
      "Incorrect Information": "Incorrect Information",
      "Duplicate Story": "Duplicate Story",
      "Inappropriate Image": "Inappropriate Image",
      "Incomplete or Weak Content": "Incomplete or Weak Content",
      "Privacy Violation": "Privacy Violation",
      "Fake or Unverified Content": "Fake or Unverified Content",
      "other": "other",
    };

    return DropdownSearch<String>(
      items: (filter, loadProps) => [
        'Incorrect Information',
        'Duplicate Story',
        'Inappropriate Image',
        'Incomplete or Weak Content',
        'Privacy Violation',
        'Fake or Unverified Content',
        'other',
      ],
      itemAsString: (item) => item.tr,
      selectedItem: reportController.reportType.isEmpty
          ? null
          : reportController.reportType.value,
      onChanged: (newSelect) {
        reportController.reportType.value = newSelect.toString();
      },
      popupProps: PopupProps.menu(
        menuProps: MenuProps(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
          elevation: 1,
        ),
        fit: FlexFit.loose,
        constraints: BoxConstraints(maxHeight: 110),
        itemBuilder: (context, item, isDisabled, isSelected) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text(
              item.toString().tr,
              style: TextStyle(fontSize: 16),
            ),
          );
        },
      ),
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          hintText: "issueType".tr,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
          filled: true,
          fillColor: Theme.of(context).colorScheme.primaryContainer,
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}