import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaza_martyer_app/controllers/Admin/theme_controller.dart';
import 'package:gaza_martyer_app/controllers/User/favorite_controller.dart';
import 'package:gaza_martyer_app/models/martyer_model.dart';
import 'package:gaza_martyer_app/screens/User/Favorite/favorite.dart';
import 'package:get/get.dart';

class MartyerCard extends StatelessWidget {
  final MartyerModel martyerModel;
  final VoidCallback onTap;
  const MartyerCard(
      {super.key, required this.martyerModel, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final favoriteController = Get.put(FavoriteController());
    final themeController = Get.put(ThemeController());

    return InkWell(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondaryContainer,
            boxShadow: [
              BoxShadow(
                color: themeController.isDark.value
                    ? const Color.fromARGB(119, 245, 245, 245)
                    : Colors.grey.shade200,
                blurRadius: 6,
                spreadRadius: 1,
                offset: Offset(0, 3),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.network(
                    martyerModel.photoUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 122,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.broken_image),
                  ),
                  Obx(() {
                    final bool isStoryFav = favoriteController.favoriteLsit
                        .any((element) => element.id == martyerModel.id);
                    return Positioned(
                        top: 8,
                        right: 8,
                        child: InkWell(
                          onTap: () {
                            if (isStoryFav) {
                              favoriteController
                                  .removeFromFavorite(martyerModel.id);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("storyFavRemoved".tr),
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                showCloseIcon: true,
                              ));
                            } else {
                              favoriteController.addToFavorite(martyerModel.id);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("storyFavAdded".tr),
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                action: SnackBarAction(
                                    label: "show".tr,
                                    onPressed: () => Get.to(() => Favorite())),
                              ));
                            }
                            favoriteController.favoriteLsit.refresh();
                          },
                          child: Container(
                            padding: EdgeInsets.all(4),
                            height: 28,
                            width: 28,
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                                borderRadius: BorderRadius.circular(60)),
                            child: SvgPicture.asset("assets/svgs/Heart.svg",
                                color: isStoryFav
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.secondary,
                                width: 16,
                                height: 16),
                          ),
                        ));
                  })
                ],
              ),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${martyerModel.firstName} ${martyerModel.lastName}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer),
                        ),
                        SizedBox(height: 8),
                        Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          "${double.parse(martyerModel.martyerAge).toInt()} ${"yearsOld".tr}",
                          style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer
                                  .withOpacity(0.7)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          martyerModel.martyerCity.tr,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                        SizedBox(height: 8),
                        Text(
                            "${martyerModel.monthMartyer.tr} ${martyerModel.yearMartyer}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.secondary))
                      ],
                    )),
              ),
              InkWell(
                onTap: onTap,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  color: Colors.white,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "readStory".tr,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
