import 'package:cinemarket/core/constants/enums/item_type.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/goods/model/goods.dart';
import 'package:cinemarket/features/goods/viewmodel/goods_all_viewmodel.dart';
import 'package:cinemarket/features/home/model/tmdb_movie.dart';
import 'package:cinemarket/widgets/goods_item.dart';
import 'package:cinemarket/widgets/movie_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CommonGridview<T> extends StatelessWidget {
  final List<T> items;
  final ItemType itemType;
  final bool isFavoriteScreen;
  final bool isInScrollView;
  final ScrollController? scrollController;
  final bool? showLoadingIndicator;


  const CommonGridview({
    super.key,
    required this.itemType,
    required this.items,
    this.isFavoriteScreen = false,
    this.isInScrollView = false,
    this.scrollController,
    this.showLoadingIndicator = false,
  });

  @override
  Widget build(BuildContext context) {
    final double aspectRatio = switch (itemType) {
      ItemType.goods => 0.7,
      ItemType.movie => 0.51,
    };

    final double crossAxisSpacing = switch (itemType) {
      ItemType.goods => 8,
      ItemType.movie => 16,
    };

    final double mainAxisSpacing = switch (itemType) {
      ItemType.goods => 8,
      ItemType.movie => 16,
    };

    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            controller: scrollController,
            shrinkWrap: isInScrollView,
            physics: isInScrollView ? const NeverScrollableScrollPhysics() : null,
            itemCount: items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: aspectRatio,
              crossAxisSpacing: crossAxisSpacing,
              mainAxisSpacing: mainAxisSpacing,
            ),
            itemBuilder: (context, index) {
              final item = items[index];

              if (item is Goods) {
                return GestureDetector(
                  onTap: () {
                    context.push('/goods/${item.id}');
                  },
                  child: FutureBuilder(
                    future: GoodsAllViewModel().getMovieTitleFromGoodsId(goodsId: item.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final movieName = snapshot.data ?? '';

                      return GoodsItem(
                        goodsId: item.id,
                        imageUrl: item.images.main,
                        goodsName: item.name,
                        movieTitle: movieName,
                        price: item.price,
                        stock: item.stock,
                        rating: item.reviewStats?.averageRating ?? 0.0,
                        reviewCount: item.reviewCount,
                        isFavorite: item.isFavorite,
                      );
                    },
                  ),
                );
              }

              if (item is TmdbMovie) {
                return GestureDetector(
                  onTap: () {
                    context.push('/movies/${item.id}');
                  },
                  child: MovieItem(
                    imageUrl: 'https://image.tmdb.org/t/p/w500${item.posterPath}',
                    movieName: item.title,
                    cumulativeSales: item.cumulativeSales,
                    providers: item.providers,
                    isFavorite: item.isFavorite,
                    isFavoriteScreen: isFavoriteScreen,
                    movieId: item.id,
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        if (showLoadingIndicator == true)
          const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          )
      ],
    );
  }
}
