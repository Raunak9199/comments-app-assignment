import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_color.dart';
import 'theme_text.dart';

final radius = Radius.circular(6.r);

final _borderStyle = UnderlineInputBorder(
  borderRadius: BorderRadius.only(
    topLeft: radius,
    topRight: radius,
  ),
  borderSide: const BorderSide(color: AppColor.lightColorColor, width: 0.8),
);

final _focusedBorderStyle = UnderlineInputBorder(
  borderRadius: BorderRadius.only(
    topLeft: radius,
    topRight: radius,
  ),
);

final _errorBorder = UnderlineInputBorder(
  borderRadius: BorderRadius.only(
    topLeft: radius,
    topRight: radius,
  ),
  borderSide: const BorderSide(color: AppColor.errorColor),
);

ThemeData buildMyTheme(BuildContext context) {
  return ThemeData(
    // fontFamily: ,
    dividerColor: Colors.transparent,
    primaryColor: AppColor.secondaryColor,
    textTheme: textTheme,
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: AppColor.secondaryColor,
      hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColor.greyColor,
            fontWeight: FontWeight.normal,
          ),
      labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColor.greyColor,
            fontWeight: FontWeight.normal,
          ),
      border: _borderStyle,
      enabledBorder: _borderStyle,
      focusedBorder: _focusedBorderStyle,
      errorBorder: _errorBorder,
      disabledBorder: _borderStyle,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColor.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: AppColor.generateMaterialColor(AppColor.primaryColor),
    ).copyWith(error: AppColor.primaryColor),
  );
}
