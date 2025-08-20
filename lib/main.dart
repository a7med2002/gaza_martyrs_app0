import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/controllers/Admin/network_controller.dart';
import 'package:gaza_martyer_app/controllers/Admin/notification_controller.dart';
import 'package:gaza_martyer_app/controllers/Admin/theme_controller.dart';
import 'package:gaza_martyer_app/firebase_options.dart';
import 'package:gaza_martyer_app/locale/locale.dart';
import 'package:gaza_martyer_app/locale/locale_controller.dart';
import 'package:gaza_martyer_app/screens/Admin/Pages/Auth/admin_forget_password.dart';
import 'package:gaza_martyer_app/screens/Admin/Pages/Auth/admin_login.dart';
import 'package:gaza_martyer_app/screens/Admin/admin_dashboard.dart';
import 'package:gaza_martyer_app/screens/User/Home/home.dart';
import 'package:gaza_martyer_app/screens/User/Notifications/user_notification.dart';
import 'package:gaza_martyer_app/screens/User/OnBoarding/on_boarding_screen.dart';
import 'package:gaza_martyer_app/screens/User/Splash/splash_screen.dart';
import 'package:gaza_martyer_app/screens/User/main_screen.dart';
import 'package:gaza_martyer_app/screens/User/Login/forget_password.dart';
import 'package:gaza_martyer_app/screens/User/Login/login.dart';
import 'package:gaza_martyer_app/screens/User/Login/sign_up.dart';
import 'package:gaza_martyer_app/screens/User/More/About/about_us.dart';
import 'package:gaza_martyer_app/screens/User/More/About/contact_us.dart';
import 'package:gaza_martyer_app/screens/User/More/Pages/map_of_gaza.dart';
import 'package:gaza_martyer_app/screens/User/More/Pages/massacres.dart';
import 'package:gaza_martyer_app/screens/User/More/About/terms_and_conditions.dart';
import 'package:gaza_martyer_app/screens/User/More/Settings/change_password.dart';
import 'package:gaza_martyer_app/shared_pref_service%20.dart';
import 'package:get/get.dart';
import 'package:gaza_martyer_app/config/themes.dart';
import 'package:gaza_martyer_app/screens/User/Login/login1.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharedPref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ------------------------------------------
  await SharedPrefService.init();
  sharedPref = await SharedPreferences.getInstance();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(ThemeController());
  Get.put(LocaleController());
  if (Platform.isAndroid || Platform.isIOS) {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    Get.put(NetworkController());
    Get.put(NotificationController());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Gaza Martyer App',
          theme: lightTheme(
              Get.find<LocaleController>().language == "English" ? 'en' : 'ar'),
          darkTheme: darkTheme(
              Get.find<LocaleController>().language == "English" ? 'en' : 'ar'),
          themeMode:
              themeController.isDark.value ? ThemeMode.dark : ThemeMode.light,
          translations: MyLocale(),
          locale: Get.find<LocaleController>().iniatlang,
          fallbackLocale: const Locale('en'),
          home: SplashScreen(),
          getPages: [
            GetPage(name: "/onBoarding", page: () => OnBoardingScreen()),
            GetPage(
                name: "/adminDahsboard",
                page: () => AdminDashboard(),
                transition: Transition.downToUp),
            GetPage(
                name: "/adminLogin",
                page: () => AdminLogin(),
                transition: Transition.downToUp),
            GetPage(name: "/login1", page: () => Login1()),
            GetPage(
                name: "/adminForgetPassword",
                page: () => AdminForgetPassword(),
                transition: Transition.rightToLeft),
            GetPage(
              name: "/splashScreen",
              page: () => SplashScreen(),
            ),
            GetPage(
                name: "/login",
                page: () => Login(),
                transition: Transition.downToUp),
            GetPage(
                name: "/signup",
                page: () => SignUp(),
                transition: Transition.downToUp),
            GetPage(
                name: "/forgetPassword",
                page: () => ForgetPassword(),
                transition: Transition.rightToLeft),
            GetPage(
              name: "/mainScreen",
              page: () => MainScreen(),
            ),
            GetPage(name: "/home", page: () => Home()),
            GetPage(
                name: "/userNotifications",
                page: () => UserNotification(),
                transition: Transition.rightToLeft),
            GetPage(
                name: "/massacres",
                page: () => Massacres(),
                transition: Transition.rightToLeft),
            GetPage(
                name: "/mapOfGaza",
                page: () => MapOfGaza(),
                transition: Transition.rightToLeft),
            GetPage(
                name: "/aboutUs",
                page: () => AboutUs(),
                transition: Transition.rightToLeft),
            GetPage(
                name: "/termsAndConditions",
                page: () => TermsAndConditions(),
                transition: Transition.rightToLeft),
            GetPage(
                name: "/contactUs",
                page: () => ContactUs(),
                transition: Transition.rightToLeft),
            GetPage(
                name: "/changePassword",
                page: () => ChangePassword(),
                transition: Transition.rightToLeft),
          ],
        ));
  }
}
