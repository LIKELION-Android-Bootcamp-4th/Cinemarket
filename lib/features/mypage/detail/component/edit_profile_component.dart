import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/widgets/common_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class EditProfileComponent extends StatefulWidget {
  const EditProfileComponent({super.key});

  @override
  State<EditProfileComponent> createState() => _EditProfileComponentState();
}

class _EditProfileComponentState extends State<EditProfileComponent> {
  late final TextEditingController _nicknameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  late final TextEditingController _addressDetailController;

  String _profileImageUrl = 'https://placehold.co/120x120/292929/ffffff?text=User';

  @override
  void initState() {
    super.initState();
    _nicknameController = TextEditingController(text: '기존닉네임');
    _phoneController = TextEditingController(text: '010-1234-5678');
    _addressController = TextEditingController(text: 'OO시 OO구 OO로');
    _addressDetailController = TextEditingController(text: '상세주소');
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _addressDetailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          _buildProfilePhotoEditor(),
          const SizedBox(height: 40),
          _buildTextField(
            label: '닉네임',
            controller: _nicknameController,
          ),
          const SizedBox(height: 24),
          _buildTextField(
            label: '핸드폰 번호',
            controller: _phoneController,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 24),
          _buildAddressEditor(),
          const SizedBox(height: 60),
          _buildSaveButton(),
        ],
      ),
    );
  }

  Widget _buildProfilePhotoEditor() {
    return Center(
      child: Stack(
        children: [
          // 프로필 사진
          CircleAvatar(
            radius: 60,
            backgroundColor: const Color(0xFF292929),
            backgroundImage: NetworkImage(_profileImageUrl),
          ),
          // 수정 아이콘 버튼
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                //사진 변경 API, 갤러리 등 기능 추가 해야함
                print('프로필 사진 변경');
                setState(() {
                  _profileImageUrl = 'url';
                });
              },
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: const Icon(Icons.camera_alt, color: Colors.black, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.section),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF292929),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddressEditor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('주소', style: AppTextStyle.section),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _addressController,
                readOnly: true,
                style: const TextStyle(color: Colors.white70),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.widgetBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                // TODO: 다음 주소 API 서비스 연동
                print('주소 검색');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.textPoint,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('주소 검색'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _addressDetailController,
          style: AppTextStyle.body,
          decoration: InputDecoration(
            hintText: '상세주소 입력',
            hintStyle: const TextStyle(color: Colors.white54),
            filled: true,
            fillColor: const Color(0xFF292929),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () {
        // TODO: 변경된 정보를 서버에 저장하는 로직 구현
        CommonToast.show(context: context, message: "수정이 완료 되었습니다.", type: ToastificationType.success);
        context.go('/mypage');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.pointAccent,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: const Text('수정 완료', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }
}
