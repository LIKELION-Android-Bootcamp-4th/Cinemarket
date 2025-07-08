import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/goods/widget/primary_image_widget.dart';
import 'package:flutter/material.dart';

class HeaderGoodsDetail extends StatelessWidget {
  final Map<String, dynamic> item;

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
              imageUrl: item['imageUrl'],
              isFavorite: item['isFavorite'],
            ),

            const SizedBox(height: 8),

            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dummyGoodsImages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: SizedBox(
                      width: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          dummyGoodsImages[index],
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
                    Text(item['goodsName'], style: AppTextStyle.section),
                    Text("${item['price']}", style: AppTextStyle.bodySmall),
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

final List<String> dummyGoodsImages = [
  'https://i.ebayimg.com/images/g/WgwAAOSw~qJnttY4/s-l1200.jpg',
  'https://i.ebayimg.com/images/g/f1oAAOSwq~JnDljW/s-l1200.jpg',
  'https://i.ebayimg.com/images/g/5RMAAOSwhlxnlJl4/s-l400.jpg',
  'https://i.ebayimg.com/images/g/BzAAAeSweMtn22-l/s-l1200.png',
];