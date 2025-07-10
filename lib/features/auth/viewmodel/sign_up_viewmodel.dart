import 'package:cinemarket/features/auth/repository/auth_repository.dart';
import 'package:cinemarket/features/auth/viewmodel/my_page_viewmodel.dart';
import 'package:cinemarket/widgets/common_toast.dart';
import 'package:flutter/material.dart';

class SignUpViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  SignUpViewModel({AuthRepository? authRepository})
    : _authRepository = authRepository ?? AuthRepository();

  String? _email;
  String? _nickName;
  String? _error;

  String? get email => _email;

  String? get nickName => _nickName;

  String? get error => _error;

  Future<void> checkValidEmail(String email) async {
    try {
      if (email != null && email.isNotEmpty) {
        final response = await _authRepository.checkValidEmail(email);
        final data = response.data['data'];
        if (data['available'] == true) {
          _email = email;
          _error = null;
        } else {
          _email = null;
          _error = data['message'] ?? '이미 사용 중인 이메일입니다.';
        }
      }
    } catch (e) {
      _error = '이메일 중복확인 중 오류가 발생했습니다.';
      print('이메일 중복확인 실패: $e');
    }
  }

  Future<void> checkValidNickName(String nickName) async {
    try {
      if (nickName != null && nickName.isNotEmpty) {
        final response = await _authRepository.checkValidNickName(nickName);
        final data = response.data['data'];
        if (data['available'] == true) {
          _nickName = nickName;
          _error = null;
        } else {
          _nickName = null;
          _error = data['message'] ?? '이미 사용 중인 닉네임입니다.';
        }
      }
    } catch (e) {
      _error = '닉네임 중복확인 중 오류가 발생했습니다.';
      print('닉네임 중복확인 실패: $e');
    }
  }

  Future<void> signUp(String email, String password, String nickName) async {
    try {
      if (email != null && password != null && nickName != null) {
        final response = await _authRepository.signUp(
          email,
          password,
          nickName,
        );
        final data = response.data['data'];
        if (data['code'] == 0000) {
          _email = email;
          _nickName = nickName;
          _error = null;
        }
      }
    } catch (e) {
      _error = '회원가입 중 오류가 발생했습니다.';
      print('회원가입 실패: $e');
    }
  }

  Future<void> emailAuth(String email, String emailAuthCode) async {
    try {
      if (email != null && emailAuthCode != null) {
        final response = await _authRepository.emailAuth(email, emailAuthCode);
        final data = response.data['data'];
        if (data['code'] == 0000) {
          _error = null;
        }
      }
    } catch (e) {
      _error = '이메일 인증 중 오류가 발생했습니다.';
      print('이메일 인증 실패: $e');
    }
  }
}
