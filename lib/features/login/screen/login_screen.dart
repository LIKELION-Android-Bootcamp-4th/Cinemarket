import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/widgets/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  final VoidCallback? onLoginSuccess;

  const LoginScreen({super.key, this.onLoginSuccess});

  @override
  Widget build(BuildContext context) {
    // GoRouterState에서 extra 파라미터 가져오기
    final extra = GoRouterState.of(context).extra as VoidCallback?;

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: const CommonAppBar(title: '로그인'),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            SizedBox(height: 50.0),

            Image.asset('assets/images/Icon.png', width: 150, height: 150),
            //이미지 교체
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
            SizedBox(height: 90),
            ElevatedButton(
              onPressed: () {
                print('로그인 시도');
                if (onLoginSuccess != null) {
                  onLoginSuccess!();
                }
                if (extra != null) {
                  extra();
                }
                // 로그인 성공 시 토스트 메시지 표시
                Fluttertoast.showToast(
                  msg: "로그인 되었습니다.",
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.grey,
                  textColor: Colors.white,
                  fontSize: 14.0,
                );
                // 로그인 성공 시 마이페이지로 돌아가기
                context.pop();
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
                '로그인',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
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
      ),
    );
  }
}
