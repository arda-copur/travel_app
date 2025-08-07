import 'package:flutter/material.dart';

// This class defines the app's color scheme and themes
class AppColors {
  static const Color primaryColor = Color(0xFF673AB7); // Deep Purple 500
  static const Color primaryLight = Color(0xFF9575CD); // Deep Purple 300
  static const Color primaryDark = Color(0xFF311B92); // Deep Purple 900
  static const Color accentColor = Color(0xFFFFC107); // Amber 500
  static const Color accentLight = Color(0xFFFFECB3); // Amber 100
  static const Color accentDark = Color(0xFFFFA000); // Amber 700
  static const Color backgroundColorLight = Color(0xFFF8F9FA); // Açık gri
  static const Color backgroundColorDark = Color(0xFF1A1A2E); // Koyu mavi/mor
  static const Color textColorLight = Color(0xFF212121); // Koyu gri
  static const Color textColorDark = Color(0xFFE0E0E0); // Açık gri
  static const Color cardColorLight = Colors.white;
  static const Color cardColorDark = Color(0xFF2C2C4A); // Koyu mor
  static const Color errorColor = Color(0xFFD32F2F); // Kırmızı
  static const Color successColor = Color(0xFF388E3C); // Yeşil
  static const Color infoColor = Color(0xFF1976D2); // Mavi
}

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.backgroundColorLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
      elevation: 8,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.accentColor,
      foregroundColor: Colors.white,
      elevation: 8,
    ),
    cardTheme: CardTheme(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      color: AppColors.cardColorLight,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.backgroundColorLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
            color: AppColors.primaryColor.withOpacity(0.3), width: 1),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 22),
      labelStyle: TextStyle(color: AppColors.textColorLight.withOpacity(0.7)),
      hintStyle: TextStyle(color: AppColors.textColorLight.withOpacity(0.5)),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      buttonColor: AppColors.primaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 35),
        textStyle: const TextStyle(
            fontSize: 19, fontWeight: FontWeight.bold, letterSpacing: 0.8),
        elevation: 8,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
      ),
    ),
    colorScheme:
        ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple).copyWith(
      primary: AppColors.primaryColor,
      secondary: AppColors.accentColor,
      background: AppColors.backgroundColorLight,
      onBackground: AppColors.textColorLight,
      surface: AppColors.cardColorLight,
      onSurface: AppColors.textColorLight,
      error: AppColors.errorColor,
      onError: Colors.white,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
          fontSize: 38,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor),
      headlineMedium: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor),
      headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor),
      titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.textColorLight),
      titleMedium: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w600,
          color: AppColors.textColorLight),
      titleSmall: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: AppColors.textColorLight),
      bodyLarge: TextStyle(fontSize: 17, color: AppColors.textColorLight),
      bodyMedium: TextStyle(fontSize: 15, color: AppColors.textColorLight),
      labelLarge: TextStyle(
          fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
      labelMedium: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
      labelSmall: TextStyle(
          fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryLight,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.backgroundColorDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryDark,
      foregroundColor: Colors.white,
      elevation: 8,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.accentDark,
      foregroundColor: Colors.white,
      elevation: 8,
    ),
    cardTheme: CardTheme(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      color: AppColors.cardColorDark,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.cardColorDark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
            color: AppColors.primaryLight.withOpacity(0.3), width: 1),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 22),
      labelStyle: TextStyle(color: AppColors.textColorDark.withOpacity(0.7)),
      hintStyle: TextStyle(color: AppColors.textColorDark.withOpacity(0.5)),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      buttonColor: AppColors.primaryLight,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 35),
        textStyle: const TextStyle(
            fontSize: 19, fontWeight: FontWeight.bold, letterSpacing: 0.8),
        elevation: 8,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryLight,
        textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
      ),
    ),
    colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.deepPurple, brightness: Brightness.dark)
        .copyWith(
      primary: AppColors.primaryDark,
      secondary: AppColors.accentDark,
      background: AppColors.backgroundColorDark,
      onBackground: AppColors.textColorDark,
      surface: AppColors.cardColorDark,
      onSurface: AppColors.textColorDark,
      error: AppColors.errorColor,
      onError: Colors.white,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
          fontSize: 38,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryLight),
      headlineMedium: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryLight),
      headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryLight),
      titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.textColorDark),
      titleMedium: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w600,
          color: AppColors.textColorDark),
      titleSmall: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: AppColors.textColorDark),
      bodyLarge: TextStyle(fontSize: 17, color: AppColors.textColorDark),
      bodyMedium: TextStyle(fontSize: 15, color: AppColors.textColorDark),
      labelLarge: TextStyle(
          fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
      labelMedium: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
      labelSmall: TextStyle(
          fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
    ),
  );
}
