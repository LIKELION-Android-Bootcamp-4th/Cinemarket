import 'package:cinemarket/core/network/api_client.dart';
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
      final response = await _dio.get('/api/auth/check-email?email=$email');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> checkValidNickName(String nickName) async {
    try {
      final response = await _dio.get(
        '/api/auth/check-nickname?nickname=$nickName',
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> editProfile({
    required String nickName,
    required String phone,
    required String profileImage,
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
      final formData = FormData.fromMap({
        'nickName': nickName,
        'profileImage': profileImage,
        'phone': phone,
        'address': jsonEncode(addressPayload),
      });

      final response = await _dio.patch('/api/mypage/profile', data: formData);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> signUp(
    String email,
    String password,
    String nickName,
  ) async {
    try {
      final formData = {
        'email': email,
        'password': password,
        'nickName': nickName,
      };
      final response = await _dio.post(
        '/api/auth/register/buyer',
        data: jsonEncode(formData),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> emailAuth(String email, String emailAuthCode) async {
    try {
      final formData ={
        'email': email,
        'verificationCode': emailAuthCode,
      };
      final response = await _dio.post(
        '/api/auth/verify-email',
        data: jsonEncode(formData),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
