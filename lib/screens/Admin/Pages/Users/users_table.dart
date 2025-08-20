import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaza_martyer_app/components/custom_button.dart';
import 'package:gaza_martyer_app/controllers/Admin/admin_controller.dart';
import 'package:gaza_martyer_app/controllers/Admin/drop_down_pagination_controller.dart';
import 'package:gaza_martyer_app/models/user_model.dart';
import 'package:gaza_martyer_app/screens/Admin/Components/custom_container.dart';
import 'package:gaza_martyer_app/screens/Admin/Components/drop_down_pagination.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UsersTable extends StatelessWidget {
  const UsersTable({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    DropDownPaginationController dropDownPaginationController =
        Get.put(DropDownPaginationController());
    AdminController adminController = Get.put(AdminController());

    return SingleChildScrollView(
      child: Column(spacing: 40, children: [
        Row(
          spacing: 24,
          children: [
            CustomContainer(
                title: "users".tr, userNumber: 14353, percentage: 5.26),
            CustomContainer(
                title: "activeUsers".tr, userNumber: 646, percentage: 3.26),
            CustomContainer(
                title: "newUsers".tr, userNumber: 49, percentage: 1.03),
            CustomContainer(
                title: "visitors".tr, userNumber: 3274, percentage: 2.22),
          ],
        ),
        // Users Table
        Container(
          padding: EdgeInsets.symmetric(horizontal: 28, vertical: 48),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              // Title Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                        textInputAction: TextInputAction.done,
                        controller: searchController,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(8)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8))),
                            filled: true,
                            fillColor:
                                Theme.of(context).colorScheme.primaryContainer,
                            prefixIcon: Padding(
                                padding: const EdgeInsets.all(10),
                                child: SvgPicture.asset(
                                  "assets/svgs/Search.svg",
                                  width: 24,
                                  height: 24,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.6),
                                )),
                            hintText: "searchHint".tr,
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.6)),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(12),
                              child: InkWell(
                                onTap: () {},
                                child: SvgPicture.asset(
                                    "assets/svgs/candle.svg",
                                    width: 28,
                                    height: 28,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.6)),
                              ),
                            ))),
                  ),
                  SizedBox(width: 300),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: CustomButton(
                        text: "printTable".tr,
                        txtColor: Theme.of(context).colorScheme.onPrimary,
                        svgColor: Theme.of(context).colorScheme.onPrimary,
                        btnColor: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.5),
                        withIcon: true,
                        onTap: () {},
                        fontSize: 16,
                        svgicon: "assets/svgs/printer.svg"),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              // Header
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.8),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6))),
                child: Row(children: [
                  Expanded(
                      child: Center(
                          child: Text("email".tr,
                              style: TextStyle(color: Colors.white)))),
                  Expanded(
                      child: Center(
                          child: Text("numberOfStories".tr,
                              style: TextStyle(color: Colors.white)))),
                  Expanded(
                      child: Center(
                          child: Text("loginDate".tr,
                              style: TextStyle(color: Colors.white)))),
                  Expanded(
                      child: Center(
                          child: Text("status".tr,
                              style: TextStyle(color: Colors.white)))),
                  Expanded(
                      child: Center(
                          child: Text("details".tr,
                              style: TextStyle(color: Colors.white)))),
                ]),
              ),
              // List Of Users
              Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount:
                        dropDownPaginationController.pagiantedUsers.length,
                    itemBuilder: (context, index) {
                      UserModel user =
                          dropDownPaginationController.pagiantedUsers[index];
                      return Column(
                        children: [
                          Container(
                            color: Theme.of(context)
                                .colorScheme
                                .primaryContainer
                                .withOpacity(0.3),
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              children: [
                                // Email
                                Expanded(
                                    child: Center(child: Text(user.email!))),
                                // Number of Stories
                                Expanded(
                                    child: Center(
                                        child: Obx(() => Text(
                                            "${dropDownPaginationController.numberOfStoryMap[user.id] ?? 0} ${"stories".tr}")))),
                                // Login Date
                                Expanded(
                                    child: Center(
                                        child: Text(user.loginDate != null
                                            ? DateFormat(
                                                    "dd MMM. yyyy , hh:mm a")
                                                .format(user.loginDate!)
                                            : "No Date"))),
                                // Status
                                Expanded(
                                    child: Center(
                                        child: Text(
                                  user.status!,
                                  style: TextStyle(
                                      color: user.status == "disabled"
                                          ? Colors.red
                                          : Colors.green),
                                ))),

                                // Details
                                Expanded(
                                  child: Center(
                                      child: InkWell(
                                    onTap: () {
                                      adminController.userSelectedIndex.value =
                                          1;
                                      dropDownPaginationController
                                          .selectedUser.value = user;
                                      dropDownPaginationController
                                          .getUserStories(user.id!);
                                    },
                                    child: Text("details".tr,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline)),
                                  )),
                                ),
                              ],
                            ),
                          ),
                          // Divider
                          Container(
                            color: Theme.of(context)
                                .colorScheme
                                .primaryContainer
                                .withOpacity(0.3),
                            padding: const EdgeInsets.symmetric(horizontal: 28),
                            child: Divider(color: Colors.grey[300]),
                          )
                        ],
                      );
                    },
                  )),
              SizedBox(height: 32),
              // Dropdown Pagination
              DropDownPagination(),
            ],
          ),
        )
      ]),
    );
  }
}