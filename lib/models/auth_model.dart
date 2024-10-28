import 'package:shared_preferences/shared_preferences.dart';

class AuthModel {
  static const String authTokenKey = 'authToken';

  // Save token to SharedPreferences
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(authTokenKey, token);
  }

  // Retrieve token from SharedPreferences
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(authTokenKey);
  }

  // Clear token from SharedPreferences
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(authTokenKey);
  }

  // Check if the user is logged in
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }
}
