import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaza_martyer_app/controllers/Admin/admin_controller.dart';
import 'package:gaza_martyer_app/controllers/User/auth_controller.dart';
import 'package:gaza_martyer_app/locale/locale_controller.dart';
import 'package:get/get.dart';

class SubAdminHeader extends StatelessWidget {
  final String title;
  const SubAdminHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    AdminController adminController = Get.put(AdminController());
    AuthController authController = Get.put(AuthController());
    return Container(
      height: 100,
      padding: const EdgeInsets.all(16),
      color: Color(0xffFCFCFB),
      child: Row(
        children: [
          Text(
            title.tr,
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
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                    InkWell(
                      onTap: () {
                        authController.auth.signOut();
                        Get.offAllNamed('/adminLogin');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/svgs/Logout.svg"),
                            SizedBox(width: 8),
                            Text("logout".tr,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
