import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/controllers/Admin/drop_down_pagination_controller.dart';
import 'package:get/get.dart';

class DropDownPagination extends StatelessWidget {
  const DropDownPagination({super.key});

  @override
  Widget build(BuildContext context) {
    DropDownPaginationController dropDownPaginationController =
        Get.put(DropDownPaginationController());
    return Obx(
      () => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(6)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: dropDownPaginationController.currentPage.value,
                items: dropDownPaginationController.pageList.map((page) {
                  return DropdownMenuItem<int>(
                    value: page,
                    child: Text("${"page".tr} $page"),
                  );
                }).toList(),
                icon: SizedBox.shrink(),
                selectedItemBuilder: (context) {
                  return dropDownPaginationController.pageList.map((page) {
                    return Row(
                      children: [
                        Icon(Icons.keyboard_arrow_down, size: 32),
                        SizedBox(width: 8),
                        Text("${"page".tr} $page"),
                      ],
                    );
                  }).toList();
                },
                onChanged: (value) {
                  if (value != null) {
                    dropDownPaginationController.gotToPage(value);
                  }
                },
              ),
            ),
          ),
          SizedBox(width: 24),
          Text(
            "${"of".tr} ${dropDownPaginationController.totalPages}",
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}