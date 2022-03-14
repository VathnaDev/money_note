import 'package:flutter/material.dart';

class AppThemeState extends ChangeNotifier {
  var isDarkModeEnabled = true;

  void setLightTheme() {
    isDarkModeEnabled = false;
    notifyListeners();
  }

  void setDarkTheme() {
    isDarkModeEnabled = true;
    notifyListeners();
  }
}
