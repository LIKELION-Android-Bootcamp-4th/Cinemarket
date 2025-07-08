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
      return response; // 2. 응답 반환 (성공 시)
    } catch (e) {
      rethrow; // 3. 에러 발생 시 상위로 에러 전달
    }
  }

  Future<Response> getProfile(String accessToken) async {
    try {
      final response = await _dio.get(
        '/api/mypage/profile',
        options: Options(
          headers: {
            /*'X-Company-Code': '685f69fc439922c09c21aef0',
            'Content-Type': 'application/json',*/
          },
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
