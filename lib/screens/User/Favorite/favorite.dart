import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaza_martyer_app/controllers/User/favorite_controller.dart';
import 'package:gaza_martyer_app/screens/User/Favorite/components/martyer_tile.dart';
import 'package:get/get.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteController = Get.put(FavoriteController());
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: AppBar(
            leadingWidth: 24,
            leading: InkWell(
              onTap: () => Get.back(),
              child: SvgPicture.asset(
                "assets/svgs/Arrow.svg",
                color: theme.colorScheme.primary,
                width: 24,
                height: 24,
              ),
            ),
            centerTitle: true,
            title: Text(
              "favorite".tr,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              SvgPicture.asset(
                "assets/svgs/Notification.svg",
                width: 30,
                height: 30,
                color: theme.colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Obx(() {
          if (favoriteController.favoriteLsit.isEmpty) {
            return Center(
              child: Column(
                children: [
                  SizedBox(height: mediaQuery.size.height / 3),
                  Icon(
                    Icons.not_interested_sharp,
                    color: theme.colorScheme.primary,
                    size: 90,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    "emptyFavorite".tr,
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: favoriteController.favoriteLsit.length,
            itemBuilder: (context, index) {
              return MartyerTile(
                martyerModel: favoriteController.favoriteLsit[index],
              );
            },
          );
        }),
      ),
    );
  }
}