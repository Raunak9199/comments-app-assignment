import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/app_color.dart';

class AppElevatedButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool isValid;
  final bool isLoading;
  final bool isOutlined;
  final bool isUpperCase;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final Color? textIconColor;
  final String? leftIcon;
  final String? rightIcon;
  final TextStyle? style;
  final double radius;
  final double iconSize;

  const AppElevatedButton({
    super.key,
    required this.title,
    this.onPressed,
    this.isValid = false,
    this.isLoading = false,
    this.isOutlined = false,
    this.isUpperCase = false,
    this.width,
    this.height,
    this.margin,
    this.color,
    this.textIconColor,
    this.leftIcon,
    this.rightIcon,
    this.style,
    this.radius = 200,
    this.iconSize = 22,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (isValid && !isLoading && !isOutlined) {
      return AppRaisedButton(
        margin: margin,
        onTap: onPressed,
        color: color,
        textIconColor: textIconColor,
        height: height,
        radius: radius,
        leftIcon: leftIcon,
        rightIcon: rightIcon,
        iconSize: iconSize,
        width: width ?? MediaQuery.of(context).size.width,
        buttonChild: Text(
          isUpperCase ? title.toUpperCase() : title,
          style: style ??
              theme.textTheme.bodyLarge?.copyWith(
                color: textIconColor ?? Colors.white,
              ),
        ),
      );
    }

    if (isOutlined) {
      return Container(
        margin: margin,
        child: GestureDetector(
          onTap: onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: width ?? MediaQuery.of(context).size.width,
            height: height ?? 38.h,
            decoration: BoxDecoration(
              border: Border.all(color: color ?? Colors.green),
              borderRadius: BorderRadius.circular(radius),
            ),
            child: Center(
              child: Text(
                isUpperCase ? title.toUpperCase() : title,
                style: style ??
                    theme.textTheme.bodyLarge?.copyWith(
                      color: color ?? Colors.green,
                    ),
              ),
            ),
          ),
        ),
      );
    }

    if (isValid && isLoading) {
      return AppRaisedButton(
        margin: margin,
        width: 70.w,
        height: height,
        radius: 200,
        color: color,
        textIconColor: textIconColor,
        buttonChild: const AppButtonLoader(),
      );
    }

    return Container(
      margin: margin,
      child: InvalidButton(
        width: width,
        height: height,
        title: title,
        radius: radius,
        leftIcon: leftIcon,
        rightIcon: rightIcon,
        iconSize: iconSize,
        style: style,
      ),
    );
  }
}

class InvalidButton extends StatelessWidget {
  const InvalidButton({
    super.key,
    required this.width,
    required this.height,
    required this.title,
    this.isUpperCase = false,
    this.radius,
    this.leftIcon,
    this.rightIcon,
    this.style,
    this.iconSize = 22,
  });

  final double? width;
  final double? height;
  final double? radius;
  final String title;
  final bool isUpperCase;
  final String? leftIcon;
  final String? rightIcon;
  final TextStyle? style;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? 38.h,
      child: ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 200),
          ),
        ),
        child: ((leftIcon?.isEmpty ?? true) && (rightIcon?.isEmpty ?? true))
            ? Center(
                child: Text(
                  isUpperCase ? title.toUpperCase() : title,
                  style: style ??
                      theme.textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                      ),
                ),
              )
            : Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (leftIcon?.isNotEmpty ?? false)
                      Image.asset(
                        leftIcon ?? '',
                        width: iconSize,
                        height: iconSize,
                        color: Colors.white,
                      )
                    else
                      const SizedBox.shrink(),
                    if (leftIcon?.isNotEmpty ?? false)
                      SizedBox(width: 8.w)
                    else
                      const SizedBox.shrink(),
                    Text(
                      isUpperCase ? title.toUpperCase() : title,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    if (rightIcon?.isNotEmpty ?? false)
                      SizedBox(width: 8.w)
                    else
                      const SizedBox.shrink(),
                    if (rightIcon?.isNotEmpty ?? false)
                      Image.asset(
                        rightIcon ?? '',
                        width: iconSize,
                        height: iconSize,
                        color: Colors.white,
                      )
                    else
                      const SizedBox.shrink(),
                  ],
                ),
              ),
      ),
    );
  }
}

class AppRaisedButton extends StatelessWidget {
  const AppRaisedButton({
    super.key,
    this.onTap,
    required this.width,
    required this.height,
    this.radius = 200,
    this.iconSize = 22,
    required this.color,
    required this.buttonChild,
    this.margin,
    this.leftIcon,
    this.rightIcon,
    this.textIconColor,
  });

  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final double radius;
  final double iconSize;
  final Color? color;
  final Widget? buttonChild;
  final EdgeInsetsGeometry? margin;
  final String? leftIcon;
  final String? rightIcon;
  final Color? textIconColor;

  @override
  Widget build(BuildContext context) {
    // final theme = Provider.of<ThemeProvider>(context).themeData;
    return Container(
      margin: margin,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: width ?? MediaQuery.of(context).size.width,
          height: height ?? 38.h,
          decoration: BoxDecoration(
            color: color ?? AppColor.primaryColor,
            borderRadius: BorderRadius.circular(radius.r),
          ),
          child: ((leftIcon?.isEmpty ?? true) && (rightIcon?.isEmpty ?? true))
              ? Center(child: buttonChild)
              : Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (leftIcon?.isNotEmpty ?? false)
                        Image.asset(
                          leftIcon ?? '',
                          width: iconSize.w,
                          height: iconSize.w,
                          color: textIconColor,
                        )
                      else
                        const SizedBox.shrink(),
                      if (leftIcon?.isNotEmpty ?? false)
                        SizedBox(width: 8.w)
                      else
                        const SizedBox.shrink(),
                      buttonChild ?? const SizedBox.shrink(),
                      if (rightIcon?.isNotEmpty ?? false)
                        SizedBox(width: 8.w)
                      else
                        const SizedBox.shrink(),
                      if (rightIcon?.isNotEmpty ?? false)
                        Image.asset(
                          rightIcon ?? '',
                          width: iconSize.w,
                          height: iconSize.w,
                          color: textIconColor,
                        )
                      else
                        const SizedBox.shrink(),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class AppButtonLoader extends StatelessWidget {
  const AppButtonLoader({super.key});

  @override
  Widget build(BuildContext context) => const CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 10.0,
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 3,
        ),
      );
}
