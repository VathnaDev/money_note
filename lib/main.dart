import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/riverpod/app_providers.dart';
import 'package:money_note/src/riverpod/settings/app_theme_state.dart';
import 'package:money_note/src/screens/home/home_screen.dart';
import 'package:money_note/src/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [sharedPrefProvider.overrideWithValue(sharedPreferences)],
      child: MyApp(),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appThemeState = ref.watch(appThemeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: appThemeState ? ThemeMode.dark : ThemeMode.light,
      home: HomeScreen(),
    );
  }
}
