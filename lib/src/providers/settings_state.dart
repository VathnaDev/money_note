import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:money_note/src/data/settings.dart';
import 'package:money_note/src/providers/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsState extends StateNotifier<Settings> {
  SettingsState(this.sharedPreferences) : super(Settings()) {
    final isDark = sharedPreferences.getBool('isDarkTheme') ?? false;
    final currency = sharedPreferences.getString('currency') ?? "en_US";
    final pinPassword = sharedPreferences.getString('pinPassword') ?? "";
    final reminder = sharedPreferences.getInt('reminder') ??
        DateTime.now().millisecondsSinceEpoch;

    state = Settings(
      currency: currency,
      isDarkMode: isDark,
      pinPassword: pinPassword,
      reminder: DateTime.fromMillisecondsSinceEpoch(reminder),
    );
  }

  final SharedPreferences sharedPreferences;

  void setIsDarkMode(bool isDarkMode) async {
    await sharedPreferences.setBool('isDarkTheme', isDarkMode);
    state = state.copyWith(isDarkMode: isDarkMode);
  }

  void setCurrency(String currency) async {
    await sharedPreferences.setString('currency', currency);
    state = state.copyWith(currency: currency);
  }

  void setPin(String pinPassword) async {
    await sharedPreferences.setString('pinPassword', pinPassword);
    state = state.copyWith(pinPassword: pinPassword);
  }

  void setReminder(DateTime reminder) async {
    await sharedPreferences.setInt('reminder', reminder.millisecondsSinceEpoch);
    state = state.copyWith(reminder: reminder);
  }
}

final settingsStateProvider = StateNotifierProvider<SettingsState, Settings>((ref) {
  final pref = ref.watch(sharedPrefProvider);
  return SettingsState(pref);
});
