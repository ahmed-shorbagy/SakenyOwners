import 'package:flutter/material.dart';
import 'package:sakeny_owners/core/theme/theme_constants.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = darkTheme;
  ThemeData get themeData => _themeData;
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightTheme) {
      themeData = darkTheme;
    } else {
      themeData = lightTheme;
    }
  }
}
