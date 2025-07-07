import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/widgets/common_toast.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

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
            color: AppColors.innerWidget,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
              '서울시 은평구 123456서울시 은평구 123456서울시 은평구 123456서울시 은평구 123456서울시 은평구 123456서울시 은평구 123456서울시 은평구 123456서울시 은평구 123456서울시 은평구 123456서울시 은평구 123456서울시 은평구 123456서울시 은평구 123456서울시 은평구 123456서울시 은평구 123456서울시 은평구 123456서울시 은평구 123456',
              style: AppTextStyle.body
          ),
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: AppColors.widgetBackground,
            side: BorderSide(color: AppColors.background),
          ),
          onPressed: () {
            CommonToast.show(
              context: context,
              message: '기능 준비중',
              type: ToastificationType.info
            );
          },
          child: const Text(
            '배송지 변경',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ),
      ],
    );
  }
}