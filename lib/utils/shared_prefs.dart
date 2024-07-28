import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _authStatusKey = 'isAuthenticated';

  Future<void> saveAuthState(bool isAuthenticated) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_authStatusKey, isAuthenticated);
  }

  Future<bool> getAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_authStatusKey) ?? false;
  }
}
