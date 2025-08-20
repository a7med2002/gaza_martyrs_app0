import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaza_martyer_app/components/custom_my_app_bar.dart';
import 'package:gaza_martyer_app/controllers/User/massacres_controller.dart';
import 'package:gaza_martyer_app/screens/User/More/Pages/components/custom_massacres.dart';
import 'package:get/get.dart';

class Massacres extends StatelessWidget {
  const Massacres({super.key});

  @override
  Widget build(BuildContext context) {
    MassacresController massacresController = Get.put(MassacresController());
    return Scaffold(
      appBar: CustomMyAppBar(title: "massacres".tr),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
        child: ListView(
          children: [
            // Search Bar
            TextField(
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
                fillColor: Theme.of(context).colorScheme.primaryContainer,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    "assets/svgs/Search.svg",
                    width: 24,
                    height: 24,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.6),
                  ),
                ),
                hintText: "massacres".tr,
                hintStyle: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.6)),
              ),
            ),
            SizedBox(height: 24),
            // Massacres
            Obx(() {
              if (massacresController.massacres.isEmpty) {
                return Center(child: Text("noMasscres".tr));
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: massacresController.massacres.length,
                itemBuilder: (context, index) {
                  final massacre = massacresController.massacres[index];
                  return CustomMassacres(
                    imagePath: massacre.imagePath ?? "",
                    name: massacre.name ?? "No name",
                    date: massacre.date ?? "00/00/00",
                    martyerNumber: massacre.martyerNumber.toString() ?? "000",
                    woundedNumber: massacre.woundedNumber.toString() ?? "000",
                    location: massacre.location ?? "no location",
                  );
                },
              );
            })
          ],
        ),
      ),
    );
  }
}