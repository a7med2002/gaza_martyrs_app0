import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaza_martyer_app/controllers/User/my_search_controller.dart';
import 'package:get/get.dart';

class TextSuggestions extends StatelessWidget {
  const TextSuggestions({super.key});

  @override
  Widget build(BuildContext context) {
    final mySearchController = Get.put(MySearchController());

    return Obx(() {
      double minHieght = 40.0;
      double totalHieght =
          mySearchController.filteredStories.length * minHieght;
      return Container(
        height: totalHieght,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(8),
                bottomLeft: Radius.circular(8))),
        child: ListView.builder(
          itemCount: mySearchController.filteredStories.length,
          itemBuilder: (context, index) {
            final story = mySearchController.filteredStories[index];
            final fullName = "${story.firstName} ${story.lastName}";
            return ListTile(
              onTap: () {
                mySearchController.searchText.value = fullName;
                mySearchController.addToRecent(story);
                mySearchController.isDone.value = true;
              },
              minTileHeight: 16,
              leading: SvgPicture.asset("assets/svgs/Search.svg",
                  width: 24,
                  height: 24,
                  color: Theme.of(context).colorScheme.primary),
              title: Text(
                fullName,
                style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold),
              ),
            );
          },
        ),
      );
    });
  }
}
