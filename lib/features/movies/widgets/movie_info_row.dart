import 'package:flutter/material.dart';
import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';

class MovieInfoRow extends StatelessWidget {
  final List<String> genres;
  final String releaseYear;
  final int runtime;

  const MovieInfoRow({
    super.key,
    required this.genres,
    required this.releaseYear,
    required this.runtime,
  });

  @override
  Widget build(BuildContext context) {
    final genreText = genres.join(', ');
    const iconSize = 16.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.movie_creation_outlined, color: AppColors.textSecondary,size: iconSize,),
        const SizedBox(width: 6),
        Text(releaseYear, style: AppTextStyle.body),
        const SizedBox(width: 24),
        const Icon(Icons.timer_outlined, color: AppColors.textSecondary,size: iconSize,),
        const SizedBox(width: 6),
        Text('${runtime}분', style: AppTextStyle.body),
        const SizedBox(width: 24),
        const Icon(Icons.category_outlined, color: AppColors.textSecondary,size: iconSize,),
        const SizedBox(width: 6),
        Text(genreText, style: AppTextStyle.body, maxLines: 1, overflow: TextOverflow.ellipsis),
      ],
    );
  }
}
