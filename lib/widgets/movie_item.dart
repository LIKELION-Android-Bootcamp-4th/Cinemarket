import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class MovieItem extends StatefulWidget {
  final String imageUrl;
  final String movieName;
  final int cumulativeSales;
  final List<Map<String, String>> providers;
  final bool isFavorite;

  const MovieItem({
    super.key,
    required this.imageUrl,
    required this.movieName,
    required this.cumulativeSales,
    required this.providers,
    required this.isFavorite,
  });

  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.widgetBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      widget.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (context,error,stackTrace) {
                        return Image.asset(
                          'assets/images/default_poster.png',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        );
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {
                      setState(() => isFavorite = !isFavorite);
                    },
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              widget.movieName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.bodyLarge,
            ),
          ),
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Row(
              children: [
                const Icon(
                  Icons.trending_up,
                  size: 14,
                  color: AppColors.textPrimary,
                ),
                const SizedBox(width: 4),
                Text('${widget.cumulativeSales}', style: AppTextStyle.bodySmall),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 4,),
            child: widget.providers.isNotEmpty
              ? Row(
                  children: widget.providers.map((provider) {
                    //TMDB watcha 로고 오류 -> 네트워크 이미지로 대체
                    final isWatcha = provider['providerName']?.toLowerCase() == 'watcha';
                    final logoUrl = isWatcha
                        ? 'https://play-lh.googleusercontent.com/vAkKvTtE8kdb0MWWxOVaqYVf0_suB-WMnfCR1MslBsGjhI49dAfF1IxcnhtpL3PnjVY'
                        : provider['logoUrl'] ?? '';

                    return Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.network(
                          logoUrl,
                          width: 15,
                          height: 15,
                          errorBuilder: (context, error, stackTrace) => const SizedBox(),
                        ),
                      ),
                    );
                  }).toList(),
                )
              : const SizedBox(height: 15,)
          ),
        ],
      ),
    );
  }
}
