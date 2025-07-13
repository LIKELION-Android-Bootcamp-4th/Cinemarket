import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/favorite/viewmodel/favorite_viewmodel.dart';
import 'package:cinemarket/widgets/common_gridview.dart';
import 'package:cinemarket/core/constants/enums/item_type.dart';
import 'package:cinemarket/widgets/common_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  static const List<String> _tabTitles = ['굿즈', '영화'];

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

        return CommonTabView(
          tabTitles: _tabTitles,
          tabViews: [
            CommonGridview(
              itemType: ItemType.goods,
              // items: dummyGoods,
              items: viewModel.favoriteGoods,
            ),
            const CommonGridview(
              itemType: ItemType.movie,
              // items: dummyMovies,
              items: [],
            ),
          ],
        );
      },
    );
  }
}
