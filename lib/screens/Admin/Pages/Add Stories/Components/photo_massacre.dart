import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/controllers/User/massacres_controller.dart';
import 'package:get/get.dart';

class PhotoMassacre extends StatelessWidget {
  const PhotoMassacre({super.key});

  @override
  Widget build(BuildContext context) {
    MassacresController massacresController =
        Get.put(MassacresController());

    return Obx(() => massacresController.imagePickedPath.value == "" ||
            massacresController.imagePickedPath.value.isEmpty
        ? InkWell(
            onTap: () {
              massacresController.pickImage();
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
                    Text("JPG, PNG size ${"sizeNotBigger".tr}",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary))
                  ],
                ),
              ),
            ),
          )
        : InkWell(
            onTap: () {
              massacresController.imagePickedPath.value = "";
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
                        child: Image.network(
                          massacresController.imagePickedPath.value,
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