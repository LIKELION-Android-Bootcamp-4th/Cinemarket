import 'package:cinemarket/features/home/viewmodel/best_goods_viewmodel.dart';
import 'package:cinemarket/features/home/viewmodel/best_movie_viewmodel.dart';
import 'package:cinemarket/features/home/viewmodel/home_viewmodel.dart';
import 'package:cinemarket/features/home/widgets/best_goods_widget.dart';
import 'package:cinemarket/features/home/widgets/best_movie_widget.dart';
import 'package:cinemarket/features/home/widgets/box_office_ranking_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _refreshAll(BuildContext context) async {
    final homeVM = context.read<HomeViewModel>();
    final bestGoodsVM = context.read<BestGoodsViewModel>();
    final bestMovieVM = context.read<BestMovieViewModel>();

    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    final formattedDate = '${yesterday.year.toString().padLeft(4, '0')}${yesterday.month.toString().padLeft(2, '0')}${yesterday.day.toString().padLeft(2, '0')}';

    await Future.wait([
      homeVM.loadMovies(formattedDate, force: true),
      bestGoodsVM.loadBestGoods(force: true),
      bestMovieVM.loadTrendingMovies(force: true),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _refreshAll(context),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BoxOfficeRankingWidget(),
            SizedBox(height: 24),
            BestGoodsWidget(),
            SizedBox(height: 24),
            BestMovieWidget(),
          ],
        ),
      ),
    );
  }

}
