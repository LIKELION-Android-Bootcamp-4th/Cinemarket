

import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class BottomActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const BottomActionButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.pointAccent,
          ),
          onPressed: onPressed,
          child: Text(label, style: AppTextStyle.body),
        ),
      ),
    );
  }
}