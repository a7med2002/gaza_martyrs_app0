import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoResult extends StatelessWidget {
  const NoResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 100),
            Icon(
              Icons.search_off_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: 90,
            ),
            SizedBox(height: 32),
            Text(
              "searchEmpty".tr,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            SizedBox(height: 24),
            Text(
              "searchSubEmpty".tr,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}