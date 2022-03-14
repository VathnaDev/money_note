import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


const colorBlue = Color(0xFF5986F2);
const colorRed = Color(0xFFFE7474);

const colorIncome = Color(0xFF9AB8FF);
const colorExpense = Color(0xFFFF9A9A);

final outlinedButtonTheme = OutlinedButtonThemeData(
  style: ButtonStyle(
    padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(99),
      ),
    ),
  ),
);

final elevatedButtonTheme = ElevatedButtonThemeData(
  style: ButtonStyle(
    padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(99),
      ),
    ),
  ),
);

final googleTextTheme = GoogleFonts.poppinsTextTheme();
final textTheme = GoogleFonts.poppinsTextTheme().copyWith(
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
