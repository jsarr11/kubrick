import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String _lang = 'el'; // default Greek

  String get lang => _lang;

  void setLanguage(String newLang) {
    _lang = newLang;
    notifyListeners();
  }
}
