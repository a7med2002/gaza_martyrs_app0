// import 'package:gaza_martyer_app/config/themes.dart';
import 'package:gaza_martyer_app/shared_pref_service%20.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  RxBool isDark = false.obs;
  @override
  void onInit() {
    bool savedTheme = SharedPrefService.prefs.getBool("isDarkMode") ?? false;
    isDark.value = savedTheme;
    // Get.changeTheme(savedTheme ? darkTheme(context) : lightTheme(context));
    super.onInit();
  }

  void changeTheme(bool value) {
    isDark.value = value;
    // Get.changeTheme(value ? darkTheme(context) : lightTheme(context));
    SharedPrefService.prefs.setBool("isDarkMode", value);
  }
}
