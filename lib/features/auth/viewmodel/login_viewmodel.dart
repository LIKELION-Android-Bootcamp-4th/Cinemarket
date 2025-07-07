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
    _isLoading = true;      // 1. 로딩 상태 true (로딩 시작)
    _error = null;          // 2. 에러 메시지 초기화
    notifyListeners();      // 3. UI에 상태 변경 알림

    try {
      // 4. AuthRepository에 로그인 요청 (실제 네트워크 요청)
      final response = await _authRepository.login(
        LoginRequest(email: email, password: password),
      );
      _loginResult = response.data; // 5. 결과값 저장 (성공 시)
    } catch (e) {
      _error = '이메일이나 비밀번호가 일치하지 않습니다.'; // 6. 에러 발생 시 에러 메시지 저장
    } finally {
      _isLoading = false;   // 7. 로딩 상태 false (로딩 종료)
      notifyListeners();    // 8. UI에 상태 변경 알림
    }
  }
}
