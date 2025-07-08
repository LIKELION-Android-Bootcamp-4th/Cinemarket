import 'package:cinemarket/core/storage/token_storage.dart';
import 'package:cinemarket/features/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';

class MyPageViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  MyPageViewModel({AuthRepository? authRepository})
      : _authRepository = authRepository ?? AuthRepository();

  bool _hasToken = false;
  String? _nickname;
  String? _email;
  String? _profileImage;
  String? _error;

  bool get hasToken => _hasToken;
  String? get nickname => _nickname;
  String? get email => _email;
  String? get profileImage => _profileImage;
  String? get error => _error;

  // 초기화 - 토큰 확인 및 프로필 조회
  Future<void> initialize() async {
    await _checkTokenAndLoadProfile();
  }

  // 토큰 확인 및 프로필 로드
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

  Future<void> _fetchProfile(String accessToken) async {
    try {
      final response = await _authRepository.getProfile(accessToken);
      final data = response.data['data'];
      _nickname = data['nickName'] ?? 'nickName';
      _email = data['email'] ?? 'user@example.com';
      _profileImage = data['profileImage'];
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
      _error = null;
    } catch (e) {
      _error = '로그아웃 중 오류가 발생했습니다.';
      print('로그아웃 실패: $e');
    } finally {
      notifyListeners();
    }
  }

  void onLoginSuccess() {
    _hasToken = true;
    _error = null;
    notifyListeners();
    _checkTokenAndLoadProfile();
  }

  // 에러 초기화
  void clearError() {
    _error = null;
    notifyListeners();
  }
} 
