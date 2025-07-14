import 'package:cinemarket/core/storage/token_storage.dart';
import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/favorite/viewmodel/favorite_viewmodel.dart';
import 'package:cinemarket/widgets/common_gridview.dart';
import 'package:cinemarket/core/constants/enums/item_type.dart';
import 'package:cinemarket/widgets/common_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  static const List<String> _tabTitles = ['굿즈', '영화'];

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
  }
}
