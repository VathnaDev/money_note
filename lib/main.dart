import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_note/src/screens/home/home_screen.dart';
import 'package:money_note/src/screens/onboard/onboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            )
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          )
        ),
        textTheme: textTheme.copyWith(
          headline1: textTheme.headline1?.copyWith(
            fontSize: 32,
            fontWeight: FontWeight.normal,
          ),
          headline2: textTheme.headline2?.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          subtitle1: textTheme.subtitle1?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          subtitle2: textTheme.subtitle2?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          bodyText1: textTheme.bodyText1?.copyWith(
            fontSize: 16,
          ),
          caption: textTheme.caption?.copyWith(
            fontSize: 12,
          ),
        ),
        primarySwatch: Colors.blue,
      ),
      home: const OnBoardScreen(),
    );
  }
}
