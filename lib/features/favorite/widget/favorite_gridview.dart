import 'package:cinemarket/features/favorite/widget/item_type.dart';
import 'package:cinemarket/widgets/goods_item.dart';
import 'package:cinemarket/widgets/movie_item.dart';
import 'package:flutter/material.dart';

class FavoriteGridview extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final ItemType itemType;

  const FavoriteGridview({super.key, required this.itemType, required this.items});

  @override
  Widget build(BuildContext context) {

    final double aspectRatio = switch (itemType) {
      ItemType.goods => 0.7,
      ItemType.movie => 0.51,
    };

    return GridView.builder(
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: aspectRatio,
        crossAxisSpacing: 8,  // todo: 그리드뷰 내부 패딩값 논의
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        final item = items[index];

        switch(itemType) {
          case ItemType.goods:
            return GoodsItem(
              imageUrl: item['imageUrl'],
              goodsName: item['goodsName'],
              movieName: item['movieName'],
              price: item['price'],
              rating: item['rating'],
              reviewCount: item['reviewCount'],
              isFavorite: item['isFavorite'],
            );
          case ItemType.movie:
            return MovieItem(imageUrl: item['imageUrl'],
                movieName: item['movieName'],
                cumulativeSales: item['cumulativeSales'],
                providers: item['providers'],
                isFavorite: item['isFavorite']
            );
        }
      },
    );
  }
}
