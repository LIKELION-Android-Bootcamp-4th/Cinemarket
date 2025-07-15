import 'package:flutter/material.dart';
import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';

class MovieDetailHeader extends StatelessWidget {
  final String posterUrl;
  final String thumbnailUrl;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final String title;
  final double voteAverage;
  final List<Map<String, String>> providers;

  const MovieDetailHeader({
    super.key,
    required this.posterUrl,
    required this.thumbnailUrl,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.title,
    required this.voteAverage,
    required this.providers,
  });
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final posterHeight = screenWidth * 2 / 3;
    final thumbnailHeight = posterHeight / 1.5;
    final thumbnailWidth = thumbnailHeight * 2 / 3;

    final infoWidth = screenWidth - 16 * 2 - thumbnailWidth - 16;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              width: screenWidth,
              height: posterHeight,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      posterUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context,error, stackTrace) => Image.asset(
                        'assets/images/default_poster.png',
                        fit: BoxFit.cover,
                      ),
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

            Positioned(
              left: 16,
              bottom: -thumbnailHeight / 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: thumbnailWidth,
                      height: thumbnailHeight,
                      child: Image.network(
                        thumbnailUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context,error, stackTrace) => Image.asset(
                          'assets/images/default_poster.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  SizedBox(
                    width: infoWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: title.length > 10 ? AppTextStyle.bodyLarge : AppTextStyle.section,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.star, color: const Color(0xffFF8700), size: 20),
                            const SizedBox(width: 4),
                            Text(
                              voteAverage.toStringAsFixed(1),
                              style: const TextStyle(color: Color(0xffFF8700), fontSize: 14),
                            ),
                          ],
                        ),
                        if (providers.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Row(
                              children: providers.map((provider) {
                                final isWatcha = provider['providerName']?.toLowerCase() == 'watcha';
                                final logoUrl = isWatcha
                                    ? 'https://play-lh.googleusercontent.com/vAkKvTtE8kdb0MWWxOVaqYVf0_suB-WMnfCR1MslBsGjhI49dAfF1IxcnhtpL3PnjVY'
                                    : provider['logoUrl'] ?? '';

                                return Padding(
                                  padding: const EdgeInsets.only(right: 6),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.network(
                                      logoUrl,
                                      width: 22,
                                      height: 22,
                                      errorBuilder: (context, error, stackTrace) => const SizedBox(),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        // 포스터 아래 썸네일이 살짝 겹치니 적절한 공간 확보
        SizedBox(height: thumbnailHeight / 2 + 16),
      ],
    );
  }
}