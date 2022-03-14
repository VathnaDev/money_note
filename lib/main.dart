import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/riverpod/theme/app_theme_state.dart';
import 'package:money_note/src/screens/category/add_category/add_category.dart';
import 'package:money_note/src/screens/category/edit_category/edit_category_screen.dart';
import 'package:money_note/src/screens/currency/curreny_screen.dart';
import 'package:money_note/src/screens/home/home_screen.dart';
import 'package:money_note/src/screens/onboard/onboard_screen.dart';
import 'package:money_note/src/utils/theme.dart';

import 'src/screens/home/report/category_report/category_report_screen.dart';

final appThemeStateNotifier = ChangeNotifierProvider((ref) => AppThemeState());

void main() {
  runApp(ProviderScope(child:  MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeState = ref.watch(appThemeStateNotifier);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode:
          appThemeState.isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
      home: CurrencyScreen(),
    );
  }
}
