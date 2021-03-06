import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/data/settings.dart';
import 'package:money_note/src/providers/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsState extends StateNotifier<Settings> {
  SettingsState(this.sharedPreferences) : super(Settings()) {
    final isDark = sharedPreferences.getBool('isDarkTheme') ?? false;
    final isFirstOpen = sharedPreferences.getBool('isFirstOpen') ?? true;
    final currency = sharedPreferences.getString('currency') ?? "en_US";
    final language = sharedPreferences.getString('language') ?? "en_US";
    final pinPassword = sharedPreferences.getString('pinPassword') ?? "";
    final reminder = sharedPreferences.getInt('reminder') ??
        DateTime.now().millisecondsSinceEpoch;

    state = Settings(
      currency: currency,
      isDarkMode: isDark,
      pinPassword: pinPassword,
      isFirstOpen: isFirstOpen,
      language: language,
      reminder: DateTime.fromMillisecondsSinceEpoch(reminder),
    );
  }

  final SharedPreferences sharedPreferences;

  void setIsDarkMode(bool isDarkMode) async {
    await sharedPreferences.setBool('isDarkTheme', isDarkMode);
    state = state.copyWith(isDarkMode: isDarkMode);
  }

  void setIsFirstOpen(bool isFirstOpen) async {
    await sharedPreferences.setBool('isFirstOpen', isFirstOpen);
    state = state.copyWith(isFirstOpen: isFirstOpen);
  }

  void setCurrency(String currency) async {
    await sharedPreferences.setString('currency', currency);
    state = state.copyWith(currency: currency);
  }

  void setPin(String pinPassword) async {
    await sharedPreferences.setString('pinPassword', pinPassword);
    state = state.copyWith(pinPassword: pinPassword);
  }

  void setLanugage(String language) async {
    await sharedPreferences.setString('language', language);
    state = state.copyWith(language: language);
  }

  void setReminder(DateTime reminder) async {
    await sharedPreferences.setInt('reminder', reminder.millisecondsSinceEpoch);
    state = state.copyWith(reminder: reminder);
  }
}

final settingsStateProvider =
    StateNotifierProvider<SettingsState, Settings>((ref) {
  final pref = ref.watch(sharedPrefProvider);
  return SettingsState(pref);
});
