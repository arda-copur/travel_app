import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//Localization initialization for the app
class LocalizationInit {
  static const localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static LocaleResolutionCallback localeResolutionCallback =
      (locale, supportedLocales) {
    if (locale != null && supportedLocales.contains(locale)) {
      return locale;
    }
    return const Locale('de', '');
  };

  static List<Locale> get supportedLocales => AppLocalizations.supportedLocales;
}
