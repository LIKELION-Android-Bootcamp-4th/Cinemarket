import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class RecommendGoodsWidget extends StatelessWidget {
  static const double _itemImageWidth = 100;
  static const double _listHeight = 150;

  final List<Map<String, dynamic>> dummyGoods;

  const RecommendGoodsWidget({super.key, required this.dummyGoods});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const Text('추천 굿즈', style: AppTextStyle.section),
        const SizedBox(height: 8),
        SizedBox(
          height: _listHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dummyGoods.length,
            itemBuilder: (context, index) {
              final item = dummyGoods[index];
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        item['imageUrl'],
                        width: _itemImageWidth,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 8,),
                    Text(item['goodsName'], style: AppTextStyle.bodySmall,),
                    Text(item['price'], style: AppTextStyle.bodySmall,),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
