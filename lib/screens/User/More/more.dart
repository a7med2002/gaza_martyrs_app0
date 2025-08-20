import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaza_martyer_app/components/custom_my_app_bar.dart';
import 'package:gaza_martyer_app/controllers/Admin/theme_controller.dart';
import 'package:gaza_martyer_app/controllers/User/auth_controller.dart';
import 'package:gaza_martyer_app/locale/locale_controller.dart';
import 'package:gaza_martyer_app/controllers/User/more_controller.dart';
import 'package:gaza_martyer_app/screens/User/More/components/custom_lang_container.dart';
import 'package:gaza_martyer_app/screens/User/More/components/custom_tile.dart';
import 'package:get/get.dart';

class More extends StatelessWidget {
  const More({super.key});

  @override
  Widget build(BuildContext context) {
    MoreController moreController = Get.put(MoreController());
    LocaleController changeLanguageController =
        Get.put(LocaleController());
    ThemeController themeController = Get.put(ThemeController());
    AuthController authController = Get.put(AuthController());

    return Scaffold(
      appBar: CustomMyAppBar(title: "more".tr),
      body: Padding(
        padding: const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 0),
        child: ListView(
          children: [
            CustomTile(
              title: "otherStories".tr,
              svgIcon: "assets/svgs/clipboard.svg",
              hasChildren: true,
              fontSize: 16,
              onTap: () {
                moreController.showChildren.value =
                    !moreController.showChildren.value;
              },
            ),
            Obx(() => moreController.showChildren.value == true
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        CustomTile(
                          title: "storiesOfPerseverance".tr,
                          svgIcon: "assets/svgs/book.svg",
                          hasChildren: false,
                          fontSize: 14,
                          onTap: () {},
                        ),
                        CustomTile(
                          title: "painfulStories".tr,
                          svgIcon: "assets/svgs/book.svg",
                          hasChildren: false,
                          fontSize: 14,
                          onTap: () {},
                        ),
                        CustomTile(
                          title: "famineStories".tr,
                          svgIcon: "assets/svgs/book.svg",
                          hasChildren: false,
                          fontSize: 14,
                          onTap: () {},
                        ),
                        CustomTile(
                          title: "displacementStories".tr,
                          svgIcon: "assets/svgs/book.svg",
                          hasChildren: false,
                          fontSize: 14,
                          onTap: () {},
                        ),
                        CustomTile(
                          title: "dailylifeStories".tr,
                          svgIcon: "assets/svgs/book.svg",
                          hasChildren: false,
                          fontSize: 14,
                          onTap: () {},
                        )
                      ],
                    ),
                  )
                : SizedBox.shrink()),
            CustomTile(
              title: "massacres".tr,
              svgIcon: "assets/svgs/alarm.svg",
              hasChildren: false,
              fontSize: 16,
              onTap: () {
                Get.toNamed("/massacres");
              },
            ),
            CustomTile(
              title: "mapOfGaza".tr,
              svgIcon: "assets/svgs/map.svg",
              hasChildren: false,
              fontSize: 16,
              onTap: () {
                Get.toNamed("/mapOfGaza");
              },
            ),
            SizedBox(height: 16),
            // About
            Text(
              "about".tr,
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
            SizedBox(height: 16),
            CustomTile(
              title: "aboutUs".tr,
              svgIcon: "assets/svgs/message-question.svg",
              hasChildren: false,
              fontSize: 16,
              onTap: () {
                Get.toNamed("/aboutUs");
              },
            ),
            CustomTile(
              title: "termsConditions".tr,
              svgIcon: "assets/svgs/terms.svg",
              hasChildren: false,
              fontSize: 16,
              onTap: () {
                Get.toNamed("/termsAndConditions");
              },
            ),
            CustomTile(
              title: "contactUs".tr,
              svgIcon: "assets/svgs/message-square.svg",
              hasChildren: false,
              fontSize: 16,
              onTap: () {
                Get.toNamed("/contactUs");
              },
            ),
            SizedBox(height: 16),
            // Settings
            Text(
              "settings".tr,
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
            SizedBox(height: 16),
            // IF User SignIn With Google ==> Hide Change Password Tile
            authController.canChangePassword.value
                ? CustomTile(
                    title: "changePassword".tr,
                    svgIcon: "assets/svgs/key-square.svg",
                    hasChildren: false,
                    fontSize: 16,
                    onTap: () {
                      Get.toNamed("/changePassword");
                    },
                  )
                : SizedBox.shrink(),
            CustomTile(
              title: "changeLanguage".tr,
              svgIcon: "assets/svgs/global-edit.svg",
              hasChildren: false,
              fontSize: 16,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  showDragHandle: true,
                  builder: (context) {
                    return Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Text(
                            "changeLanguage".tr,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 48),
                          Padding(
                            padding: EdgeInsets.all(24),
                            child: Column(
                              children: [
                                CustomLangContainer(
                                    title: "English",
                                    onTap: () {
                                      changeLanguageController.language.value =
                                          "English";
                                      // Get.updateLocale(Locale("en"));
                                      Get.find<LocaleController>().changeLang("English");
                                    },
                                    imagePath: "assets/cover/english.png"),
                                SizedBox(height: 16),
                                CustomLangContainer(
                                    title: "العربية",
                                    onTap: () {
                                      changeLanguageController.language.value =
                                          "Arabic";
                                          Get.find<LocaleController>().changeLang("العربية");
                                      // Get.updateLocale(Locale("ar"));
                                    },
                                    imagePath: "assets/cover/arabic.png")
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            CustomTile(
              title: "notifications".tr,
              svgIcon: "assets/svgs/Notification.svg",
              hasChildren: false,
              fontSize: 16,
              onTap: () {
                Get.toNamed("/userNotifications");
              },
            ),
            // Dark Mode
            Container(
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                leading: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Theme.of(context).colorScheme.onPrimary),
                  child: SvgPicture.asset("assets/svgs/dark-mode.svg",
                      color: Theme.of(context).colorScheme.primary),
                ),
                title: Text("darkMode".tr),
                titleTextStyle: TextStyle(
                    fontFamily: "Jali Arabic",
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                trailing: Transform.scale(
                  scale: 0.9,
                  child: Obx(() => Switch(
                        activeColor: Colors.white,
                        activeTrackColor: Theme.of(context).colorScheme.primary,
                        inactiveThumbColor: Colors.grey.shade600,
                        inactiveTrackColor: Colors.grey.shade300,
                        value: themeController.isDark.value,
                        onChanged: (value) {
                          themeController.changeTheme(value);
                        },
                      )),
                ),
              ),
            ),
            // Logout
            Container(
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                leading: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Theme.of(context).colorScheme.onPrimary),
                  child: SvgPicture.asset("assets/svgs/Logout.svg"),
                ),
                title: Text("logOut".tr),
                titleTextStyle: TextStyle(
                    fontFamily: "Jali Arabic",
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                onTap: () {
                  authController.auth.signOut();
                  Get.offAllNamed("/login1");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}