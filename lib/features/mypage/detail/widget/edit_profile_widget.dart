import 'dart:io';

import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/auth/viewmodel/my_page_viewmodel.dart';
import 'package:cinemarket/features/auth/viewmodel/sign_up_viewmodel.dart';
import 'package:cinemarket/features/main/screen/main_screen.dart';
import 'package:cinemarket/widgets/common_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kpostal/kpostal.dart';
import 'package:toastification/toastification.dart';
import 'dart:convert';

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({super.key});

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  final MyPageViewModel _viewModel = MyPageViewModel();
  final signupViewModel = SignUpViewModel();
  bool _hasValidNickname = false;
  late final TextEditingController _nickNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;
  late final TextEditingController _addressDetailController;
  String zipCode = '';
  String _profileImageUrl = '';
  XFile? imageFile;
  String collectNickname = '';


  @override
  void initState() {
    super.initState();
    _viewModel.addListener(_onViewModelChanged);
    _viewModel.initialize();

    _nickNameController = TextEditingController(text: '');
    _phoneController = TextEditingController(text: '');
    _addressController = TextEditingController(text: '주소를 입력해주세요');
    _addressDetailController = TextEditingController(text: '');
  }

  void _onViewModelChanged() {
    setState(() {
      _nickNameController.text = _viewModel.nickname ?? '';
      final rawPhone = _viewModel.phone.toString();
      final formattedPhone = PhoneNumberFormatter.format(rawPhone);
      _profileImageUrl = _viewModel.profileImage ?? '';
      _phoneController.text = _viewModel.phone ?? '';
      _addressController.text = _viewModel.address1 ?? '주소를 입력해주세요.';
      _addressDetailController.text = _viewModel.address2 ?? '';
      zipCode = _viewModel.zipCode ?? '';
    });
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelChanged);
    _viewModel.dispose();
    _nickNameController.dispose();
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
          _buildTextField(label: '닉네임', controller: _nickNameController),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              final nickName = _nickNameController.text.trim();
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
                } else {
                  _hasValidNickname = true;
                  collectNickname = _nickNameController.text.toString();
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
              backgroundColor: AppColors.textPoint,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('중복 확인'),
          ),
          const SizedBox(height: 24),
          _buildTextField(
            label: '핸드폰 번호',
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            inputFormatters: [PhoneNumberFormatter()],
          ),
          const SizedBox(height: 24),
          _buildAddressEditor(),
          const SizedBox(height: 24),
          _buildChangePasswordButton(),
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
            backgroundColor: AppColors.widgetBackground,
            backgroundImage:
            imageFile != null
                ? Image
                .file(File(imageFile!.path))
                .image
                : (_profileImageUrl.isNotEmpty
                ? Image
                .memory(
              base64Decode(_viewModel.profileImage.toString()),
            )
                .image
                : null),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () async {
                //사진 선택
                final file = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (file != null) {
                  imageFile = XFile(file.path);
                  setState(() {});
                }
              },
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.transparent, width: 2),
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.black,
                  size: 20,
                ),
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
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.section),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: _viewModel.phone == null ? "010-0000-0000" : null,
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
              onPressed: () async {
                print("주소검색");
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (__) =>
                        KpostalView(
                          useLocalServer: true,
                          localPort: 1024,
                          callback: (Kpostal result) {
                            setState(() {
                              zipCode = result.postCode;
                              _addressController.text = result.address;
                            });
                          },
                        ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.textPoint,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
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

  Widget _buildChangePasswordButton() {
    return ElevatedButton(
      onPressed: () {
        print('비밀번호 변경 클릭');
        context.push('/mypage/detail', extra: 'edit_password');
      }, style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.textPoint,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
      child:
      Text("비밀번호 변경", style: AppTextStyle.body,),);
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_addressController.text == '주소를 선택해주세요' || zipCode.isEmpty) {
          CommonToast.show(
            context: context,
            message: "주소를 선택해주세요.",
            type: ToastificationType.error,
          );
          return;
        }
        if (imageFile != null) {
          final imageBytes = await imageFile!.readAsBytes();
          final base64Image = base64Encode(imageBytes);
          _profileImageUrl = base64Image;
        }

        if (_nickNameController.text.toString() !=
            _viewModel.nickname.toString() && _hasValidNickname == false) {
          CommonToast.show(
            context: context,
            message: "닉네임 중복 확인을 해주세요.",
            type: ToastificationType.error,
          );
          return;
        }

        if ((_nickNameController.text.toString() ==
            _viewModel.nickname.toString()) || (_hasValidNickname == true &&
            _nickNameController.text.toString() == collectNickname)) {
          _viewModel.editProfile(
            nickName: _nickNameController.text,
            phone: _phoneController.text,
            profileImage: _profileImageUrl,
            address1: _addressController.text,
            address2: _addressDetailController.text,
            zipCode: zipCode,
          );
          CommonToast.show(
            context: context,
            message: "수정이 완료 되었습니다.",
            type: ToastificationType.success,
          );
          MainScreenState.of(context)?.onTabSelected(2);
          context.pop();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.pointAccent,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: const Text(
        '수정 완료',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class PhoneNumberFormatter extends TextInputFormatter {
  static String format(String digits) {
    digits = digits.replaceAll(RegExp(r'\D'), '');
    if (digits.length <= 3) {
      return digits;
    } else if (digits.length <= 7) {
      return '${digits.substring(0, 3)}-${digits.substring(3)}';
    } else if (digits.length <= 11) {
      return '${digits.substring(0, 3)}-${digits.substring(3, 7)}-${digits
          .substring(7)}';
    } else {
      return '${digits.substring(0, 3)}-${digits.substring(3, 7)}-${digits
          .substring(7, 11)}';
    }
  }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,
      TextEditingValue newValue,) {
    String formatted = format(newValue.text);
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
