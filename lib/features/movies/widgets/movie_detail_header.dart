import 'package:flutter/material.dart';
import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';

class MovieDetailHeader extends StatelessWidget {
  final String posterUrl;
  final String thumbnailUrl;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const MovieDetailHeader({
    super.key,
    required this.posterUrl,
    required this.thumbnailUrl,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final posterHeight = screenWidth * 2 / 3;
    final thumbnailHeight = posterHeight / 2;
    final thumbnailWidth = thumbnailHeight * 2 / 3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 포스터 + 찜 버튼
        SizedBox(
          width: screenWidth,
          height: posterHeight,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  posterUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 12,
                bottom: 12,
                child: GestureDetector(
                  onTap: onFavoriteToggle,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.widgetBackground,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: AppColors.pointAccent,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // 썸네일 + 제목/평점
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Transform.translate(
                offset: Offset(0, -thumbnailHeight / 2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    width: thumbnailWidth,
                    height: thumbnailHeight,
                    child: Image.network(thumbnailUrl, fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // 영화 제목 + 평점
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('영화 제목', style: AppTextStyle.headline),
                        Expanded(child: SizedBox()), // 오른쪽으로 밀기
                        Icon(Icons.star_border, color: Color(0xffFF8700), size: 20),
                        SizedBox(width: 4),
                        Text(
                          '4.5',
                          style: TextStyle(color: Color(0xffFF8700), fontSize: 14),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }
}
