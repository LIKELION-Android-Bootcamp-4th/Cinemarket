import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/widgets/common_app_bar.dart';
import 'package:cinemarket/widgets/common_toast.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

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
              onPressed: () async {
                // 1. 입력값 가져오기
                final email = emailController.text.trim();
                final password = passwordController.text.trim();

                // 2. 입력값이 비었는지 확인
                if (email.isEmpty || password.isEmpty) {
                  // 입력값이 없으면 에러 토스트 출력 후 함수 종료
                  CommonToast.show(context: context, message: "이메일과 비밀번호를 입력하세요.", type: ToastificationType.error);
                  return;
                }
                try {
                  // 3. LoginViewModel 인스턴스 생성 (Provider 등 상태관리 미사용 예시)
                  final loginViewModel = LoginViewModel();
                  // 4. 로그인 시도 (아래 login 함수에서 실제 API 요청)
                  await loginViewModel.login(email, password);
                  // 5. 에러가 있으면 에러 토스트 출력
                  if (loginViewModel.error != null) {
                    CommonToast.show(context: context, message: loginViewModel.error!, type: ToastificationType.error);
                  } else {
                    // 6. 로그인 성공 시 콜백 및 토스트, 화면 이동
                    if (onLoginSuccess != null) {
                      onLoginSuccess!();
                    }
                    if (extra != null) {
                      extra();
                    }
                    CommonToast.show(context: context, message: "로그인 되었습니다.", type: ToastificationType.success);
                    context.pop();
                  }
                } catch (e) {
                  // 7. 예외 발생 시 에러 토스트 출력
                  CommonToast.show(context: context, message: "로그인 중 오류가 발생했습니다.", type: ToastificationType.error);
                }
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
              onPressed: () {
                context.push(
                  '/signUp',
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
