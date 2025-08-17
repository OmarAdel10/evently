import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  String languageCode = 'en';

  void lastLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final isArabicLast = prefs.getBool('isarabic') ?? false;
    print(isArabicLast);
    if (isArabicLast) {
      languageCode = 'ar';
    } else {
      languageCode = 'en';
    }
    notifyListeners();
  }

  void updateLanguage(String language) {
    languageCode = language;
    notifyListeners();
  }
}
