import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/components/custom_my_app_bar.dart';
import 'package:get/get.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomMyAppBar(title: "termsConditions".tr),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "titleTermsOfCondition".tr,
                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
              SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("1. ${"term1".tr}"),
                  SizedBox(height: 8),
                  Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Text(
                      "titleTerm1".tr,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  )
                ],
              ),
              SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("2. ${"term2".tr}"),
                  SizedBox(height: 8),
                  Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Text(
                      "titleTerm2".tr,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  )
                ],
              ),
              SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("3. ${"term3".tr}"),
                  SizedBox(height: 8),
                  Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Text(
                      "youAgreeTo".tr,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                  
                  Container(
                    margin: EdgeInsets.only(left: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "• ${"term3Sub1".tr}",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                        Text(
                          "• ${"term3Sub2".tr}",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                        Text(
                          "• ${"term3Sub3".tr}",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("4. ${"term4".tr}"),
                  SizedBox(height: 8),
                  Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Text(
                      "titleTerm4".tr,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  )
                ],
              ),
              SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("5. ${"term5".tr}"),
                  SizedBox(height: 8),
                  Container(
                    margin: EdgeInsets.only(left: 16),
                    child: Text(
                      "titleTerm5".tr,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}