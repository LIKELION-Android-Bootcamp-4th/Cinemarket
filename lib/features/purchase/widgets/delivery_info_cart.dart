import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kpostal/kpostal.dart';



class DeliveryInfoCard extends StatelessWidget {
  final String? address;
  final String? zipCode;
  final void Function(String address, String zipCode)? onAddressChanged;

  const DeliveryInfoCard({
    super.key,
    this.address,
    this.zipCode,
    this.onAddressChanged,
  });


  Future<void> _selectAddress(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => KpostalView(
          useLocalServer: true,
          localPort: 1024,
          callback: (Kpostal result) {
            if (onAddressChanged != null) {
              onAddressChanged!(result.address, result.postCode);
            }
          },
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final displayText = (address != null && zipCode != null && address!.isNotEmpty && zipCode!.isNotEmpty)
        ? '($zipCode) $address'
        : '배송지 정보가 없습니다.';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('배송지 정보', style: AppTextStyle.headline),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.innerWidget,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            displayText,
            style: AppTextStyle.body,
          ),
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: AppColors.widgetBackground,
            side: BorderSide(color: AppColors.background),
          ),
          onPressed: () => _selectAddress(context),
          child: const Text(
            '배송지 변경',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ),
      ],
    );
  }
}