import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/widgets/common_app_bar.dart';
import 'package:cinemarket/widgets/review_item.dart';
import 'package:flutter/material.dart';

class GoodsReviewScreen extends StatelessWidget {
  const GoodsReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CommonAppBar(title: '리뷰 목록',),
      body: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          return ReviewItem(
              productName: 'productName $index',
              movieTitle: 'movieTitle $index',
            onClick1: () {},
            onClick2: () {},
          );
        },
      ),
    );
  }
}