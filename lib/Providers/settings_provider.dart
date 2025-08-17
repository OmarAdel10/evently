import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  String languageCode = 'en';
  ThemeMode themeMode = ThemeMode.light;
  // My first idea to do shared prefs for the localization
  // void lastLanguage() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final isArabicLast = prefs.getBool('isarabic') ?? false;
  //   print(isArabicLast);
  //   if (isArabicLast) {
  //     languageCode = 'ar';
  //   } else {
  //     languageCode = 'en';
  //   }
  //   notifyListeners();
  // }

  // void updateLanguage(String language) {
  //   languageCode = language;
  //   notifyListeners();
  // }

  bool get isArabic => languageCode == 'ar';

  // My second idea to do shared prefs for the localization
  Future<void> loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    languageCode = prefs.getString('languageCode') ?? 'en';
    notifyListeners();
  }

  Future<void> updateLanguage(String newLanguageCode) async {
    if (languageCode == newLanguageCode) return;
    languageCode = newLanguageCode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', newLanguageCode);
    notifyListeners();
  }

  bool get isDark => themeMode == ThemeMode.dark;

  Future<void> updateTheme(ThemeMode newThemeMode) async {
    themeMode = newThemeMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', isDark);
    notifyListeners();
  }

  Future<void> loadSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    bool dark = prefs.getBool('isDark') ?? false;
    if (dark) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
    notifyListeners();
  }
}
