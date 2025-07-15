import 'package:cinemarket/features/auth/repository/auth_repository.dart';
import 'package:cinemarket/features/auth/viewmodel/my_page_viewmodel.dart';
import 'package:cinemarket/widgets/common_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SignUpViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  SignUpViewModel({AuthRepository? authRepository})
    : _authRepository = authRepository ?? AuthRepository();

  String? _email;
  String? _nickName;
  String? _error;
  String? _message;

  String? get email => _email;

  String? get nickName => _nickName;

  String? get error => _error;

  String? get message => _message;

  Future<void> checkValidEmail(String email) async {
    _error = null;
    _message = null;
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

    }
  }

  Future<void> checkValidNickName(String nickName) async {
    _error = null;
    _message = null;
    try {
      if (nickName != null && nickName.isNotEmpty) {
        final response = await _authRepository.checkValidNickName(nickName);
        final data = response.data['data'];

        if (data['available'] == true) {
          _nickName = null;
          _error = null;
          _message = data['message'].toString();
        } else {
          _nickName = null;
          _error = data['message'] ?? '이미 사용 중인 닉네임입니다.';
        }
      }
    } catch (e) {
      _nickName = null;
      if (e is DioError) {
        _error = e.response?.data['data']?['message'];
      }

    }
  }

  Future<void> signUp(String email, String password, String nickName) async {
    _error = null;
    _message = null;
    try {
      final response = await _authRepository.signUp(email, password, nickName);
      final data = response.data;
      if (data['success'] == true) {
        _email = null;
        _nickName = null;
        _error = null;
      }
    } catch (e) {
      _error = "실패";

    }
  }

  Future<void> emailAuth(String email, String emailAuthCode) async {
    _error = null;
    _message = null;
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

    }
  }
}
