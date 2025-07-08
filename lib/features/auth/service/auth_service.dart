import 'package:cinemarket/core/network/api_client.dart';
import 'package:cinemarket/core/storage/token_storage.dart';
import 'package:cinemarket/features/auth/model/login_request.dart';
import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio = ApiClient.dio;

  Future<Response> login(LoginRequest request) async {
    try {
      final response = await _dio.post(
        '/api/auth/login',
        data: request.toJson(),
        options: Options(
          headers: {
            'X-Company-Code': '685f69fc439922c09c21aef0',
            'Content-Type': 'application/json',
          },
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getProfile(String accessToken) async {
    try {
      final response = await _dio.get('/api/mypage/profile');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> checkValidEmail(String email) async {
    try {
      final response = await _dio.get(
          '/api/auth/check-email?email=$email');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> checkValidNickName(String nickName) async {
    try {
      final response = await _dio.get(
        '/api/auth/check-nickname?nickName=$nickName',
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
