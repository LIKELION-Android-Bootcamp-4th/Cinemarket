import 'package:flutter/material.dart';

class ShippingInfoForm extends StatelessWidget {
  final TextEditingController recipientController;
  final TextEditingController addressController;
  final TextEditingController phoneController;
  final TextEditingController zipCodeController;
  final TextEditingController memoController;

  const ShippingInfoForm({
    super.key,
    required this.recipientController,
    required this.addressController,
    required this.phoneController,
    required this.zipCodeController,
    required this.memoController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('배송지 정보', style: TextStyle(color: Colors.white, fontSize: 16)),
        const SizedBox(height: 8),
        _buildTextField(controller: recipientController, label: '수령인', validatorMsg: '수령인을 입력해주세요'),
        _buildTextField(controller: addressController, label: '주소', validatorMsg: '주소를 입력해주세요'),
        _buildTextField(controller: phoneController, label: '전화번호', validatorMsg: '전화번호를 입력해주세요'),
        _buildTextField(controller: zipCodeController, label: '우편번호', validatorMsg: '우편번호를 입력해주세요'),
        _buildTextField(controller: memoController, label: '배송 메모 (선택)', required: false),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? validatorMsg,
    bool required = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          filled: true,
          fillColor: Colors.grey[900],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        validator: required
            ? (value) {
          if (value == null || value.trim().isEmpty) {
            return validatorMsg ?? '$label을 입력해주세요';
          }
          return null;
        }
            : null,
      ),
    );
  }
}