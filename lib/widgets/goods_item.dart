import 'package:cinemarket/core/storage/token_storage.dart';
import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GoodsItem extends StatefulWidget {
  final String imageUrl;
  final String goodsName;
  final String movieName;
  final String price;
  final double rating;
  final int reviewCount;
  final bool isFavorite;

  const GoodsItem({
    super.key,
    required this.imageUrl,
    required this.goodsName,
    required this.movieName,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.isFavorite,
  });

  @override
  State<GoodsItem> createState() => _GoodsItemState();
}

class _GoodsItemState extends State<GoodsItem> {

  @override
  Widget build(BuildContext context) {
    bool isFavorite = widget.isFavorite;

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
                    setState(() => isFavorite = !isFavorite);
                    final accessToken = await TokenStorage.getAccessToken();

                    if (!mounted) return;  // state의 화면 부착 여부

                    if (accessToken == null) {  // 비회원의 경우

                      final shouldNavigate = await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('로그인이 필요합니다', style: AppTextStyle.section,),
                            content: const Text('로그인 화면으로 이동하시겠습니까?', style: AppTextStyle.body,),
                            backgroundColor: AppColors.widgetBackground,
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(false),
                                child: const Text('취소', style: AppTextStyle.bodyPointRed,),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(true),
                                child: const Text('이동', style: AppTextStyle.bodyPointBlue,),
                              ),
                            ],
                          ),
                      );

                      if(shouldNavigate == true && mounted) {
                        context.push('/login', );
                      }
                    }

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
              widget.movieName,
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
                Icon(Icons.star_rate, size: 15, color: Colors.yellow,),
                Text('${widget.rating}(${widget.reviewCount})',
                style: AppTextStyle.bodySmall,),
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
