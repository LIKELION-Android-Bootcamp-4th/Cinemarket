import 'package:cinemarket/features/auth/model/login_request.dart';
import 'package:cinemarket/features/auth/service/auth_service.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository({AuthService? authService})
      : _authService = authService ?? AuthService();

  Future<Response> login(LoginRequest request) async {
    // 1. AuthService의 login 메서드 호출 (실제 네트워크 요청)
    return await _authService.login(request);
  }

  Future<Response> logout() async {
    return await _authService.logout();
  }
}
