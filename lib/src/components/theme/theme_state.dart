import 'package:flutter/material.dart';
import 'package:is_it_safe_app/src/service/shared_preferences/shared_preferences_service.dart';

enum ThemeType { dark, light }

class ThemeState extends ChangeNotifier {
  late SharedPreferencesService _preferences;
  bool _isDark = false;

  ThemeState() {
    _preferences = SharedPreferencesService();

    getTheme().then((type) {
      _isDark = type == ThemeType.dark;
      notifyListeners();
    });
  }

  ThemeType get theme => _isDark ? ThemeType.dark : ThemeType.light;
  set theme(ThemeType type) => setTheme(type);

  void setTheme(ThemeType type) async {
    _isDark = type == ThemeType.dark;
    _preferences.saveTheme(_isDark);
    if (_isDark) notifyListeners();
  }

  Future<ThemeType> getTheme() async {
    _isDark = await _preferences.readTheme();
    return _isDark ? ThemeType.dark : ThemeType.light;
  }
}
