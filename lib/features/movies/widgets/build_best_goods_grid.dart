import 'package:cinemarket/features/home/model/best_goods.dart';
import 'package:cinemarket/widgets/goods_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget buildBestGoodsGrid(List<BestGoods> goodsList,String movieName) {
  return GridView.builder(
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
          goodsId: item.id,
          imageUrl: item.images.main,
          goodsName: item.name,
          movieTitle: movieName,
          price: item.price,
          stock: item.stock,
          viewCount: item.viewCount,
          showRatingInsteadOfViewCount: false,
          rating: item.reviewStats.averageRating,
          reviewCount: item.reviewCount,
          isFavorite: item.isFavorite,
        )
      );
    },
  );
}
