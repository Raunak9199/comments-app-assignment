import 'package:comments_app_assignment/core/app_color.dart';
import 'package:comments_app_assignment/core/themes/theme_text.dart';
import 'package:comments_app_assignment/features/auth/presentation/providers/auth_provider.dart';
import 'package:comments_app_assignment/global_widgets/app_elevated_button.dart';
import 'package:comments_app_assignment/global_widgets/app_scaffold.dart';
import 'package:comments_app_assignment/global_widgets/app_textform_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  @override
  Widget build(BuildContext context) {
    final userAuthProvider = Provider.of<UserAuthProvider>(context);

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
                title: "Signup",
                radius: 6.r,
                isValid: true,
                isLoading: userAuthProvider.isLoading,
                width: MediaQuery.of(context).size.width / 1.7,
                onPressed: () async {
                  await userAuthProvider.signUp();
                },
              ),
              SizedBox(height: 10.h),
              RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: bodyText3.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: "Login",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          userAuthProvider.navigationService.pop();
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
                SizedBox(height: 100.h),
                AppTextFormField(
                  hintText: "Name",
                  height: 40.h,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                  controller: userAuthProvider.nameController,
                ),
                AppTextFormField(
                  hintText: "Email",
                  height: 40.h,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                  controller: userAuthProvider.emailController,
                ),
                AppTextFormField(
                  hintText: "Password",
                  height: 40.h,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                  controller: userAuthProvider.passwordController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
