import 'package:cinemarket/core/storage/token_storage.dart';
import 'package:cinemarket/features/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class MyPageViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  MyPageViewModel({AuthRepository? authRepository})
    : _authRepository = authRepository ?? AuthRepository();

  bool _hasToken = false;
  String? _nickname;
  String? _email;
  String? _profileImage;
  String? _phone;
  String? _address1;
  String? _address2;
  String? _zipCode;
  String? _error;

  bool get hasToken => _hasToken;
  String? get nickname => _nickname;
  String? get email => _email;
  String? get profileImage => _profileImage;
  String? get phone => _phone;
  String? get address1 => _address1;
  String? get address2 => _address2;
  String? get zipCode => _zipCode;
  String? get error => _error;
  String get fullAddress {
    final parts = [_address1, _address2];
    return parts.where((p) => p != null && p!.isNotEmpty).join(' ');
  }

  String get recipientName => _nickname ?? '고객';

  String get safePhone => _phone ?? '';

  Future<void> initialize() async {
    await _checkTokenAndLoadProfile();
  }

  Future<void> _checkTokenAndLoadProfile() async {
    notifyListeners();

    try {
      final String? accessToken = await TokenStorage.getAccessToken();
      _hasToken = accessToken != null && accessToken.isNotEmpty;

      if (_hasToken) {
        print('불러온 액세스 토큰: $accessToken');
        await _fetchProfile(accessToken!);
      }
    } catch (e) {
      _error = '토큰 확인 중 오류가 발생했습니다.';
      print('토큰 확인 실패: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchPassword(
    String currentPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    _error = null;
    if (newPassword != confirmPassword) {
      _error = "새 비밀번호가 일치하지 않습니다.";
      return;
    } else if (currentPassword == newPassword) {
      _error = "현재 비밀번호와 동일합니다.\n새로운 비밀번호를 입력해주세요.";
      return;
    }
    try {
      final response = await _authRepository.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      return response;
    } catch (e) {
      _error = "현재 비밀번호가 일치하지 않습니다.";
      print(e);
    }
  }

  Future<void> _fetchProfile(String accessToken) async {
    try {
      final response = await _authRepository.getProfile(accessToken);
      final data = response.data['data'];
      _nickname = data['nickName'] ?? 'nickName';
      _email = data['email'] ?? 'user@example.com';
      _phone = data['phone'];
      _profileImage = data['profileImage'];
      final addressRaw = data['address'];

      Map<String, dynamic>? addressMap;
      if (addressRaw is String) {
        addressMap = jsonDecode(addressRaw);
      } else if (addressRaw is Map) {
        addressMap = addressRaw.cast<String, String>();
      } else {
        addressMap = {};
      }
      _address1 = addressMap?['address1'] ?? '';
      _address2 = addressMap?['address2'] ?? '';
      _zipCode = addressMap?['zipCode'] ?? '';
    } catch (e) {
      _error = '프로필 조회에 실패했습니다.';
      print('프로필 조회 실패: $e');
    }
  }

  Future<void> logout() async {
    notifyListeners();

    try {
      await TokenStorage.clearTokens();
      _hasToken = false;
      _nickname = null;
      _email = null;
      _profileImage = null;
      _phone = null;
      _address1 = null;
      _address2 = null;
      _zipCode = null;
      _error = null;
    } catch (e) {
      _error = '로그아웃 중 오류가 발생했습니다.';
      print('로그아웃 실패: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> editProfile({
    required String nickName,
    required String phone,
    required String profileImage,
    required String address1,
    required String address2,
    required String zipCode,
  }) async {
    try {
      final response = await _authRepository.editProfile(
        nickName: nickName,
        phone: phone,
        profileImage: profileImage,
        address1: address1,
        address2: address2,
        zipCode: zipCode,
      );
      final data = response.data['data'];
    } catch (e) {
      _error = '프로필 수정에 실패했습니다.';
      notifyListeners();
    }
  }

  void onLoginSuccess() {
    _hasToken = true;
    _error = null;
    notifyListeners();
    _checkTokenAndLoadProfile();
  }

  void setAddress(String address1, String zipCode, String address2) {
    _address1 = address1;
    _zipCode = zipCode;
    _address2 = address2;
    notifyListeners();
  }

  // 에러 초기화
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
