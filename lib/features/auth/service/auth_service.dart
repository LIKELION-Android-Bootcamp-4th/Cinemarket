import 'package:cinemarket/core/network/api_client.dart';
import 'package:cinemarket/features/auth/model/login_request.dart';
import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio = ApiClient.dio;

  Future<Response> login(LoginRequest request) async {
    try {
      // 1. Dio를 사용해 /api/auth/login으로 POST 요청 (email, password 전달)
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
      return response; // 2. 응답 반환 (성공 시)
    } catch (e) {
      rethrow; // 3. 에러 발생 시 상위로 에러 전달
    }
  }

  Future<Response> logout() async {
    try {
      final response = await _dio.post(
        '/api/auth/logout',
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
}
