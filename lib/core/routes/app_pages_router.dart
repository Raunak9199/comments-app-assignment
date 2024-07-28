import 'package:flutter/material.dart';
import 'package:comments_app_assignment/features/auth/presentation/view/login_view.dart';
import 'package:comments_app_assignment/features/auth/presentation/view/signup_view.dart';
import 'package:comments_app_assignment/features/home/presentation/views/home_view.dart';

import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginview:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.signupview:
        return MaterialPageRoute(builder: (_) => const SignupView());
      case Routes.homeview:
        return MaterialPageRoute(builder: (_) => const MyHomePage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
