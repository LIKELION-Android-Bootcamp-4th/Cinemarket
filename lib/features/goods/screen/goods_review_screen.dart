import 'package:cinemarket/core/network/api_client.dart';
import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/goods/viewmodel/goods_review_viewmodel.dart';
import 'package:cinemarket/widgets/common_app_bar.dart';
import 'package:cinemarket/widgets/review_item.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class GoodsReviewScreen extends StatefulWidget {
  final String goodsId;
  final String goodsName;
  final String movieTitle;
  final String goodsImage;

  const GoodsReviewScreen({
    super.key,
    required this.goodsId,
    required this.goodsName,
    required this.movieTitle,
    required this.goodsImage,
  });

  @override
  State<GoodsReviewScreen> createState() => _GoodsReviewScreenState();
}

class _GoodsReviewScreenState extends State<GoodsReviewScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final viewModel = context.read<GoodsReviewsViewModel>();
      viewModel.getGoodsReviews(goodsId: widget.goodsId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel =
        context
            .watch<
              GoodsReviewsViewModel
            >(); // todo: 성능 고려 <- futureBuilder 또는 consumer

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CommonAppBar(title: '리뷰 목록'),
      body: Builder(
        builder: (context) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (viewModel.errorMessage != null) {
            return Center(
              child: Text('작성된 리뷰가 없습니다.', style: AppTextStyle.headline),
            );
            // return Center(child: Text(viewModel.errorMessage!));
          }

          return ListView.builder(
            itemCount: viewModel.reviews.length,
            itemBuilder: (context, index) {
              final review = viewModel.reviews[index];

              Logger().i('imageProduct: ${widget.goodsImage}');
              Logger().i(
                'imagePhotoFirst: ${review.images.map((item) => item.url).toList().first}',
              );

              return ReviewItem(
                title: '리뷰 목록',
                productName: widget.goodsName,
                movieTitle: widget.movieTitle,
                // productImage: review.images.first.url,
                productImage: widget.goodsImage,
                photoUrls: review.images.map((item) => item.url).toList(),
                initialRating: review.rating.toDouble(),
                initialReviewText: review.comment,
                likeCount: review.likeCount,
                onClick1: () async {
                  Logger().i('review id : ${review.id}');

                  try {
                    final response = await ApiClient.dio.post(
                        '/api/reviews/${review.id}/like-toggle');
                    Logger().i('${response.data['message']}');
                  } on DioException catch(e) {
                    Logger().e('$e');
                    Logger().e('${e.stackTrace}');

                    rethrow;
                  }
                },
                onClick2: () async {
                  Logger().i('review id : ${review.id}');
                  final response = await ApiClient.dio.post('/api/dislikes/review/${review.id}');
                  Logger().i('${response.data['message']}');
                },
              );
            },
          );
        },
      ),
    );
  }
}
