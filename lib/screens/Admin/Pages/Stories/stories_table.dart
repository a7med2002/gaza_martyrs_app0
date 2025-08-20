import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaza_martyer_app/components/custom_button.dart';
import 'package:gaza_martyer_app/controllers/Admin/admin_controller.dart';
import 'package:gaza_martyer_app/controllers/Admin/pagination_controller.dart';
import 'package:gaza_martyer_app/controllers/User/stories_controller.dart';
import 'package:gaza_martyer_app/screens/Admin/Components/my_dialog.dart';
import 'package:gaza_martyer_app/screens/Admin/Components/pagination.dart';
import 'package:get/get.dart';

class StoriesTable extends StatelessWidget {
  const StoriesTable({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    PaginationController paginationController = Get.put(PaginationController());
    final adminController = Get.put(AdminController());
    StoriesController storiesController = Get.put(StoriesController());

    return SingleChildScrollView(
      child: Container(
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
                              child: SvgPicture.asset("assets/svgs/candle.svg",
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
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
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
            FutureBuilder(
              future: storiesController.fetchPostedStories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text("${"error".tr}: ${snapshot.error}");
                }
                if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
                  return Center(
                      child: Text(
                    "emptyStories".tr,
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.secondary),
                  ));
                }
                return Obx(() => Column(
                        children: paginationController.pagedItems.map(
                      (story) {
                        return Column(
                          children: [
                            Container(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer
                                  .withOpacity(0.3),
                              padding: const EdgeInsets.symmetric(vertical: 12),
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
                                            .storySelectedIndex.value = 1;
                                        adminController.selectedStory.value =
                                            story;
                                      },
                                      child: Text("view".tr,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.underline)),
                                    )),
                                  ),
                                  // Edit
                                  Expanded(
                                    child: Center(
                                      child: InkWell(
                                        onTap: () {
                                          adminController
                                              .storySelectedIndex.value = 2;
                                          adminController.selectedStory.value =
                                              story;
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 28),
                              child: Divider(color: Colors.grey[300]),
                            )
                          ],
                        );
                      },
                    ).toList()));
              },
            ),
            // Pagination
            Pagination()
          ],
        ),
      ),
    );
  }
}