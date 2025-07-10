import 'package:cinemarket/core/router/router.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/goods/viewmodel/goods_review_viewmodel.dart';
import 'package:cinemarket/widgets/review_item.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

const previewReviewCount = 3;

Widget getTabsReviewWidget({
  required BuildContext context,
  required String goodsId,
  required String goodsName,
  required String movieTitle,
  required String goodsImage,
}) {
  final viewModel = context.read<GoodsReviewsViewModel>();

  return FutureBuilder<void>(
    future: viewModel.getGoodsReviews(goodsId: goodsId),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }

      if (viewModel.errorMessage != null) {
        Logger().i('에러 분기 진입');
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('리뷰', style: AppTextStyle.headline),
            const SizedBox(height: 12),
            const Text('작성된 리뷰가 없습니다.', style: AppTextStyle.body),
          ],
        );
      }

      final reviews = viewModel.reviews;
      final previewReviews = reviews.take(previewReviewCount).toList();

      Logger().i('정상 분기 진입');

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('리뷰', style: AppTextStyle.headline),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  router.push(
                    '/goods/$goodsId/review',
                    extra: {
                      'goodsName': goodsName,
                      'movieTitle': movieTitle,
                      'goodsImage': goodsImage,
                    },
                  );
                },
                child: const Text('더보기', style: AppTextStyle.point),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...previewReviews.map((review) {
            return ReviewItem(
              productName: goodsName,
              movieTitle: movieTitle,
              productImage: goodsImage,
                // photoUrls: review.images.map((item) => item.url).toList(),
              photoUrls: const [
                'https://i.ebayimg.com/images/g/I6sAAeSwZFtoY1td/s-l140.webp',
                'https://i.ebayimg.com/images/g/kkUAAeSwfRloY1tQ/s-l140.webp',
              ],
              initialRating: review.rating.toDouble(),
              initialReviewText: review.comment,
            );
          }).toList(),
        ],
      );
    },
  );
}
