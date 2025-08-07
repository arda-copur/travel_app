import 'package:flutter/material.dart';

// This extension provides utility methods for MediaQuery in Flutter
extension MediaQueryExtension on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  double dynamicWidth(double val) => width * val;
  double dynamicHeight(double val) => height * val;

  bool get isSmallScreen => width < 600;
  bool get isMediumScreen => width >= 600 && width < 1200;
  bool get isLargeScreen => width >= 1200;
}
