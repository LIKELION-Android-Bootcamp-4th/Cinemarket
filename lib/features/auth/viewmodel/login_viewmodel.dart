import 'package:cinemarket/features/auth/model/login_request.dart';
import 'package:cinemarket/features/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  LoginViewModel({AuthRepository? authRepository})
      : _authRepository = authRepository ?? AuthRepository();

  bool _isLoading = false;
  String? _error;
  Map<String, dynamic>? _loginResult;

  bool get isLoading => _isLoading;
  String? get error => _error;
  Map<String, dynamic>? get loginResult => _loginResult;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _authRepository.login(
        LoginRequest(email: email, password: password),
      );
      _loginResult = response.data;
    } catch (e) {
      _error = '로그인 실패: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
