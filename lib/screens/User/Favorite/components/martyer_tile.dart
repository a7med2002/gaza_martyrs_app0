import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaza_martyer_app/controllers/Admin/theme_controller.dart';
import 'package:gaza_martyer_app/controllers/User/favorite_controller.dart';
import 'package:gaza_martyer_app/models/martyer_model.dart';
import 'package:gaza_martyer_app/screens/User/Story/story_details.dart';
import 'package:get/get.dart';

class MartyerTile extends StatelessWidget {
  final MartyerModel martyerModel;
  const MartyerTile({super.key, required this.martyerModel});

  @override
  Widget build(BuildContext context) {
    final favoriteController = Get.find<FavoriteController>();
    final themeController = Get.put(ThemeController());
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        boxShadow: [
          BoxShadow(
            color: themeController.isDark.value
                ? const Color.fromARGB(119, 245, 245, 245)
                : Colors.grey.shade200,
            blurRadius: 6,
            spreadRadius: 1,
            offset: const Offset(1, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            martyerModel.photoUrl,
            fit: BoxFit.cover,
            width: 120,
            height: 120,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${martyerModel.firstName} ${martyerModel.lastName}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
                const SizedBox(height: 6),
                Text(
                  "${double.parse(martyerModel.martyerAge).toInt()} ${"yearsOld".tr}",
                  style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimaryContainer
                          .withOpacity(0.7)),
                ),
                const SizedBox(height: 6),
                Text(
                  martyerModel.martyerCity,
                  style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                const SizedBox(height: 6),
                Text("${martyerModel.monthMartyer} ${martyerModel.yearMartyer}",
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.secondary))
              ],
            ),
          ),
          SizedBox(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(width: 30),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () {
                          favoriteController.favoriteLsit.removeWhere(
                              (story) => story.id == martyerModel.id);
                          favoriteController.favoriteLsit.refresh();
                          favoriteController
                              .removeFromFavorite(martyerModel.id);
                          print(favoriteController.favoriteLsit);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onPrimary,
                              borderRadius: BorderRadius.circular(30)),
                          child: SvgPicture.asset(
                            "assets/svgs/Delete.svg",
                            width: 22,
                            height: 22,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => StoryDetails(martyerModel: martyerModel));
                  },
                  child: Container(
                    color: Colors.white,
                    width: 90,
                    height: 36,
                    child: Center(
                      child: Text(
                        "readStory".tr,
                        style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}