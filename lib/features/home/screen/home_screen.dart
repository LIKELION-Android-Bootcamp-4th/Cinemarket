import 'package:cinemarket/features/home/viewmodel/best_goods_viewmodel.dart';
import 'package:cinemarket/features/home/viewmodel/best_movie_viewmodel.dart';
import 'package:cinemarket/features/home/viewmodel/home_viewmodel.dart';
import 'package:cinemarket/features/home/widgets/best_goods_widget.dart';
import 'package:cinemarket/features/home/widgets/best_movie_widget.dart';
import 'package:cinemarket/features/home/widgets/box_office_ranking_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cinemarket/features/auth/viewmodel/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool? _prevLogin;

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    final isLoggedIn = context.watch<AuthProvider>().isLoggedIn;
    if (_prevLogin != isLoggedIn) {
      _refreshAll(context);
      _prevLogin = isLoggedIn;
    }
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
