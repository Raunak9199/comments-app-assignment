import 'package:comments_app_assignment/core/routes/app_routes.dart';
import 'package:comments_app_assignment/features/auth/domain/entities/user_entity.dart';
import 'package:comments_app_assignment/features/auth/domain/repository/auth_repo_interface.dart';
import 'package:comments_app_assignment/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app_provider.dart';

class UserAuthProvider extends ChangeNotifier {
  final AuthRepositoryInterface _repository;
  final SharedPreferencesService sharedPreferencesService;

  UserAuthProvider(this._repository, this._navigationService,
      this.sharedPreferencesService) {
    checkAuthStatus();
  }
  final NavigationService _navigationService;
  NavigationService get navigationService => _navigationService;

  bool isLoading = false;
  bool isAuthenticated = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  Future<void> signUp() async {
    if (_validateSignupFields()) {
      isLoading = true;
      notifyListeners();

      UserEntity user = UserEntity(
        email: emailController.text,
        password: passwordController.text,
        username: nameController.text,
      );

      try {
        await _repository.rgisterUser(user);
        await checkAuthStatus().then((value) async {
          if (isAuthenticated) {
            await _saveAuthState(isAuthenticated);
            navigationService.navigateAndRemoveUntil(Routes.homeview);
            Fluttertoast.showToast(msg: "Signup Successful");
          }
        });
        // isAuthenticated = true;
        notifyListeners();
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      } finally {
        isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<void> login() async {
    if (_validateLoginFields()) {
      isLoading = true;
      notifyListeners();

      UserEntity user = UserEntity(
        email: loginEmailController.text,
        password: loginPasswordController.text,
      );

      try {
        await _repository.signInUser(user);
        await checkAuthStatus().then((value) async {
          if (isAuthenticated) {
            await _saveAuthState(isAuthenticated);
            navigationService.navigateAndRemoveUntil(Routes.homeview);
            Fluttertoast.showToast(msg: "Login Successful");
          }
        });

        isAuthenticated = true;
        notifyListeners();
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      } finally {
        isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<void> logout() async {
    isLoading = true;
    notifyListeners();
    await _repository.logout();
    isAuthenticated = false;
    _removeAuthState();
    await sharedPreferencesService.saveAuthState(false);
    navigationService.replaceAllWith(Routes.loginview);
    Fluttertoast.showToast(msg: "User logged out successfully!!");
    isLoading = false;
    notifyListeners();
  }

  bool get isSignupValid {
    return _validateSignupFields();
  }

  bool _validateSignupFields() {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        nameController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill all the fields");
      return false;
    }
    return true;
  }

  bool _validateLoginFields() {
    if (loginEmailController.text.isEmpty ||
        loginPasswordController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill all the fields");
      return false;
    }
    return true;
  }

  Future<bool?> checkAuthStatus() async {
    isAuthenticated = await _repository.isSignedIn();
    notifyListeners();
    return isAuthenticated;
  }

  Future<void> _saveAuthState(bool isAuthenticated) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAuthenticated', isAuthenticated);
  }

  Future<void> _removeAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isAuthenticated');
  }
}
