import 'package:clinikk/shared/themes/app_theme.dart';
import 'package:clinikk/shared/themes/dark_theme.dart';
import 'package:clinikk/shared/themes/light_theme.dart';
import 'package:flutter/material.dart';

class ThemeHandler extends ChangeNotifier {
  AppTheme _themeData = DarkTheme();

  AppTheme get themeData => _themeData;

  void setThemeData(AppTheme themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    _themeData = _themeData == DarkTheme() ? LightTheme() : DarkTheme();
    notifyListeners();
  }
}
