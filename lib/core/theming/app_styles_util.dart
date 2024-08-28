import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStylesUtil {
  static TextStyle? textBoldStyle(
          double size, Color textColor, FontWeight weight) =>
      TextStyle(
        fontSize: size.sp,
        fontFamily: 'Tajawal',
        color: textColor,
        fontWeight: weight,
      );

  static TextStyle? textRegularStyle(
          double size, Color textColor, FontWeight weight) =>
      TextStyle(
        fontSize: size.sp,
        fontFamily: 'Tajawal',
        color: textColor,
        fontWeight: weight,
      );
}
