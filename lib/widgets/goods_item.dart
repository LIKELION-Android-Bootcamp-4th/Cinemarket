import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cinemarket/core/storage/token_storage.dart';
import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/favorite/viewmodel/favorite_viewmodel.dart';
import 'package:cinemarket/widgets/common_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class GoodsItem extends StatefulWidget {
  final String goodsId;
  final String imageUrl;
  final String goodsName;
  final String movieTitle;
  final String price;
  final int stock;
  final double rating;
  final int reviewCount;
  final bool isFavorite;

  const GoodsItem({
    super.key,
    required this.goodsId,
    required this.imageUrl,
    required this.goodsName,
    required this.movieTitle,
    required this.price,
    required this.stock,
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
                    toggleFavorite(context: context,
                        id: widget.goodsId,
                        isFavorite: isFavorite,
                        onStateChanged: (newState) {
                          setState(() => isFavorite = newState);
                        },
                      updateFavoriteStatus: (id) => updateGoodsFavoriteStatus(goodsId: id),
                    );
                  },
                ),


                if (widget.stock < 20 && widget.stock > 0) ...[
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      width:90,
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                          const Icon(Icons.access_alarm, size: 20, color: Colors.white),
                          const SizedBox(width: 4),
                          DefaultTextStyle(
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            child: AnimatedTextKit(
                              repeatForever: true,
                              animatedTexts: [
                                // TyperAnimatedText(
                                //   '품절 임박',
                                //   textStyle: AppTextStyle.bodySmall.copyWith(
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                //   speed: Duration(milliseconds: 100),
                                // ),
                              ColorizeAnimatedText(
                                '품절 임박',
                                textStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                colors: [
                                  Colors.white,
                                  AppColors.pointAccent
                                ],
                              )
                              ],
                            ),
                          )
                        ]
                      ),
                    ),
                  )
                ],

                if (widget.stock == 0) ...[
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(0, 0, 0, 0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 0, 0, 0.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.only(left: 4, right: 4, bottom: 2),
                      child: const Text(
                        '품절',
                        style: AppTextStyle.bodySmall,
                      ),
                    ),
                  ),
                ],
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
              widget.movieTitle,
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

Future<bool> updateGoodsFavoriteStatus({required String goodsId}) async {
  return await FavoriteViewModel().toggleFavorite(goodsId: goodsId);
}

Future<void> toggleFavorite({
  required BuildContext context,
  required String id,
  required bool isFavorite,
  required void Function(bool) onStateChanged,
  required Future<bool> Function(String) updateFavoriteStatus,
}) async {
  // 로그인 요청  // 하지 않는다면 바로 action 종료
  if (!await requireLoginBeforeAction(context)) return;

  if (await updateFavoriteStatus(id)) {
    if (!context.mounted) return;

    final newState = !isFavorite;
    onStateChanged(newState);

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
