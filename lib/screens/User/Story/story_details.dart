import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaza_martyer_app/controllers/User/favorite_controller.dart';
import 'package:gaza_martyer_app/models/martyer_model.dart';
import 'package:gaza_martyer_app/screens/User/Favorite/favorite.dart';
import 'package:gaza_martyer_app/screens/User/Story/Report/report_dialog.dart';
import 'package:get/get.dart';

class StoryDetails extends StatelessWidget {
  final MartyerModel martyerModel;
  const StoryDetails({super.key, required this.martyerModel});

  @override
  Widget build(BuildContext context) {
    final favoriteController = Get.put(FavoriteController());

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: AppBar(
            leadingWidth: 24,
            leading: InkWell(
              onTap: () => Get.back(),
              child: SvgPicture.asset(
                "assets/svgs/Arrow.svg",
                color: Theme.of(context).colorScheme.primary,
                width: 24,
                height: 24,
              ),
            ),
            centerTitle: true,
            title: Text(
              "storyDetails".tr,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              ReportDialog(martyerModel: martyerModel),
              SizedBox(width: 16),
              Obx(() {
                final bool isStoryFav = favoriteController.favoriteLsit
                    .any((element) => element.id == martyerModel.id);
                return InkWell(
                  onTap: () {
                    if (isStoryFav) {
                      favoriteController.removeFromFavorite(martyerModel.id);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("storyRemoveFromFav".tr),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        showCloseIcon: true,
                      ));
                    } else {
                      favoriteController.addToFavorite(martyerModel.id);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("storyAddFromFav".tr),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        action: SnackBarAction(
                          label: "show".tr,
                          onPressed: () => Get.to(() => Favorite()),
                        ),
                      ));
                    }
                    favoriteController.favoriteLsit.refresh();
                  },
                  child: SvgPicture.asset(
                    "assets/svgs/Heart.svg",
                    width: 30,
                    height: 30,
                    color: isStoryFav
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.secondary,
                  ),
                );
              }),
              SizedBox(width: 16),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 250,
                  height: 300,
                  child: Image.network(
                    martyerModel.photoUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.broken_image),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                "${martyerModel.firstName} ${martyerModel.midName} ${martyerModel.lastName}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 8),
              Column(
                children: [
                  _buildInfoRow(
                    context,
                    iconPath: "assets/svgs/timer.svg",
                    label: "age".tr,
                    value:
                        "${double.parse(martyerModel.martyerAge).toInt()} ${"yearsOld".tr}",
                  ),
                  SizedBox(height: 8),
                  _buildInfoRow(
                    context,
                    iconPath: "assets/svgs/location.svg",
                    label: "city".tr,
                    value: martyerModel.martyerCity.tr,
                  ),
                  SizedBox(height: 8),
                  _buildInfoRow(
                    context,
                    iconPath: "assets/svgs/calendar.svg",
                    label: "dateOfMartyrdom".tr,
                    value:
                        "${martyerModel.monthMartyer.tr}/${martyerModel.yearMartyer}",
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                martyerModel.story,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context)
                      .colorScheme
                      .onPrimaryContainer
                      .withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context,
      {required String iconPath,
      required String label,
      required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              iconPath,
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
            )
          ],
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context)
                .colorScheme
                .onPrimaryContainer
                .withOpacity(0.7),
          ),
        )
      ],
    );
  }
}
