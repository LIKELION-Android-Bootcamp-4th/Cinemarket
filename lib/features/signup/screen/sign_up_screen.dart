import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/auth/viewmodel/sign_up_viewmodel.dart';
import 'package:cinemarket/widgets/common_app_bar.dart';
import 'package:cinemarket/widgets/common_toast.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordCheckController = TextEditingController();
  final TextEditingController nickNameController = TextEditingController();

  final TextEditingController emailAuthCode = TextEditingController();
  bool _hasSignUp = false;
  bool _hasValidEmail = false;
  bool _hasValidNickName = false;

  final signupViewModel = SignUpViewModel();

  String get email => emailController.text;

  String get password => passwordController.text;

  String get nickName => nickNameController.text;

  @override
  void dispose() {
    emailController.dispose();
    nickNameController.dispose();
    super.dispose();
  }

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
            SizedBox(height: 25.0),

            Image.asset('assets/images/Icon.png', width: 120, height: 120),
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
                enabled: false,
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: AppColors.textPrimary,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 25.0),

            TextField(
              controller: emailAuthCode,
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
              onPressed: () async {
                await signupViewModel.emailAuth(email, emailAuthCode.text);

                if (signupViewModel.error != null) {
                  CommonToast.show(
                    context: context,
                    message: signupViewModel.error.toString(),
                    type: ToastificationType.error,
                  );
                  return;
                }
                context.go('/home');
                CommonToast.show(
                  context: context,
                  message: "회원가입을 성공했습니다.",
                  type: ToastificationType.success,
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

            SizedBox(height: 16),

            ElevatedButton(
              onPressed: () async {
                final email = emailController.text.trim();
                if (email.isEmpty) {
                  CommonToast.show(
                    context: context,
                    message: "이메일을 입력해주세요.",
                    type: ToastificationType.info,
                  );
                  return;
                }
                try {
                  await signupViewModel.checkValidEmail(email);
                  if (signupViewModel.error != null) {
                    CommonToast.show(
                      context: context,
                      message: "이미 사용중인 이메일 입니다.",
                      type: ToastificationType.info,
                    );
                    setState(() {
                      _hasValidEmail = false;
                    });

                  } else {
                    setState(() {
                      _hasValidEmail = true;
                    });
                    CommonToast.show(
                      context: context,
                      message: "사용 가능한 이메일 입니다.",
                      type: ToastificationType.success,
                    );
                  }
                } catch (e) {
                  CommonToast.show(
                    context: context,
                    message: "이메일 중복확인 중 오류가 발생했습니다.",
                    type: ToastificationType.error,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.widgetBackground,
                foregroundColor: Colors.black,
                minimumSize: Size(double.infinity, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('이메일 중복확인', style: AppTextStyle.body),
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

            SizedBox(height: 30),

            TextField(
              controller: passwordCheckController,
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
              controller: nickNameController,
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

            SizedBox(height: 16),

            ElevatedButton(
              onPressed: () async {
                final nickName = nickNameController.text.trim();
                if (nickName.isEmpty) {
                  CommonToast.show(
                    context: context,
                    message: "닉네임을 입력해주세요.",
                    type: ToastificationType.info,
                  );
                  return;
                }
                try {
                  await signupViewModel.checkValidNickName(nickName);
                  if (signupViewModel.error != null) {
                    CommonToast.show(
                      context: context,
                      message: signupViewModel.error.toString(),
                      type: ToastificationType.info,
                    );
                    setState(() {
                      _hasValidNickName = false;
                    });
                  } else {
                    setState(() {
                      _hasValidNickName = true;
                    });
                    CommonToast.show(
                      context: context,
                      message: signupViewModel.message.toString(),
                      type: ToastificationType.success,
                    );
                  }
                } catch (e) {
                  CommonToast.show(
                    context: context,
                    message: signupViewModel.error.toString(),
                    type: ToastificationType.error,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.widgetBackground,
                foregroundColor: Colors.black,
                minimumSize: Size(double.infinity, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('닉네임 중복확인', style: AppTextStyle.body),
            ),

            SizedBox(height: 45),

            ElevatedButton(
              onPressed: () async {
                if (_hasValidEmail && _hasValidNickName) {
                  await signupViewModel.signUp(email, password, nickName);
                  if (signupViewModel.error != null) {
                    CommonToast.show(
                      context: context,
                      message: "회원가입 중 오류가 발생했습니다.",
                      type: ToastificationType.error,
                    );
                  } else {
                    CommonToast.show(
                      context: context,
                      message: "회원가입을 성공했습니다.\n이메일 인증을 진행해주세요.",
                      type: ToastificationType.success,
                    );
                    setState(() {
                      _hasSignUp = true;
                    });
                  }
                } else {
                  CommonToast.show(
                    context: context,
                    message: "이메일과 닉네임 중복체크를 해주세요.",
                    type: ToastificationType.info,
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
                '회원가입',
                style:
                    (_hasValidEmail && _hasValidNickName)
                        ? AppTextStyle.section.copyWith(color: AppColors.textPoint)
                        : AppTextStyle.section.copyWith(color: Colors.black54),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ],
    );
  }
}
