import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/widgets/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _hasSignUp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CommonAppBar(title: _hasSignUp ? '회원가입 인증' : '회원가입'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: _hasSignUp ? _buildVerificationView() : _buildSignUpView(),
      ),
    );
  }

  Widget _buildVerificationView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 50.0),

            Image.asset('assets/images/Icon.png', width: 150, height: 150),
            SizedBox(height: 8),
            Text(
              'Cinemarket',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50.0),

            TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: '이메일 인증코드 입력',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: AppColors.textPrimary,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            SizedBox(height: 50.0),

            ElevatedButton(
              onPressed: () {
                context.go('/home');
                Fluttertoast.showToast(
                  msg: "회원가입을 성공했습니다.",
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.grey,
                  textColor: Colors.white,
                  fontSize: 14.0,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.widgetBackground,
                foregroundColor: Colors.black,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                '인증하기',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSignUpView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 50.0),

            Image.asset('assets/images/Icon.png', width: 150, height: 150),
            SizedBox(height: 8),
            Text(
              'Cinemarket',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50.0),

            TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: '이메일',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: AppColors.textPrimary,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 30),

            TextField(
              obscureText: true,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: '패스워드',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: AppColors.textPrimary,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            SizedBox(height: 30),

            TextField(
              obscureText: true,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: '패스워드 확인',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: AppColors.textPrimary,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            SizedBox(height: 30),

            TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: '닉네임',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: AppColors.textPrimary,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            SizedBox(height: 45),

            ElevatedButton(
              onPressed: () {
                /*context.go('/home');
                Fluttertoast.showToast(
                  msg: "회원가입을 성공했습니다.",
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.grey,
                  textColor: Colors.white,
                  fontSize: 14.0,
                );*/
                setState(() {
                  _hasSignUp = true;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.widgetBackground,
                foregroundColor: Colors.black,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                '회원가입',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ],
    );
  }
}
