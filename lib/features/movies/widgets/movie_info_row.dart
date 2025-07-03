import 'package:flutter/material.dart';
import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';

class MovieInfoRow extends StatelessWidget {
  const MovieInfoRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.movie_creation_outlined, color: AppColors.textSecondary),
        SizedBox(width: 4),
        Text('2024', style: AppTextStyle.body),
        SizedBox(width: 16),
        Icon(Icons.timer_outlined, color: AppColors.textSecondary),
        SizedBox(width: 4),
        Text('러닝타임', style: AppTextStyle.body),
        SizedBox(width: 16),
        Icon(Icons.category_outlined, color: AppColors.textSecondary),
        SizedBox(width: 4),
        Text('category', style: AppTextStyle.body),
      ],
    );
  }
}
