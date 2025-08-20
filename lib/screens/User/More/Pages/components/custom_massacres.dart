import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaza_martyer_app/controllers/Admin/theme_controller.dart';
import 'package:get/get.dart';

class CustomMassacres extends StatelessWidget {
  final String imagePath;
  final String name;
  final String date;
  final String martyerNumber;
  final String woundedNumber;
  final String location;
  const CustomMassacres(
      {super.key,
      required this.imagePath,
      required this.name,
      required this.date,
      required this.martyerNumber,
      required this.woundedNumber,
      required this.location});

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.put(ThemeController());
    return Obx(() {
      final bool isDArkMode = themeController.isDark.value;
      return Container(
        margin: EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: isDArkMode
                    ? const Color.fromARGB(119, 245, 245, 245)
                    : Colors.grey.shade300,
                blurRadius: 6,
                spreadRadius: 1,
                offset: Offset(0, 2),
              ),
            ]),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6), topRight: Radius.circular(6)),
              child: Image.network(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 155,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(name),
                        Text(
                          date,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 12),
                        )
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            SvgPicture.asset(
                              "assets/svgs/skull-and-crossbones-svgrepo-com.svg",
                              color: Theme.of(context).colorScheme.primary,
                              width: 24,
                              height: 24,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "$martyerNumber ${"martyrs".tr}",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 12),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            SvgPicture.asset(
                                "assets/svgs/first-aid-kit-doctor-svgrepo-com.svg",
                                width: 24,
                                height: 24,
                                color: Theme.of(context).colorScheme.primary),
                            SizedBox(height: 8),
                            Text(
                              "$woundedNumber ${"wounded".tr}",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 12),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            SvgPicture.asset(
                                "assets/svgs/location-svgrepo-com.svg",
                                width: 24,
                                height: 24,
                                color: Theme.of(context).colorScheme.primary),
                            SizedBox(height: 8),
                            Text(
                              location,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 12),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ))
          ],
        ),
      );
    });
  }
}
