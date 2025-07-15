import 'package:cinemarket/core/network/api_client.dart';
import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/goods/viewmodel/goods_review_viewmodel.dart';
import 'package:cinemarket/widgets/common_app_bar.dart';
import 'package:cinemarket/widgets/common_toast.dart';
import 'package:cinemarket/widgets/review_item.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
  bool isClicked1 = false;
  bool isClicked2 = false;

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
        context.watch<GoodsReviewsViewModel>();

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


              return ReviewItem(
                title: '리뷰 목록',
                productName: widget.goodsName,
                movieTitle: widget.movieTitle,
                productImage: widget.goodsImage,
                photoUrls: review.images.map((item) => item.url).toList(),
                initialRating: review.rating.toDouble(),
                initialReviewText: review.comment,
                likeCount: review.likeCount,
                onClick1: () async {

                  try {
                    final response = await ApiClient.dio.post(
                        '/api/reviews/${review.id}/like-toggle');

                    setState(() {
                      isClicked1 = !isClicked1;
                    });

                    isClicked1
                        ? CommonToast.show(context: context, message: '리뷰 좋아요 완료 !')
                        : CommonToast.show(context: context, message: '리뷰 좋아요 해제 !');

                  } on DioException catch(e) {

                    rethrow;
                  }
                },
                isClicked1: isClicked1,

                onClick2: () async {
                  final response = await ApiClient.dio.post('/api/dislikes/review/${review.id}');

                  setState(() {
                    isClicked2 = !isClicked2;
                  });

                  isClicked2
                  ? CommonToast.show(context: context, message: '리뷰 싫어요 완료 !')
                  : CommonToast.show(context: context, message: '리뷰 싫어요 해제 !');
                },
                isClicked2: isClicked2,
              );
            },
          );
        },
      ),
    );
  }
}
