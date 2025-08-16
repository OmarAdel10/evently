import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  String languageCode = 'en';

  void updateLanguage(String language) {
    languageCode = language;
    notifyListeners();
  }
}
