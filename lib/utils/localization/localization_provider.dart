import 'package:flutter/material.dart';

class LocalizationProvider extends ChangeNotifier {
  Locale _locale = const Locale('de'); // Default

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!L10n.supportedLocales.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }
}

class L10n {
  static final all = [
    const Locale('de'),
    const Locale('en'),
    const Locale('tr'),
  ];

  static List<Locale> get supportedLocales => all;
}
