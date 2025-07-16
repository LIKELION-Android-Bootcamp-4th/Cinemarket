import 'package:flutter/material.dart';
import 'package:cinemarket/core/storage/token_storage.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  AuthProvider() {
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    _isLoggedIn = await TokenStorage.isLoggedIn();
    notifyListeners();
  }

  Future<void> login() async {
    await checkLoginStatus();
  }

  Future<void> logout() async {
    await TokenStorage.clearTokens();
    await checkLoginStatus();
  }
} 