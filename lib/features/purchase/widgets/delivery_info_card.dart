import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class DeliveryInfoCard extends StatelessWidget {
  const DeliveryInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('배송지 정보', style: AppTextStyle.headline),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.toastBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text('서울시 은평구 123456', style: AppTextStyle.body),
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: AppColors.widgetBackground,
            side: BorderSide(color: Color(0xFFD95B5B)),
          ),
          onPressed: () {},
          child: const Text(
              '배송지 변경',
            style: TextStyle(color: Color(0xFFe0e0e0)),
          ),
        ),
      ],
    );
  }
}
