import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/riverpod/app_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

final appThemeProvider = StateNotifierProvider<AppThemeState, bool>((ref) {
  final pref = ref.watch(sharedPrefProvider);
  return AppThemeState(pref);
});

class AppThemeState extends StateNotifier<bool> {
  AppThemeState(this.sharedPreferences)
      : super(sharedPreferences.getBool('isDarkTheme') ?? false);
  final SharedPreferences sharedPreferences;

  void setIsDarkMode(bool isDarkMode) async {
    await sharedPreferences.setBool('isDarkTheme', isDarkMode);
    state = isDarkMode;
  }
}


