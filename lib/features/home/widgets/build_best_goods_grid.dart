import 'package:cinemarket/features/home/model/best_goods.dart';
import 'package:cinemarket/widgets/goods_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget buildBestGoodsGrid(List<BestGoods> goodsList,String movieName) {
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    itemCount: goodsList.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 0.7,
    ),
    itemBuilder: (context, index) {
      final item = goodsList[index];
      return GestureDetector(
        onTap: () {
          context.push('/goods/${item.id}');
        },
        child: GoodsItem(
          imageUrl: item.images.main,
          goodsName: item.name,
          movieName: movieName,
          price: '${item.price} 원',
          rating: item.reviewStats.averageRating,
          reviewCount: item.reviewCount,
          isFavorite: item.isFavorite,
        )
      );
    },
  );
}
