import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomContainer extends StatelessWidget {
  final String title;
  final int userNumber;
  final double percentage;
  const CustomContainer({super.key, required this.title, required this.userNumber, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(6)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                SvgPicture.asset("assets/svgs/ArrowRight.svg",
                    width: 24, height: 24)
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("$userNumber",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 24)),
                    Text(" ${"users".tr}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16)),
                  ],
                ),
                SizedBox(width: 16),
                Row(
                  children: [
                    SvgPicture.asset("assets/svgs/positive.svg"),
                    SizedBox(width: 8),
                    Text("$percentage%",
                        style: TextStyle(color: Colors.green, fontSize: 16)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}