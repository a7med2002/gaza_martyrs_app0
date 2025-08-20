import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/screens/User/Home/components/custom_app_bar.dart';
import 'package:gaza_martyer_app/screens/User/Home/components/for_you.dart';
import 'package:gaza_martyer_app/screens/User/Home/components/head_container.dart';
import 'package:gaza_martyer_app/screens/User/Home/components/latest.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 0),
            child: Column(
              children: [
                CustomAppBar(),
                const SizedBox(height: 16),
                const HeadContainer(),
                const SizedBox(height: 16),
                TabBar(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  labelColor: Theme.of(context).colorScheme.primary,
                  unselectedLabelColor: Theme.of(context).colorScheme.secondary,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: "Jali Arabic",
                  ),
                  indicatorColor: Theme.of(context).colorScheme.primary,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Theme.of(context).colorScheme.secondary,
                  tabs: [
                    Tab(text: "forYou".tr),
                    Tab(text: "latest".tr),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: TabBarView(
                    children: const [
                      // For You Content
                      ForYou(),
                      // Latest Content
                      Latest(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}