import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/features/mypage/detail/widget/my_review_widget.dart';
import 'package:cinemarket/widgets/common_app_bar.dart';
import 'package:cinemarket/widgets/review_item.dart';
import 'package:flutter/material.dart';

class GoodsReviewScreen extends StatelessWidget {
  const GoodsReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CommonAppBar(title: '리뷰 목록'),
      body: ListView.builder(
        itemCount: 0,  // todo: 더미데이터 삭제로 인한 0
        itemBuilder: (context, index) {
          return ReviewItem(
            title: '리뷰 목록',
            productName: 'review.productName',
            movieTitle: 'review.movieTitle',
            productImage: 'review.productImage',
            photoUrls: ['review.photoUrls'],
            initialRating: 0,
            initialReviewText: 'review.initialReviewText',
            onClick1: (){},
            onClick2: (){},
          );
        },
      ),
    );
  }
}