import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/controllers/User/submit_story_controller.dart';
import 'package:get/get.dart';

class PhotoMartyer extends StatelessWidget {
  const PhotoMartyer({super.key});

  @override
  Widget build(BuildContext context) {
    SubmitStoryController adminStoryController =
        Get.put(SubmitStoryController());

    return Obx(() => adminStoryController.imagePickedPath.value == "" ||
            adminStoryController.imagePickedPath.value.isEmpty
        ? InkWell(
            onTap: () {
              adminStoryController.pickImage();
            },
            child: DottedBorder(
              color: Theme.of(context).colorScheme.secondary,
              strokeWidth: 1.5,
              dashPattern: [6, 3],
              borderType: BorderType.RRect,
              radius: Radius.circular(6),
              child: Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Theme.of(context).colorScheme.primaryContainer),
                child: Column(
                  spacing: 16,
                  children: [
                    Icon(
                      Icons.add_photo_alternate,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    Text("dropTheImageHere".tr,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary)),
                    Text("JPG, PNG ${"sizeNotBigger".tr}",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary))
                  ],
                ),
              ),
            ),
          )
        : InkWell(
            onTap: () {
              adminStoryController.imagePickedPath.value = "";
            },
            child: DottedBorder(
              color: Theme.of(context).colorScheme.secondary,
              strokeWidth: 1.5,
              dashPattern: [6, 3],
              borderType: BorderType.RRect,
              radius: Radius.circular(6),
              child: Container(
                width: 300,
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Theme.of(context).colorScheme.primaryContainer),
                child: Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: kIsWeb
                            ? Image.network(
                                adminStoryController.imagePickedPath.value,
                                fit: BoxFit.cover,
                                width: 300,
                                height: 150,
                              )
                            : Platform.isWindows
                                ? Image.file(
                                    File(adminStoryController
                                        .imagePickedPath.value),
                                    fit: BoxFit.cover,
                                    width: 300,
                                    height: 150,
                                  )
                                : Image.asset(
                                    adminStoryController.imagePickedPath.value,
                                    fit: BoxFit.cover,
                                    width: 300,
                                    height: 150,
                                  )),
                    Container(
                      width: 300,
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.5)),
                    ),
                    Positioned(
                      top: 70,
                      left: 140,
                      child: Icon(
                        Icons.delete,
                        size: 32,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ));
  }
}