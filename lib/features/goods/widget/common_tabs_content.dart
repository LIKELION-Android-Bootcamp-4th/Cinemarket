import 'package:cinemarket/features/goods/widget/recommend_goods_widget.dart';
import 'package:flutter/material.dart';

class CommonTabsContent extends StatelessWidget {
  final List<Widget> widgets;

  const CommonTabsContent({super.key, required this.widgets});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          ...widgets,
          const SizedBox(height: 8),
          RecommendGoodsWidget(dummyGoods: dummyGoods),
        ],
      ),
    );
  }
}

final List<Map<String, dynamic>> dummyGoods = List.generate(10, (i) {
  return {
    'imageUrl': 'https://i.ebayimg.com/images/g/64YAAOSwDqhnttak/s-l1200.png',
    'goodsName': '굿즈 ${i + 1}',
    'movieName': '관련 영화',
    'price': '${(i + 1) * 1000}원',
    'rating': 4.5,
    'reviewCount': 10,
    'isFavorite': false,
  };
});
