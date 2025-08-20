import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/components/custom_my_app_bar.dart';
import 'package:gaza_martyer_app/controllers/User/my_search_controller.dart';
import 'package:gaza_martyer_app/controllers/User/stories_controller.dart';
import 'package:gaza_martyer_app/screens/User/Search/components/my_search_bar.dart';
import 'package:gaza_martyer_app/screens/User/Search/components/no_result.dart';
import 'package:gaza_martyer_app/screens/User/Search/components/recent_search.dart';
import 'package:gaza_martyer_app/screens/User/Search/components/result.dart';
import 'package:gaza_martyer_app/screens/User/Search/components/suggestions.dart';
import 'package:gaza_martyer_app/screens/User/Search/components/text_suggestions.dart';
import 'package:get/get.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    final mySearchController = Get.put(MySearchController());
    final storiesController = Get.put(StoriesController());
    mySearchController.allStories = storiesController.postedStories;

    return Scaffold(
      appBar: CustomMyAppBar(title: "search".tr),
      body: Padding(
        padding: const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MySearchBar(),
            const SizedBox(height: 2),
            Obx(() {
              if (mySearchController.isDone.value) {
                return mySearchController.filteredStories.isEmpty
                    ? const NoResult()
                    : Result(searchName: mySearchController.searchText.value);
              }

              if (mySearchController.searchText.value.isEmpty) {
                return mySearchController.isFocusSearch.value &&
                        mySearchController.recentSearch.isNotEmpty
                    ? const RecentSearch()
                    : const Suggestions();
              }

              return const TextSuggestions();
            }),
          ],
        ),
      ),
    );
  }
}