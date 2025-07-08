import 'package:cinemarket/features/auth/model/login_request.dart';
import 'package:cinemarket/features/auth/repository/auth_repository.dart';
import 'package:cinemarket/core/storage/token_storage.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  LoginViewModel({AuthRepository? authRepository})
      : _authRepository = authRepository ?? AuthRepository();

  String? _error;
  Map<String, dynamic>? _loginResult;

  String? get error => _error;
  Map<String, dynamic>? get loginResult => _loginResult;

  Future<void> login(String email, String password) async {
    _error = null;
    notifyListeners();

    try {
      final response = await _authRepository.login(
        LoginRequest(email: email, password: password),
      );
      _loginResult = response.data;
      if (_loginResult != null && _loginResult!['data'] != null) {
        await TokenStorage.saveAccessToken(_loginResult!['data']['accessToken']);
        await TokenStorage.saveRefreshToken(_loginResult!['data']['refreshToken']);
      }
    } catch (e) {
      _error = '이메일이나 비밀번호가 일치하지 않습니다.';
    } finally {
      notifyListeners();
    }
  }
}
