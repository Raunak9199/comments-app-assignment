import 'dart:math';

import 'package:flutter/material.dart';

class AppColor {
  AppColor._();
  static const Color primaryColor = Color(0xFF0C54BE);
  static const Color secondaryColor = Color(0xFF303F60);
  static const Color lightColorColor = Color(0xFFF5F9FD);
  static const Color greyColor = Color(0xFFCED3DC);
  static const Color blackColor = Color.fromARGB(255, 16, 17, 17);
  static const Color errorColor = Color.fromARGB(255, 216, 71, 13);

  static MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }

  static int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  static Color tintColor(Color color, double factor) => Color.fromRGBO(
        tintValue(color.red, factor),
        tintValue(color.green, factor),
        tintValue(color.blue, factor),
        1,
      );

  static int shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  static Color shadeColor(Color color, double factor) => Color.fromRGBO(
        shadeValue(color.red, factor),
        shadeValue(color.green, factor),
        shadeValue(color.blue, factor),
        1,
      );
}
