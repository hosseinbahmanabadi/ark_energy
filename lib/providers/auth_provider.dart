import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../models/auth_model.dart';
import '../models/auth_status.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  final AuthModel _authModel = AuthModel();

  AuthStatus _status = AuthStatus.uninitialized;
  AuthStatus get status => _status;

  bool _loginAttempted = false; // Track if a login attempt has been made
  String? _errorMessage; // Store error message for failed login

  bool get loginAttempted => _loginAttempted;
  String? get errorMessage => _errorMessage;

  // Login method
  Future<void> login(String username, String password) async {
    _status = AuthStatus.authenticating;
    _loginAttempted = true;
    _errorMessage = null; // Reset error message on new login attempt
    notifyListeners();

    final token = await _authService.authenticate(username, password);
    if (token != null) {
      await _authModel.saveToken(token);
      _status = AuthStatus.authenticated;
    } else {
      _status = AuthStatus.unauthenticated;
      _errorMessage = 'Login failed. Please try again.';
    }
    notifyListeners();
  }

  // Check if the user is already logged in
  Future<void> checkLoginStatus() async {
    bool isLoggedIn = await _authModel.isLoggedIn();
    _status = isLoggedIn ? AuthStatus.authenticated : AuthStatus.unauthenticated;
    _loginAttempted = false; // Reset login attempt status on app startup
    notifyListeners();
  }

  // Logout method to clear stored data
  Future<void> logout() async {
    await _authModel.clearToken();
    _status = AuthStatus.unauthenticated;
    _loginAttempted = false; // Reset login attempt on logout
    _errorMessage = null;
    notifyListeners();
  }

  // Clear login attempt and error message after successful login
  void clearLoginAttempt() {
    _loginAttempted = false;
    _errorMessage = null;
    notifyListeners();
  }
}
