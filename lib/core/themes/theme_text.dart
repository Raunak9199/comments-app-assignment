import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_color.dart';

final TextStyle _headline1 = GoogleFonts.poppins(
  fontSize: 70.sp,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  color: AppColor.blackColor,
);
// final TextStyle _headline1 = TextStyle(
//   fontFamily: GoogleFonts.poppins.toString(),
//   fontSize: 70.sp,
//   fontStyle: FontStyle.normal,
//   fontWeight: FontWeight.w500,
//   color: AppColor.blackColor,
// );

final TextStyle _headline2 = GoogleFonts.poppins(
  fontSize: 64.sp,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  color: AppColor.blackColor,
);

final TextStyle _headline3 = GoogleFonts.poppins(
  fontSize: 48.sp,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  color: AppColor.blackColor,
);

final TextStyle _subheading1 = GoogleFonts.poppins(
  fontSize: 36.sp,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  color: AppColor.blackColor,
);

final TextStyle _subheading2 = GoogleFonts.poppins(
  fontSize: 32.sp,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  color: AppColor.blackColor,
);
final TextStyle subheading3 = GoogleFonts.poppins(
  fontSize: 26.sp,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
  color: AppColor.blackColor,
);

final TextStyle subheading4 = GoogleFonts.poppins(
  fontSize: 22.sp,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  color: AppColor.blackColor,
);

final TextStyle subheading5 = GoogleFonts.poppins(
  fontSize: 20.sp,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  color: AppColor.blackColor,
);

final TextStyle subheading6 = GoogleFonts.poppins(
  fontSize: 16.sp,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w700,
  color: AppColor.blackColor,
);

final TextStyle subheading7 = GoogleFonts.poppins(
  fontSize: 20.sp,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w700,
  color: AppColor.blackColor,
);
final TextStyle _bodyText1 = GoogleFonts.poppins(
  fontSize: 18.sp,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  //letterSpacing: 0.2,
  color: AppColor.blackColor,
);

final TextStyle _bodyText2 = GoogleFonts.poppins(
  fontSize: 22.sp,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  //letterSpacing: 1.0,
  color: AppColor.blackColor,
);

final TextStyle bodyText3 = GoogleFonts.poppins(
  fontSize: 14.sp,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  color: AppColor.blackColor,
);

final TextStyle _button = GoogleFonts.poppins(
  fontSize: 12.sp,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w600,
  letterSpacing: 1.5,
  color: AppColor.blackColor,
);

final TextStyle _caption = GoogleFonts.poppins(
  fontSize: 12.sp,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
  color: AppColor.blackColor,
);

TextTheme textTheme = GoogleFonts.poppinsTextTheme(
  TextTheme(
    displayLarge: _headline1,
    displayMedium: _headline2,
    displaySmall: _headline3,
    titleMedium: _subheading1,
    titleSmall: _subheading2,
    bodyLarge: _bodyText1,
    bodyMedium: _bodyText2,
    labelLarge: _button,
    bodySmall: _caption,
  ),
);
