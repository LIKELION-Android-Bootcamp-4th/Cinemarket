import 'package:cinemarket/core/storage/token_storage.dart';
import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/favorite/repository/favorite_repository.dart';
import 'package:cinemarket/features/favorite/service/favorite_service.dart';
import 'package:cinemarket/features/favorite/viewmodel/favorite_viewmodel.dart';
import 'package:cinemarket/widgets/common_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class GoodsItem extends StatefulWidget {
  final String imageUrl;
  final String goodsName;
  final String goodsId;
  final String price;
  final double rating;
  final int reviewCount;
  final bool isFavorite;

  const GoodsItem({
    super.key,
    required this.imageUrl,
    required this.goodsName,
    required this.goodsId,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.isFavorite,
  });

  @override
  State<GoodsItem> createState() => _GoodsItemState();
}

class _GoodsItemState extends State<GoodsItem> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    await toggleFavorite(
                      context: context,
                      id: widget.goodsId,
                      isFavorite: isFavorite,
                      onStateChanged: (newState) {
                        setState(() => isFavorite = newState);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              widget.goodsName,
              style: AppTextStyle.body,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              widget.goodsId,
              style: AppTextStyle.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: [
                Icon(Icons.star_rate, size: 15, color: Colors.yellow),
                Text(
                  '${widget.rating}(${widget.reviewCount})',
                  style: AppTextStyle.bodySmall,
                ),
                Spacer(),
                Text(
                  widget.price,
                  style: AppTextStyle.body,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> toggleFavorite({
  required BuildContext context,
  required String id,
  required bool isFavorite,
  required void Function(bool) onStateChanged,
}) async {
  // 로그인 요청  // 하지 않는다면 바로 action 종료
  if (!await requireLoginBeforeAction(context)) return;

  if (await updateGoodsFavoriteStatus(goodsId: id)) {
    if (!context.mounted) return;

    onStateChanged(isFavorite = !isFavorite);

    CommonToast.show(
      context: context,
      message: isFavorite ? '찜 추가 완료 !' : '찜 삭제 완료 !',
      type: ToastificationType.success,
    );
  } else {
    CommonToast.show(
      context: context,
      message: '에러 발생',
      type: ToastificationType.error,
    );
  }
}

Future<bool> updateGoodsFavoriteStatus({required String goodsId}) async {
  return await FavoriteViewModel(
    favoriteRepository: FavoriteRepository(favoriteService: FavoriteService()),
  ).toggleFavorite(goodsId: goodsId);
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
