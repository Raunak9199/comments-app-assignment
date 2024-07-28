import 'package:flutter/material.dart';

import '../core/app_color.dart';
import 'app_appbar.dart';
import 'app_dialog_box.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    this.scaffoldKey,
    this.drawer,
    this.isConfirmExit = false,
    this.isConfirmLogOut = false,
    this.backgroundColor,
    required this.body,
    this.appBar,
    this.onWillPop,
    this.resizeToAvoidBottomInset = false,
    this.floatingActionButtonLocation =
        FloatingActionButtonLocation.centerFloat,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.withBackground = true,
    this.withScrollable = false,
    this.haveAppBar = false,
  });
  final Key? scaffoldKey;
  final bool isConfirmExit;
  final bool isConfirmLogOut;
  final Color? backgroundColor;
  final Widget? body;
  final AppNewAppBar? appBar;
  final Future<bool> Function()? onWillPop;
  final bool? resizeToAvoidBottomInset;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final bool withBackground;
  final bool withScrollable;
  final bool haveAppBar;

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: onWillPop ??
            () {
              if (isConfirmExit) {
                openAppDialog(
                  context: context,
                  params: OpenDialogModel(
                    title: "Exit App?",
                    subTitle: "Are you sure, you want to exit the app?",
                  ),
                );
              } else if (isConfirmLogOut) {
                openAppDialog(
                  context: context,
                  params: OpenDialogModel(
                      title: "Logout",
                      subTitle: "Are you sure, you want to logout?",
                      onConfirm: () {
                        // TODO
                      }
                      // onConfirm: () async => AuthUtils.clearData(),
                      ),
                );
              }
              return Future.value(true);
            },
        child: Scaffold(
          key: scaffoldKey,
          drawer: drawer,
          backgroundColor: backgroundColor ?? AppColor.lightColorColor,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          floatingActionButtonLocation: floatingActionButtonLocation,
          floatingActionButton: floatingActionButton,
          bottomNavigationBar: bottomNavigationBar,
          appBar: appBar,
          body: body,
        ),
      );
}
