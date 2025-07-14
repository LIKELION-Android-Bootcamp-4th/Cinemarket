import 'package:cinemarket/core/storage/token_storage.dart';
import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/favorite/viewmodel/favorite_viewmodel.dart';
import 'package:cinemarket/widgets/common_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class MovieItem extends StatelessWidget {
  final String imageUrl;
  final String movieName;
  final int cumulativeSales;
  final List<Map<String, String>> providers;
  final int movieId;

  const MovieItem({
    super.key,
    required this.imageUrl,
    required this.movieName,
    required this.cumulativeSales,
    required this.providers,
    required this.movieId,
  });

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
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
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
          ),
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              movieName,
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
                Text('${cumulativeSales}', style: AppTextStyle.bodySmall),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 4,),
            child: providers.isNotEmpty
              ? Row(
                  children: providers.map((provider) {
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

Future<bool> updateFavoriteStatus({required String movieId}) async {
  return await FavoriteViewModel().toggleMovieFavorite(contentId: movieId);
}

Future<bool> requireLoginBeforeAction(BuildContext context) async {
  final accessToken = await TokenStorage.getAccessToken();

  if (!context.mounted) return false; // 위젯 부착 상태 확인

  if (accessToken == null) {
    // 비회원인 경우
    final shouldNavigate = await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('로그인이 필요합니다', style: AppTextStyle.section),
            content: const Text('로그인 화면으로 이동하시겠습니까?', style: AppTextStyle.body),
            backgroundColor: AppColors.widgetBackground,
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('취소', style: AppTextStyle.bodyPointRed),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('이동', style: AppTextStyle.bodyPointBlue),
              ),
            ],
          ),
    );

    if (shouldNavigate == true && context.mounted) {
      context.push('/login');
    }

    return false;
  }

  return true; // 로그인된 상태
}
