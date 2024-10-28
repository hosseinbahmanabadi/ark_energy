import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../models/auth_model.dart';
import '../models/auth_status.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  final AuthModel _authModel = AuthModel();

  AuthStatus _status = AuthStatus.uninitialized;
  AuthStatus get status => _status;

  // Login method
  Future<void> login(String username, String password) async {
    _status = AuthStatus.authenticating;
    notifyListeners();

    final token = await _authService.authenticate(username, password);
    if (token != null) {
      await _authModel.saveToken(token);
      _status = AuthStatus.authenticated;
    } else {
      _status = AuthStatus.unauthenticated;
    }
    notifyListeners();
  }

  // Check if the user is already logged in
  Future<void> checkLoginStatus() async {
    bool isLoggedIn = await _authModel.isLoggedIn();
    _status = isLoggedIn ? AuthStatus.authenticated : AuthStatus.unauthenticated;
    notifyListeners();
  }

  // Logout method to clear stored data
  Future<void> logout() async {
    await _authModel.clearToken();
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }
}
