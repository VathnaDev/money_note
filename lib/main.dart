import 'package:flutter/material.dart';
import 'package:money_note/src/screens/category/add_category/add_category.dart';
import 'package:money_note/src/screens/category/edit_category/edit_category_screen.dart';
import 'package:money_note/src/screens/home/home_screen.dart';
import 'package:money_note/src/screens/onboard/onboard_screen.dart';
import 'package:money_note/src/utils/theme.dart';

import 'src/screens/home/report/category_report/category_report_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      darkTheme: ThemeData.dark(),
      theme: theme.copyWith(
        outlinedButtonTheme: outlinedButtonTheme,
        elevatedButtonTheme: elevatedButtonTheme,
        textTheme: textTheme,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
        colorScheme: theme.colorScheme.copyWith(
          primary: Color(0xFF404040),
          secondary: Color(0xFFA6A6A6),
        )
      ),
      home: HomeScreen(),
    );
  }
}
