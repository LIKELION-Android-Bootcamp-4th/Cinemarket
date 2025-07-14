import 'package:cinemarket/features/auth/model/login_request.dart';
import 'package:cinemarket/features/auth/service/auth_service.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository({AuthService? authService})
    : _authService = authService ?? AuthService();

  Future<Response> login(LoginRequest request) async {
    return await _authService.login(request);
  }

  Future<Response> getProfile(String accessToken) async {
    return await _authService.getProfile(accessToken);
  }

  Future<Response> checkValidEmail(String email) async {
    return await _authService.checkValidEmail(email);
  }

  Future<Response> checkValidNickName(String nickName) async {
    return await _authService.checkValidNickName(nickName);
  }

  Future<Response> signUp(
    String email,
    String password,
    String nickName,
  ) async {
    return await _authService.signUp(email, password, nickName);
  }

  Future<Response> editProfile({
    required String nickName,
    required String phone,
    required String profileImage,
    required String address1,
    required String address2,
    required String zipCode,
  }) async {
    return await _authService.editProfile(
      nickName: nickName,
      phone: phone,
      profileImage: profileImage,
      address1: address1,
      address2: address2,
      zipCode: zipCode,
    );
  }

  Future emailAuth(String email, String emailAuthCode) async {
    return await _authService.emailAuth(email, emailAuthCode);
  }

  Future changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    return await _authService.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }
}
