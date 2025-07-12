import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/features/auth/viewmodel/login_viewmodel.dart';
import 'package:cinemarket/features/cart/viewmodel/cart_viewmodel.dart';
import 'package:cinemarket/widgets/common_app_bar.dart';
import 'package:cinemarket/widgets/common_toast.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback? onLoginSuccess;

  const LoginScreen({super.key, this.onLoginSuccess});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final extra = GoRouterState.of(context).extra as VoidCallback?;

    return Scaffold(
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
              controller: emailController,
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
              controller: passwordController,
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
                final email = emailController.text.trim();
                final password = passwordController.text.trim();
                print(email);
                print(password);

                if (email.isEmpty || password.isEmpty) {
                  CommonToast.show(
                    context: context,
                    message: "이메일과 비밀번호를 입력하세요.",
                    type: ToastificationType.error,
                  );
                  return;
                }
                try {
                  final loginViewModel = LoginViewModel();
                  await loginViewModel.login(email, password);
                  if (loginViewModel.error != null) {
                    CommonToast.show(
                      context: context,
                      message: loginViewModel.error!,
                      type: ToastificationType.error,
                    );
                  } else {
                    if (widget.onLoginSuccess != null) {
                      widget.onLoginSuccess!();
                    }
                    if (extra != null) {
                      extra();
                    }
                    CommonToast.show(
                      context: context,
                      message: "로그인 되었습니다.",
                      type: ToastificationType.success,
                    );
                    await context.read<CartViewModel>().fetchCartCount();
                    context.pop();
                  }
                } catch (e) {
                  CommonToast.show(
                    context: context,
                    message: "로그인 중 오류가 발생했습니다.",
                    type: ToastificationType.error,
                  );
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
                context.push('/signUp');
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
