import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/favorite/viewmodel/favorite_viewmodel.dart';
import 'package:cinemarket/widgets/common_gridview.dart';
import 'package:cinemarket/core/constants/enums/item_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<FavoriteViewModel>().getAllFavoriteGoods(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final viewModel = context.read<FavoriteViewModel>();
        viewModel.getAllFavoriteGoods();

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
                        CommonGridview(
                          itemType: ItemType.goods,
                          // items: dummyGoods,
                          items: viewModel.favoriteGoods,
                        ),
                        CommonGridview(
                          itemType: ItemType.movie,
                          // items: dummyMovies,
                          items: [],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
