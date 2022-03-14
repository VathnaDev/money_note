import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const colorBlue = Color(0xFF5986F2);
const colorRed = Color(0xFFFE7474);

const colorIncome = Color(0xFF9AB8FF);
const colorExpense = Color(0xFFFF9A9A);

const colorGrey = Color(0xFFD9D9D9);

final boxDecoration = BoxDecoration(
  border: Border.all(
    color: colorGrey,
  ),
  borderRadius: BorderRadius.circular(8),
);

class AppTheme {
  AppTheme._();

  static final baseLightTheme = ThemeData();
  static final baseDarkTheme = ThemeData.dark();

  static final inputTheme = InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ),
  );

  static final outlinedButtonTheme = OutlinedButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(99),
        ),
      ),
    ),
  );

  static final elevatedButtonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return Colors.grey;
        }
      }),
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return colorGrey;
        }
        return colorBlue; // Defer to the widget's default.
      }),
      padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(99),
        ),
      ),
    ),
  );

  static const lightWhite = Color(0xFFFCFCFC);
  static const lightBackground = Color(0xFFF5F5F5);
  static const lightPrimary = Color(0xFF404040);
  static const lightSecondary = Color(0xFFA6A6A6);

  static final googleTextTheme = GoogleFonts.poppinsTextTheme();
  static final textTheme = GoogleFonts.poppinsTextTheme(googleTextTheme).copyWith(
    headline1: googleTextTheme.headline1?.copyWith(
      fontSize: 32,
      fontWeight: FontWeight.normal,
    ),
    headline2: googleTextTheme.headline2?.copyWith(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    subtitle1: googleTextTheme.subtitle1?.copyWith(
      fontSize: 18,
      // fontWeight: FontWeight.w600,
    ),
    subtitle2: googleTextTheme.subtitle2?.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    bodyText1: googleTextTheme.bodyText1?.copyWith(
      fontSize: 16,
    ),
    caption: googleTextTheme.caption?.copyWith(
      fontSize: 12,
    ),
  );

  static final lightTheme = baseLightTheme.copyWith(
    elevatedButtonTheme: elevatedButtonTheme,
    textTheme: textTheme,
    inputDecorationTheme: inputTheme,
    primaryColor: lightPrimary,
    primaryColorDark: lightPrimary,
    backgroundColor: lightBackground,
    scaffoldBackgroundColor: lightWhite,
    canvasColor: lightWhite,
    dialogBackgroundColor: lightWhite,
    popupMenuTheme: const PopupMenuThemeData(color: lightBackground),
    tabBarTheme: baseLightTheme.tabBarTheme.copyWith(
      labelColor: colorBlue
    ),
    appBarTheme:  baseLightTheme.appBarTheme.copyWith(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black
    ),
    colorScheme: baseLightTheme.colorScheme.copyWith(
      secondary: colorBlue,
    ),
  );

  static const darkBlack = Color(0xFF28293D);
  static const darkBackground = Color(0xFF595968);
  static const darkPrimary = Color(0xFFEAEAEA);
  static const darkSecondary = Color(0xFFBABABF);

  static final darkPoppins =
      GoogleFonts.poppinsTextTheme(baseDarkTheme.textTheme);
  static final darkTextTheme = GoogleFonts.poppinsTextTheme()
      .copyWith(
        headline1: darkPoppins.headline1?.copyWith(
          fontSize: 32,
          fontWeight: FontWeight.normal,
        ),
        headline2: darkPoppins.headline2?.copyWith(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        subtitle1: darkPoppins.subtitle1?.copyWith(
          fontSize: 18,
          // fontWeight: FontWeight.w600,
        ),
        subtitle2: darkPoppins.subtitle2?.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        bodyText1: darkPoppins.bodyText1?.copyWith(
          fontSize: 16,
          color: darkSecondary,
        ),
        caption: darkPoppins.caption?.copyWith(
          fontSize: 12,
        ),
      )
      .apply(bodyColor: darkPrimary);

  static final darkTheme = baseDarkTheme.copyWith(
    elevatedButtonTheme: elevatedButtonTheme,
    textTheme: darkTextTheme,
    inputDecorationTheme: inputTheme,
    primaryColor: const Color(0xFFEAEAEA),
    primaryColorDark: const Color(0xFFEAEAEA),
    backgroundColor: darkBackground,
    scaffoldBackgroundColor: darkBlack,
    canvasColor: darkBlack,
    dialogBackgroundColor: darkBlack,
    popupMenuTheme: const PopupMenuThemeData(color: darkBackground),
    appBarTheme: const AppBarTheme(
      backgroundColor: darkBlack,
    ),
    colorScheme: baseDarkTheme.colorScheme.copyWith(
      secondary: colorBlue,
      secondaryContainer: colorBlue,
    ),
  );
}
