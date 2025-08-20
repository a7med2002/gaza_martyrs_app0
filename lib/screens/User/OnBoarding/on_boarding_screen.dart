import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  final PageController _controller = PageController();
  final RxInt currentIndex = 0.obs;

  List<Map<String, String>> onBoradingData = [
    {
      "title": "onBoarding1Title".tr,
      "description": "onBoarding1SubTitle".tr,
      "image": "assets/cover/onboarding1.png",
    },
    {
      "title": "onBoarding2Title".tr,
      "description": "onBoarding2SubTitle".tr,
      "image": "assets/cover/onBoarding3.png",
    },
    {
      "title": "onBoarding3Title".tr,
      "description": "onBoarding3SubTitle".tr,
      'image': "assets/cover/onborading2.png",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF1C1C1C),
          Color.fromARGB(255, 144, 131, 131),
        ],
      )),
      child: Column(
        children: [
          Expanded(
              child: PageView.builder(
            controller: _controller,
            itemCount: onBoradingData.length,
            onPageChanged: (index) => currentIndex.value = index,
            itemBuilder: (context, index) {
              final data = onBoradingData[index];
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(data['image']!, height: 500),
                    SizedBox(height: 30),
                    Text(
                      data['title']!,
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      data['description']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              );
            },
          )),
          SmoothPageIndicator(
            controller: _controller,
            count: onBoradingData.length,
            effect: WormEffect(
              activeDotColor: Theme.of(context).colorScheme.primary,
              dotColor: Theme.of(context).colorScheme.secondary,
              dotHeight: 10,
              dotWidth: 10,
            ),
          ),
          SizedBox(height: 20),
          Obx(() {
            final isLast = currentIndex.value == onBoradingData.length - 1;
            return ElevatedButton(
              onPressed: () async {
                if (isLast) {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool("seenOnBoarding", true);
                  Get.toNamed("/login1");
                } else {
                  _controller.nextPage(
                      duration: Duration(microseconds: 300),
                      curve: Curves.easeInOut);
                }
              },
              child: Text(isLast ? "Get Started" : "Next"),
            );
          }),
          SizedBox(height: 40),
        ],
      ),
    ));
  }
}
