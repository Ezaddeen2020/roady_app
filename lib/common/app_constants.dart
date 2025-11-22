import 'package:flutter/material.dart';

class AppConstants {
  static const appId = 'com.fdelux.neytrip';
  static const appName = 'Roady';
  static const appLogo = 'assets/images/logo.png';
  static const categories = ['Beach', 'Mountain', 'City', 'Lake', 'Forest'];
}

/// Extension على Color class لإضافة method withValues
/// يسمح بتعديل قيم alpha, red, green, blue بشكل مرن
extension ColorWithValues on Color {
  Color withValues({
    double? alpha,
    double? red,
    double? green,
    double? blue,
  }) {
    return Color.fromRGBO(
      ((red ?? this.red / 255) * 255).round(),
      ((green ?? this.green / 255) * 255).round(),
      ((blue ?? this.blue / 255) * 255).round(),
      alpha ?? this.opacity,
    );
  }
}
