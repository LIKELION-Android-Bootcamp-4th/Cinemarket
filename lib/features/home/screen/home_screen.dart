import 'package:cinemarket/features/home/widgets/best_goods_widget.dart';
import 'package:cinemarket/features/home/widgets/best_movie_widget.dart';
import 'package:cinemarket/features/home/widgets/box_office_ranking_widget.dart';
import 'package:cinemarket/features/home/widgets/recommended_goods_widget.dart';
import 'package:flutter/material.dart';
import 'package:cinemarket/core/network/api_client.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BoxOfficeRankingWidget(),
          SizedBox(height: 24),
          BestGoodsWidget(),
          SizedBox(height: 24),
          BestMovieWidget(),
          SizedBox(height: 24),
          RecommendedGoodsWidget(),
        ],
      ),
    );
  }

}
