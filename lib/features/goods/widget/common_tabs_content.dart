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
          RecommendGoodsWidget(),
        ],
      ),
    );
  }
}

