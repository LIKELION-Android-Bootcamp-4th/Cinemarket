import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/goods/model/goods.dart';
import 'package:cinemarket/features/goods/widget/primary_image_widget.dart';
import 'package:flutter/material.dart';

class HeaderGoodsDetail extends StatelessWidget {
  final Goods item;

  const HeaderGoodsDetail({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryImageWidget(
              goodsId: item.id,
              imageUrl: item.images.main,
              isFavorite: item.isFavorite,
            ),

            const SizedBox(height: 8),

            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: item.images.sub.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: SizedBox(
                      width: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          item.images.sub[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.star_rate, color: Colors.yellow, size: 16),
                    Text('${item.reviewStats?.averageRating}', style: AppTextStyle.bodySmall),
                  ],
                ),

                const Spacer(),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(item.name, style: AppTextStyle.section),
                    Text('${item.price}', style: AppTextStyle.bodySmall),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}