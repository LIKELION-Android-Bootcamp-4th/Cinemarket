import 'package:cinemarket/features/favorite/widget/item_type.dart';
import 'package:cinemarket/widgets/goods_item.dart';
import 'package:flutter/material.dart';

class FavoriteGridview extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final ItemType itemType;

  const FavoriteGridview({super.key, required this.itemType, required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.7,
        crossAxisSpacing: 8,  // todo: 그리드뷰 내부 패딩값 논의
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        final product = items[index];

        switch(itemType) {
          case ItemType.goods:
            return GoodsItem(
              imageUrl: product['image'],
              name: product['goodsName'],
              price: product['price'],
              isFavorite: product['isFavorite'],
            );
          case ItemType.movie:
            return const Center(child: Text('영화 탭 (미구현)'));
        }
      },
    );
  }
}
