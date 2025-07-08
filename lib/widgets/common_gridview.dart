import 'package:cinemarket/core/constants/enums/item_type.dart';
import 'package:cinemarket/features/goods/model/goods.dart';
import 'package:cinemarket/widgets/goods_item.dart';
import 'package:cinemarket/widgets/movie_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CommonGridview<T> extends StatelessWidget {
  // final List<Map<String, dynamic>> items;
  final List<T> items;
  final ItemType itemType;
  final bool isInScrollView;

  const CommonGridview({
    super.key,
    required this.itemType,
    required this.items,
    this.isInScrollView = false,
  });

  @override
  Widget build(BuildContext context) {
    final double aspectRatio = switch (itemType) {
      ItemType.goods => 0.7,
      ItemType.movie => 0.51,
    };

    return GridView.builder(
      shrinkWrap: isInScrollView,
      physics: isInScrollView ? const NeverScrollableScrollPhysics() : null,
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: aspectRatio,
        crossAxisSpacing: 8, // todo: 그리드뷰 내부 패딩값 논의
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        final item = items[index];

        if (item is Goods) {
          return GestureDetector(
            onTap: () {
              context.push('/goods/${item.id}', );
            },
            child: GoodsItem(
              imageUrl: item.images.main,
              goodsName: item.name,
              movieName: item.id,
              price: '${item.price} 원',
              rating: item.reviewStats!.averageRating,
              reviewCount: item.reviewCount,
              isFavorite: item.isFavorite,
            ),
          );
        }

        // if (item is Movie) {}  // 추후 Movie 클래스 생성 이후
        return const SizedBox.shrink(); // 기본값
      },
    );
  }
}
