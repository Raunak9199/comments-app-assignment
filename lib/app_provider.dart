import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => navigatorKey.currentState;

  //* Navigate to a named route
  Future<void> navigateTo(String routeName, {Object? arguments}) async {
    if (_navigator != null) {
      await _navigator!.pushNamed(routeName, arguments: arguments);
    }
  }

  //* Replace the current route with a named route
  Future<void> replaceWith(String routeName, {Object? arguments}) async {
    if (_navigator != null) {
      await _navigator!.pushReplacementNamed(routeName, arguments: arguments);
    }
  }

  //* Navigate and remove all previous routes
  Future<void> navigateAndRemoveUntil(String routeName,
      {Object? arguments}) async {
    if (_navigator != null) {
      await _navigator!.pushNamedAndRemoveUntil(
        routeName,
        (route) => false,
        arguments: arguments,
      );
    }
  }

  //* Pop the current route
  void pop() {
    if (_navigator != null) {
      _navigator!.pop();
    }
  }

  //* Pop the current route with a result
  void popWithResult<T>(T result) {
    if (_navigator != null) {
      _navigator!.pop(result);
    }
  }

  //* Replace the current route with a new route and remove all previous routes
  Future<void> replaceAllWith(String routeName, {Object? arguments}) async {
    if (_navigator != null) {
      await _navigator!.pushNamedAndRemoveUntil(
        routeName,
        (route) => false,
        arguments: arguments,
      );
    }
  }
/* 
  // Return the current route name
  String? currentRouteName() {
    return _navigator?.currentRoute?.settings.name;
  } */
}
