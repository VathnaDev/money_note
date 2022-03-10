import 'package:flutter/material.dart';
import 'package:money_note/src/screens/edit_category/edit_category_screen.dart';
import 'package:money_note/src/screens/home/home_screen.dart';
import 'package:money_note/src/screens/onboard/onboard_screen.dart';
import 'package:money_note/src/utils/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
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
        primarySwatch: Colors.blue,
      ),
      home: EditCategoryScreen(),
    );
  }
}
