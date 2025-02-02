import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/app_color.dart';

class OpenDialogModel {
  final String title;
  final String? subTitle;
  final Widget? body;
  final String? cancelText;
  final String? confirmText;
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;
  final IconData? trailingIcon;
  final bool isDismissible;
  final bool showConfirmButton;
  final TextStyle? titleStyle;
  final List<Widget>? actions;
  final bool isActionRequired;
  final ShapeBorder? shape;
  final double? borderRadius;

  OpenDialogModel({
    required this.title,
    this.subTitle,
    this.body,
    this.cancelText,
    this.confirmText,
    this.onCancel,
    this.onConfirm,
    this.trailingIcon,
    this.titleStyle,
    this.actions,
    this.isDismissible = false,
    this.showConfirmButton = true,
    this.isActionRequired = true,
    this.shape,
    this.borderRadius,
  });
}

class _Title extends StatelessWidget {
  final OpenDialogModel params;

  const _Title({required this.params});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      // visible: params.title?.isNotEmpty ?? false,
      visible: params.title.isNotEmpty,
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        children: [
          Text(
            '${params.title} ',
            textAlign: TextAlign.center,
            style: params.titleStyle ??
                Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColor.secondaryColor,
                    ),
          ),
          if (params.trailingIcon != null) Icon(params.trailingIcon),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.params});

  final OpenDialogModel params;

  @override
  Widget build(BuildContext context) {
    return params.body != null
        ? params.body!
        : (params.subTitle?.isNotEmpty == true)
            ? Text(
                params.subTitle!,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              )
            : const SizedBox();
  }
}

Future<bool?> openAppDialog(
    {required OpenDialogModel params, required BuildContext context}) {
  final shape =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r));
  //...
  return showDialog<bool>(
    context: context,
    barrierDismissible: params.isDismissible,
    builder: (BuildContext context) => WillPopScope(
      onWillPop: () =>
          params.isDismissible ? Future.value(true) : Future.value(false),
      child: AlertDialog(
        //...
        shape: shape,
        title: _Title(params: params),
        content: _Content(params: params),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: params.actions ??
            (params.isActionRequired
                ? <Widget>[
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColor.primaryColor),
                      ),
                      onPressed:
                          params.onCancel ?? () => Navigator.pop(context),
                      child: Text(
                        params.cancelText != null
                            ? params.cancelText!.toUpperCase()
                            : "No".toUpperCase(),
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: AppColor.blackColor.withOpacity(0.7),
                            ),
                      ),
                    ),
                    if (params.showConfirmButton)
                      ElevatedButton(
                        onPressed: params.onConfirm ?? SystemNavigator.pop,
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: AppColor.secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                        child: Text(
                          params.confirmText != null
                              ? params.confirmText!.toUpperCase()
                              : "yes".toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: AppColor.lightColorColor),
                        ),
                      ),
                  ]
                : null),
      ),
    ),
  );
}

Future openCustomAppDialog(
        {required OpenDialogModel params,
        required BuildContext context}) async =>
    showDialog(
      context: context,
      barrierDismissible: params.isDismissible,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () =>
            params.isDismissible ? Future.value(true) : Future.value(false),
        child: AlertDialog(
          shape: params.shape ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(params.borderRadius ?? 8.r),
              ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          iconPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          buttonPadding: EdgeInsets.zero,
          actionsPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
