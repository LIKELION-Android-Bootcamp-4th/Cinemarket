import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/auth/viewmodel/my_page_viewmodel.dart';
import 'package:cinemarket/widgets/common_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class EditPasswordWidget extends StatefulWidget {
  const EditPasswordWidget({super.key});

  State<EditPasswordWidget> createState() => _EditPasswordWidgetState();
}

class _EditPasswordWidgetState extends State<EditPasswordWidget> {
  final TextEditingController _currentPasswordController =
  TextEditingController(text: '');
  final TextEditingController _newPasswordController = TextEditingController(
    text: '',
  );
  final TextEditingController _confirmPasswordController =
  TextEditingController(text: '');
  final MyPageViewModel _myPageViewModel = MyPageViewModel();

  @override
  void initState() {
    super.initState();
    _myPageViewModel.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          _buildTextField(
            label: '현재 비밀번호',
            controller: _currentPasswordController,
          ),
          const SizedBox(height: 20),
          _buildTextField(label: '새 비밀번호', controller: _newPasswordController),
          const SizedBox(height: 20),
          _buildTextField(
            label: '새 비밀번호 확인',
            controller: _confirmPasswordController,
          ),
          const SizedBox(height: 60),
          _buildSaveButton(),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () async {
        final currentPassword = _currentPasswordController.text;
        final newPassword = _newPasswordController.text;
        final confirmPassword = _confirmPasswordController.text;
        try {
          await _myPageViewModel.fetchPassword(
            currentPassword,
            newPassword,
            confirmPassword
          );

          if (_myPageViewModel.error != null) {
            CommonToast.show(
              context: context,
              message: _myPageViewModel.error.toString(),
              type: ToastificationType.warning,
            );
          } else {
            CommonToast.show(
              context: context,
              message: '비밀번호가 변경되었습니다.\n다시 로그인 해주십시오.',
              type: ToastificationType.success,
            );
            await _myPageViewModel.logout();
            context.go('/home');
          }
        } catch (e) {

        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.pointAccent,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: const Text(
        '변경하기',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.section),
        const SizedBox(height: 8),
        TextField(
          obscureText: true,
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintStyle: const TextStyle(color: Colors.white54),
            filled: true,
            fillColor: AppColors.widgetBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
