import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaza_martyer_app/controllers/Admin/admin_controller.dart';
import 'package:gaza_martyer_app/controllers/Admin/admin_dark_mode_controller.dart';
import 'package:gaza_martyer_app/locale/locale_controller.dart';
import 'package:get/get.dart';

class MyHeader extends StatelessWidget {
  final String title;
  const MyHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    AdminDarkModeController adminDarkModeController =
        Get.put(AdminDarkModeController());
    AdminController adminController = Get.put(AdminController());
    return Container(
      height: 100,
      padding: const EdgeInsets.all(16),
      color: Color(0xffFCFCFB),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 120),
          Expanded(
            child: TextField(
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
                hintText: "search".tr,
                hintStyle: TextStyle(
                  fontSize: 20,
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    "assets/svgs/Search.svg",
                    width: 32,
                    height: 32,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.6),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 55),
          InkWell(
            onTap: () => adminController.selectedIndex.value = 8,
            child: SvgPicture.asset(
              "assets/svgs/Notification.svg",
              width: 40,
              height: 40,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(width: 40),
          SvgPicture.asset(
            "assets/svgs/messages-2.svg",
            width: 40,
            height: 40,
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(width: 40),
          PopupMenuButton<String>(
            borderRadius: BorderRadius.circular(6),
            offset: Offset(0, 50),
            icon: CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage("assets/cover/person.png"),
            ),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                enabled: false,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      adminController.auth.currentUser!.email!,
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    SizedBox(height: 8),
                    Divider(
                        color: Theme.of(context).colorScheme.primaryContainer),
                    InkWell(
                      onTap: () {
                        Get.back();
                        print('Change Password');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/svgs/changePassword.svg"),
                            SizedBox(width: 8),
                            Text("changePassword".tr,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer)),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final localeController = Get.find<LocaleController>();
                        final currentLang = localeController.language.value;

                        if (currentLang == "English") {
                          localeController.changeLang("العربية");
                        } else {
                          localeController.changeLang("English");
                        }
                        Get.back();

                        print('Changed Language');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/svgs/global-edit.svg"),
                            SizedBox(width: 8),
                            Text("changeLanguage".tr,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer)),
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Theme.of(context).colorScheme.onPrimary),
                        child: SvgPicture.asset("assets/svgs/dark-mode.svg"),
                      ),
                      title: Text("darkMode".tr),
                      titleTextStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      trailing: Transform.scale(
                          scale: 0.8,
                          child: Switch(
                              activeColor: Colors.white,
                              activeTrackColor:
                                  Theme.of(context).colorScheme.primary,
                              inactiveThumbColor: Colors.grey.shade600,
                              inactiveTrackColor: Colors.grey.shade300,
                              value: adminDarkModeController.isDarkMode.value,
                              onChanged: (value) {
                                Get.back();
                                adminDarkModeController.isDarkMode.value =
                                    !adminDarkModeController.isDarkMode.value;
                              })),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(width: 60),
        ],
      ),
    );
  }
}
