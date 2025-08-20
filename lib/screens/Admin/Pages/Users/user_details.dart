import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaza_martyer_app/components/custom_button.dart';
import 'package:gaza_martyer_app/controllers/Admin/admin_controller.dart';
import 'package:gaza_martyer_app/controllers/Admin/drop_down_pagination_controller.dart';
import 'package:gaza_martyer_app/controllers/User/auth_controller.dart';
import 'package:gaza_martyer_app/controllers/User/stories_controller.dart';
import 'package:gaza_martyer_app/screens/Admin/Components/my_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({super.key});

  @override
  Widget build(BuildContext context) {
    AdminController adminController = Get.put(AdminController());
    AuthController authController = Get.put(AuthController());
    DropDownPaginationController dropDownPaginationController =
        Get.put(DropDownPaginationController());
    StoriesController storiesController = Get.put(StoriesController());
    return SingleChildScrollView(
      child: Obx(() {
        final user = dropDownPaginationController.selectedUser.value!;
        return Column(
          spacing: 24,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          adminController.userSelectedIndex.value = 0;
                        },
                        icon: Icon(Icons.arrow_back_ios, size: 24)),
                    SizedBox(width: 16),
                    Text("userDetails".tr,
                        style: TextStyle(
                            fontSize: 32,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 190,
                      height: 50,
                      child: CustomButton(
                          text: "sendMessage".tr,
                          txtColor: Theme.of(context).colorScheme.onPrimary,
                          btnColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.6),
                          withIcon: true,
                          onTap: () {
                            adminController.storySelectedIndex.value = 2;
                          },
                          fontSize: 16,
                          svgColor: Theme.of(context).colorScheme.onPrimary,
                          svgicon: "assets/svgs/messages-2.svg"),
                    ),
                    SizedBox(width: 16),
                    SizedBox(
                      width: 190,
                      height: 50,
                      child: CustomButton(
                          text: "deleteAccount".tr,
                          txtColor: Theme.of(context).colorScheme.onPrimary,
                          svgColor: Theme.of(context).colorScheme.onPrimary,
                          btnColor: Colors.red,
                          withIcon: true,
                          onTap: () {
                            showMyDialog(
                                context,
                                Colors.red,
                                "deleteStoryTitle".tr,
                                "deleteStorySubTitle".tr,
                                "delete".tr,
                                Colors.red, () {
                              authController.deleteUserAccount(user.id!);
                              dropDownPaginationController.getAllUsers();
                              Get.back();
                            });
                          },
                          fontSize: 16,
                          svgicon: "assets/svgs/Delete.svg"),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 40),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(6)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 24,
                    children: [
                      Text("userIformation".tr,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      // Email
                      Row(
                        children: [
                          Text(
                            "${"email".tr}: ",
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                          Text(
                            user.email ?? "Error",
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer),
                          ),
                        ],
                      ),
                      // Password
                      Row(
                        children: [
                          Text(
                            "${"password".tr}: ",
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                          TextButton(
                              onPressed: () {
                                if (user.signInMethod == "email") {
                                  showMyDialog(
                                      context,
                                      Colors.green,
                                      "${"sendPasswordResetLinkTitle".tr} ${user.email}?",
                                      "sendPasswordResetLinkSubTitle".tr,
                                      "confirm".tr,
                                      Colors.green, () {
                                    dropDownPaginationController
                                        .sendResetPasswordLink(user.email!);
                                    Get.back();
                                  });
                                } else {
                                  showMyDialog(
                                      context,
                                      Theme.of(context).colorScheme.secondary,
                                      "${"CantSendPasswordResetLink".tr} ${user.email}",
                                      "${"BecauseCantSendPassLink".tr} ${user.signInMethod} ${"BecauseCantSendPassLink2".tr}",
                                      "ok".tr,
                                      Colors.green, () {
                                    Get.back();
                                  });
                                }
                              },
                              child: Text(
                                "resetPassword".tr,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer),
                              )),
                        ],
                      ),
                      // Account Creaction Date
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${"accountCreationDate".tr}: ",
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                          SizedBox(
                            width: 350,
                            child: Text(
                              user.createdAt != null
                                  ? DateFormat("dd MMM. yyyy , hh:mm a")
                                      .format(user.createdAt!)
                                  : "No Date",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer),
                            ),
                          ),
                        ],
                      ),
                      // Last Visit
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${"lastVisit".tr}: ",
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                          SizedBox(
                            width: 350,
                            child: Text(
                              user.loginDate != null
                                  ? DateFormat("dd MMM. yyyy , hh:mm a")
                                      .format(user.loginDate!)
                                  : "No Date",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer),
                            ),
                          ),
                        ],
                      ),
                      // Status
                      Row(
                        children: [
                          Text(
                            "${"status".tr} : ",
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: user.status == "disabled"
                                    ? Colors.redAccent.withOpacity(0.2)
                                    : Colors.lightGreen.withOpacity(0.2)),
                            child: Text(
                              user.status ?? "Unknown",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: user.status == "disabled"
                                      ? Colors.redAccent
                                      : Colors.lightGreen),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  Divider(color: Theme.of(context).colorScheme.secondary),
                  SizedBox(height: 40),
                  Text(
                      "${"storiesPostedByTheUser".tr} (${dropDownPaginationController.userStories.length})",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 24),
                  // Header
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.8),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6))),
                    child: Row(children: [
                      Expanded(
                          child: Center(
                              child: Text("image".tr,
                                  style: TextStyle(color: Colors.white)))),
                      Expanded(
                          child: Center(
                              child: Text("name".tr,
                                  style: TextStyle(color: Colors.white)))),
                      Expanded(
                          child: Center(
                              child: Text("age".tr,
                                  style: TextStyle(color: Colors.white)))),
                      Expanded(
                          child: Center(
                              child: Text("city".tr,
                                  style: TextStyle(color: Colors.white)))),
                      Expanded(
                          child: Center(
                              child: Text("dateOfMartyrdom".tr,
                                  style: TextStyle(color: Colors.white)))),
                      Expanded(
                          child: Center(
                              child: Text("story".tr,
                                  style: TextStyle(color: Colors.white)))),
                      Expanded(
                          child: Center(
                              child: Text("edit".tr,
                                  style: TextStyle(color: Colors.white)))),
                      Expanded(
                          child: Center(
                              child: Text("delete".tr,
                                  style: TextStyle(color: Colors.white)))),
                    ]),
                  ),
                  // Rows (repeat this Row for each item)
                  dropDownPaginationController.userStories.isEmpty
                      ? Center(
                          child: Column(
                          children: [
                            SizedBox(height: 16),
                            Text(
                              "noStorySubmittedByThisUser".tr,
                              style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                          ],
                        ))
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              dropDownPaginationController.userStories.length,
                          itemBuilder: (context, index) {
                            final story =
                                dropDownPaginationController.userStories[index];
                            return Column(
                              children: [
                                Container(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer
                                      .withOpacity(0.3),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: Row(
                                    children: [
                                      // Image
                                      Expanded(
                                          child: Center(
                                              child: CircleAvatar(
                                                  radius: 20,
                                                  backgroundImage: NetworkImage(
                                                      story.photoUrl)))),
                                      // Name
                                      Expanded(
                                          child: Center(
                                              child: Text(
                                                  "${story.firstName} ${story.lastName}"))),
                                      // Age
                                      Expanded(
                                          child: Center(
                                              child: Text(
                                                  "${double.parse(story.martyerAge).toInt()} ${"years".tr}"))),
                                      // City
                                      Expanded(
                                          child: Center(
                                              child: Text(story.martyerCity))),
                                      // Date of death
                                      Expanded(
                                          child: Center(
                                              child: Text(
                                                  "${story.monthMartyer.tr}. ${story.yearMartyer}"))),
                                      // View story
                                      Expanded(
                                        child: Center(
                                            child: InkWell(
                                          onTap: () {
                                            adminController
                                                .selectedIndex.value = 1;
                                            adminController
                                                .selectedStory.value = story;
                                            Future.delayed(
                                                Duration(milliseconds: 200),
                                                () {
                                              adminController
                                                  .storySelectedIndex.value = 1;
                                            });
                                          },
                                          child: Text("view".tr,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  fontWeight: FontWeight.bold,
                                                  decoration: TextDecoration
                                                      .underline)),
                                        )),
                                      ),
                                      // Edit
                                      Expanded(
                                        child: Center(
                                          child: InkWell(
                                            onTap: () {
                                              adminController
                                                  .selectedIndex.value = 1;
                                              adminController
                                                  .selectedStory.value = story;
                                              Future.delayed(
                                                  Duration(milliseconds: 200),
                                                  () {
                                                adminController
                                                    .storySelectedIndex
                                                    .value = 2;
                                              });
                                            },
                                            child: SvgPicture.asset(
                                                "assets/svgs/Edit.svg",
                                                width: 22,
                                                height: 22),
                                          ),
                                        ),
                                      ),
                                      // Delete
                                      Expanded(
                                        child: Center(
                                          child: InkWell(
                                            onTap: () {
                                              showMyDialog(
                                                  context,
                                                  Colors.red,
                                                  "deleteStoryTitle".tr,
                                                  "deleteStorySubTitle".tr,
                                                  "delete".tr,
                                                  Colors.red, () {
                                                storiesController
                                                    .deleteStory(story.id);
                                                Get.back();
                                                adminController
                                                    .storySelectedIndex
                                                    .value = 0;
                                                dropDownPaginationController
                                                    .getUserStories(story.id);
                                              });
                                            },
                                            child: SizedBox(
                                              child: SvgPicture.asset(
                                                  "assets/svgs/Delete.svg",
                                                  width: 22,
                                                  height: 22),
                                            ),
                                          ),
                                        ),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 28),
                                  child: Divider(color: Colors.grey[300]),
                                )
                              ],
                            );
                          },
                        ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}