// import 'package:flutter/material.dart';
// import 'package:gaza_martyer_app/main.dart';
// import 'package:get/get.dart';

// class LocaleController extends GetxController {
//   RxString language = "English".obs;

//   Locale iniatlang = sharedPref!.getString("lang") == null
//       ? Get.deviceLocale!
//       : Locale((sharedPref!.getString("lang"))!);

//   changeLang(String codeLang) {
//     Locale locale = Locale(codeLang);
//     sharedPref!.setString("lang", codeLang);
//     Get.updateLocale(locale);
//   }
// }
import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/main.dart';
import 'package:get/get.dart';

class LocaleController extends GetxController {
  final RxString language = "English".obs; 
  @override
  void onInit() {
    super.onInit();
    language.value = sharedPref!.getString("lang") == "ar" ? "العربية" : "English";
  }

  Locale get iniatlang {
    return sharedPref!.getString("lang") == null
        ? Get.deviceLocale ?? const Locale('en') 
        : Locale(sharedPref!.getString("lang")!);
  }

  void changeLang(String languageName) {
    final codeLang = languageName == "English" ? "en" : "ar";
    final locale = Locale(codeLang);
    
    sharedPref!.setString("lang", codeLang);
    Get.updateLocale(locale);
    language.value = languageName;
  }
}