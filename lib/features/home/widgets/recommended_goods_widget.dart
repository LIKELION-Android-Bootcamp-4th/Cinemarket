import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/home/widgets/best_goods_widget.dart';
import 'package:flutter/material.dart';

class RecommendedGoodsWidget extends StatelessWidget {
  const RecommendedGoodsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> dummyGoods = List.generate(10, (index) => '추천 굿즈 ${index+1}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '추천 굿즈',
          style: AppTextStyle.headline
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.8,
          children: dummyGoods.map((label) => SampleCard(label: label)).toList()
        )
      ],
    );
  }
}