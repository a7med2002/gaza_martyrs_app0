import 'package:flutter/material.dart';
import 'colors.dart';

ThemeData lightTheme(String langCode) => ThemeData(
      useMaterial3: true,
      fontFamily: langCode == 'ar' ? 'Jali Arabic' : 'Jali Arabic',
      colorScheme: ColorScheme.light(
        surface: lBgColor,
        primary: lPrimaryColor,
        secondary: lSecondaryColor,
        onSurface: lFontColor,
        primaryContainer: lDivColor,
        onPrimaryContainer: lFontColor,
        onSecondaryContainer: lLabelColor,
      ),
    );

ThemeData darkTheme(String langCode) => ThemeData(
      useMaterial3: true,
      fontFamily: langCode == 'ar' ? 'Jali Arabic' : 'Jali Arabic',
      colorScheme: ColorScheme.dark(
        surface: dBgColor,
        primary: dPrimaryColor,
        secondary: dFontColor,
        onSurface: dFontColor,
        primaryContainer: dDivColor,
        onPrimaryContainer: dFontColor,
        onSecondaryContainer: dLabelColor,
      ),
    );












// import 'package:flutter/material.dart';

// import 'colors.dart';

// var lightTheme = ThemeData(
//     useMaterial3: true,
//     colorScheme: ColorScheme.light(
//         background: lBgColor,
//         primary: lPrimaryColor,
//         secondary: lSecondaryColor,
//         onBackground: lFontColor,
//         primaryContainer: lDivColor,
//         onPrimaryContainer: lFontColor,
//         onSecondaryContainer: lLabelColor));



// var darkTheme = ThemeData(
//   useMaterial3: true,
//   colorScheme: ColorScheme.dark(
//     background: dBgColor,
//     primary: dPrimaryColor,
//     secondary: dSecondaryColor,
//     onBackground: dFontColor,
//     primaryContainer: dDivColor,
//     onPrimaryContainer: dFontColor,
//     onSecondaryContainer: dLabelColor,
//   ),
// );
