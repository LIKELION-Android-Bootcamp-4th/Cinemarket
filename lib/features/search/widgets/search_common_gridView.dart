import 'package:cinemarket/core/constants/enums/item_type.dart';
import 'package:cinemarket/features/goods/model/goods.dart';
import 'package:cinemarket/features/goods/viewmodel/goods_all_viewmodel.dart';
import 'package:cinemarket/features/home/model/tmdb_movie.dart';
import 'package:cinemarket/widgets/goods_item.dart';
import 'package:cinemarket/widgets/movie_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchGridview<T> extends StatelessWidget {
  final List<T> items;
  final ItemType itemType;

  const SearchGridview({
    super.key,
    required this.items,
    required this.itemType,
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

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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
              isFavoriteScreen: false,
              movieId: item.id,
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}