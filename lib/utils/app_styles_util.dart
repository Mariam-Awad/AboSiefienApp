import 'package:flutter/material.dart';

class AppStylesUtil {
  static TextStyle? textBoldStyle(
          double size, Color textColor, FontWeight weight) =>
      TextStyle(
        fontSize: size,
        fontFamily: 'Tajawal',
        color: textColor,
        fontWeight: weight,
      );

  static TextStyle? textRegularStyle(
          double size, Color textColor, FontWeight weight) =>
      TextStyle(
        fontSize: size,
        fontFamily: 'Tajawal',
        color: textColor,
        fontWeight: weight,
      );
}
