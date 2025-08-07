import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/utils/localization/localization_provider.dart';

class LanguageSwitcherButton extends StatelessWidget {
  const LanguageSwitcherButton({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocalizationProvider>(context);
    final currentLocale = provider.locale;

    return PopupMenuButton<Locale>(
      icon: const Icon(Icons.language),
      initialValue: currentLocale,
      onSelected: (Locale locale) {
        provider.setLocale(locale);
      },
      itemBuilder: (context) => L10n.supportedLocales.map((locale) {
        final languageText = _getLanguageText(locale.languageCode);
        final isSelected = locale == currentLocale;
        return PopupMenuItem(
          value: locale,
          child: Row(
            children: [
              Text(languageText),
              const Spacer(),
              if (isSelected) const Icon(Icons.check, color: Colors.blue),
            ],
          ),
        );
      }).toList(),
    );
  }

  String _getLanguageText(String code) {
    switch (code) {
      case 'tr':
        return 'Türkçe';
      case 'en':
        return 'English';
      case 'de':
        return 'Deutsch';
      default:
        return code;
    }
  }
}
