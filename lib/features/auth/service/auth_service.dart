import 'package:cinemarket/core/network/api_client.dart';
import 'package:cinemarket/core/storage/token_storage.dart';
import 'package:cinemarket/features/auth/model/login_request.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

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
        '/api/auth/check-email?email=$email',
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

  Future<Response> checkValidNickName(String nickName) async {
    try {
      final response = await _dio.get(
        '/api/auth/check-nickname?nickName=$nickName',
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

  Future<Response> editProfile({
    required String nickName,
    required String phone,
    required String address1,
    required String address2,
    required String zipCode,
  }) async {
    try {
      final addressPayload = {
        'zipCode': zipCode,
        'address1': address1,
        'address2': address2,
      };
      print('address payload: ' + addressPayload.toString());
      final formData = FormData.fromMap({
        'nickName': nickName,
        'phone': phone,
        'address': jsonEncode(addressPayload),
      });

      final response = await _dio.patch(
        '/api/mypage/profile',
        data: formData,
        options: Options(
          headers: {
            'X-Company-Code': '685f69fc439922c09c21aef0',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
