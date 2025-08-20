import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaza_martyer_app/controllers/User/my_search_controller.dart';
import 'package:gaza_martyer_app/screens/User/Search/Filter/filter_search.dart';
import 'package:get/get.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  FocusNode searchFocusNode = FocusNode();
  final mySearchController = Get.put(MySearchController());

  @override
  void initState() {
    super.initState();
    searchFocusNode.addListener(() {
      mySearchController.isFocusSearch.value = searchFocusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchTextController = TextEditingController();

    return TextField(
      onSubmitted: (value) => {
        mySearchController.searchText.value = value,
        mySearchController.filterStories(), // فلترة النتائج
        mySearchController.isDone.value = true, // المستخدم خلص كتابة
        mySearchController.isFocusSearch.value = false, // يخفي الاقتراحات
        searchFocusNode.unfocus(), // يخفي الكيبورد
      },
      textInputAction: TextInputAction.done,
      focusNode: searchFocusNode,
      onChanged: (value) => {
        mySearchController.searchText.value = value,
        mySearchController.isFilterApplied.value = false,
      },
      controller: searchTextController,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8))),
          filled: true,
          fillColor: Theme.of(context).colorScheme.primaryContainer,
          prefixIcon: Obx(() => Padding(
                padding: const EdgeInsets.all(10),
                child: mySearchController.searchText.value.isEmpty
                    ? SvgPicture.asset(
                        "assets/svgs/Search.svg",
                        width: 24,
                        height: 24,
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.6),
                      )
                    : InkWell(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          mySearchController.searchText.value = '';
                        },
                        child: SvgPicture.asset(
                          "assets/svgs/arrow-left.svg",
                          width: 24,
                          height: 24,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
              )),
          labelText: mySearchController.searchText.value.isEmpty
              ? null
              : mySearchController.searchText.value,
          hintText: "hintSearch".tr,
          hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.6)),
          suffixIcon: Obx(() => Padding(
                padding: const EdgeInsets.all(12),
                child: InkWell(
                  onTap: () => Get.to(() => FilterSearch()),
                  child: SvgPicture.asset(
                    "assets/svgs/candle.svg",
                    width: 28,
                    height: 28,
                    color: mySearchController.searchText.value.isEmpty
                        ? Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.6)
                        : Theme.of(context).colorScheme.primary,
                  ),
                ),
              ))),
    );
  }
}