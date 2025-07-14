import 'package:cinemarket/core/storage/token_storage.dart';
import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/favorite/viewmodel/favorite_viewmodel.dart';
import 'package:cinemarket/widgets/common_gridview.dart';
import 'package:cinemarket/core/constants/enums/item_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  Future<void> _refreshGoods() async {
    await context.read<FavoriteViewModel>().getAllFavoriteGoods();
  }

  Future<void> _refreshMovies() async {
    await context.read<FavoriteViewModel>().getAllFavoriteMovies();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavoriteViewModel>().getAllFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FavoriteViewModel>();

    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return DefaultTabController(
      length: 2,
      child: Container(
        color: AppColors.background,
        child: Column(
          children: [
            const Material(
              color: AppColors.widgetBackground,
              child: TabBar(
                tabs: [
                  // Tab(child: Text('굿즈', style: TextStyle(fontSize: 20))),
                  Tab(child: Text('굿즈', style: TextStyle(fontSize: 20))),
                  Tab(child: Text('영화', style: AppTextStyle.section)),
                  // todo: 커스텀 색상 사용 시 라벨 적용 안댐
                  // Tab(child: Text('영화', style: AppTextStyle.headline)),
                ],
                labelColor: AppColors.textPoint,
                unselectedLabelColor: AppColors.textPrimary,
                indicatorColor: AppColors.innerWidget,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: TabBarView(
                  children: [
                    RefreshIndicator(
                      onRefresh: _refreshGoods,
                      child:
                          viewModel.favoriteGoods.isEmpty || !viewModel.isLogin
                              ? ListView(
                                children: const [
                                  SizedBox(height: 150),
                                  Center(
                                    child: Text(
                                      '굿즈 찜 목록이 비어있어요..!!',
                                      style: AppTextStyle.headline,
                                    ),
                                  ),
                                ],
                              )
                              : CommonGridview(
                                itemType: ItemType.goods,
                                // items: dummyGoods,
                                items: viewModel.favoriteGoods,
                              ),
                    ),
                    RefreshIndicator(
                      onRefresh: _refreshMovies,
                      child:
                          viewModel.favoriteMovies.isEmpty || !viewModel.isLogin
                              ? ListView(
                                children: const [
                                  SizedBox(height: 150),
                                  Center(
                                    child: Text(
                                      '영화 찜 목록이 비어있어요..!!',
                                      style: AppTextStyle.headline,
                                    ),
                                  ),
                                ],
                              )
                              : CommonGridview(
                                itemType: ItemType.movie,
                                // items: dummyMovies,
                                items: viewModel.favoriteMovies,
                              ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
