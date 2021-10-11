import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeType { DARK, LIGHT }

class ThemeState extends ChangeNotifier {
  bool _isDarkTheme = false;

  ThemeState() {
    getTheme().then((type) {
      _isDarkTheme = type == ThemeType.DARK;
      notifyListeners();
    });
  }

  ThemeType get theme => _isDarkTheme ? ThemeType.DARK : ThemeType.LIGHT;
  set theme(ThemeType type) => setTheme(type);

  void setTheme(ThemeType type) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _isDarkTheme = type == ThemeType.DARK;
    bool status = await preferences.setBool('isDark', _isDarkTheme);

    if (status) notifyListeners();
  }

  Future<ThemeType> getTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _isDarkTheme = preferences.getBool('isDark') ?? false;
    return _isDarkTheme ? ThemeType.DARK : ThemeType.LIGHT;
  }
}
