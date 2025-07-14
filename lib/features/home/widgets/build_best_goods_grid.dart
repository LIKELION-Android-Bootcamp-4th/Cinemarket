import 'package:cinemarket/features/home/model/best_goods.dart';
import 'package:cinemarket/widgets/goods_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

Widget buildBestGoodsGrid(List<BestGoods> goodsList,String movieName) {
  final formatter = NumberFormat('#,###');
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
      final formattedPrice = '${formatter.format(item.price)}원';
      return GestureDetector(
        onTap: () {
          context.push('/goods/${item.id}');
        },
        child: GoodsItem(
          goodsId: item.id,
          imageUrl: item.images.main,
          goodsName: item.name,
          movieTitle: movieName,
          price: formattedPrice,
          rating: item.reviewStats.averageRating,
          reviewCount: item.reviewCount,
          isFavorite: item.isFavorite,
        )
      );
    },
  );
}
