import 'package:comments_app_assignment/core/app_color.dart';
import 'package:comments_app_assignment/core/routes/app_routes.dart';
import 'package:comments_app_assignment/core/themes/theme_text.dart';
import 'package:comments_app_assignment/features/auth/presentation/providers/auth_provider.dart';
import 'package:comments_app_assignment/global_widgets/app_elevated_button.dart';
import 'package:comments_app_assignment/global_widgets/app_scaffold.dart';
import 'package:comments_app_assignment/global_widgets/app_textform_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserAuthProvider>(context);
    return SafeArea(
      child: AppScaffold(
        backgroundColor: AppColor.lightColorColor,
        bottomNavigationBar: Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(bottom: 50.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppElevatedButton(
                title: "Login",
                radius: 6.r,
                isValid: true,
                isLoading: authProvider.isLoading,
                width: MediaQuery.of(context).size.width / 1.7,
                onPressed: () async {
                  await authProvider.login();
                  if (authProvider.isAuthenticated) {
                    authProvider.navigationService
                        .navigateAndRemoveUntil(Routes.homeview);
                  }
                },
              ),
              SizedBox(height: 10.h),
              RichText(
                text: TextSpan(
                  text: "New here? ",
                  style: bodyText3.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: "Signup",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          authProvider.navigationService
                              .navigateTo(Routes.signupview);
                          // Navigator.of(context).pushNamed(Routes.signupview);
                        },
                      style: bodyText3.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Comments",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryColor,
                          ),
                    ),
                  ],
                ),
                SizedBox(height: 150.h),
                AppTextFormField(
                  hintText: "Email",
                  controller: authProvider.loginEmailController,
                  height: 40.h,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                ),
                AppTextFormField(
                  hintText: "Password",
                  height: 40.h,
                  controller: authProvider.loginPasswordController,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
