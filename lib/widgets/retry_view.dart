//새로고침을 위한 위젯

import 'package:flutter/material.dart';
import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';

class RetryView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const RetryView({
    super.key,
    this.message = '데이터를 불러오지 못했어요.',
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            style: AppTextStyle.section,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.widgetBackground,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text(
              '새로고침',
              style: AppTextStyle.body,
            ),
          ),
        ],
      ),
    );
  }
}
