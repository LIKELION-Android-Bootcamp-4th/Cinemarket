import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/goods/model/goods.dart';
import 'package:cinemarket/features/goods/widget/primary_image_widget.dart';
import 'package:flutter/material.dart';

class HeaderGoodsDetail extends StatelessWidget {
  final Goods item;

  const HeaderGoodsDetail({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final List<String> allImages = [item.images.main, ...item.images.sub];

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
              onTap: () => _showImageViewer(context, allImages, 0),
            ),

            const SizedBox(height: 8),

            if (item.images.sub.isNotEmpty) ...[
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: item.images.sub.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap:
                          () => _showImageViewer(context, allImages, index + 1),
                      child: Padding(
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
                      ),
                    );
                  },
                ),
              ),
            ],

            const SizedBox(height: 8),

            Text(item.name, style: AppTextStyle.section,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,),

            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const Icon(Icons.star_rate, color: Colors.yellow, size: 16),
                    Text(
                      '${item.reviewStats?.averageRating}',
                      style: AppTextStyle.bodySmall,
                    ),
                  ],
                ),

                const Spacer(),

                Text('₩ ${item.price} 원', style: AppTextStyle.body),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void _showImageViewer(
  BuildContext context,
  List<String> images,
  int initialIndex,
) {
  showDialog(
    context: context,
    barrierColor: const Color.fromRGBO(0, 0, 0, 0.8),
    builder: (context) {
      return Dialog(
        insetPadding: const EdgeInsets.all(16),
        backgroundColor: Colors.transparent,
        child: SizedBox(
          // height: 500,
          width: 300,
          child: PageView.builder(
            controller: PageController(initialPage: initialIndex),
            itemCount: images.length,
            itemBuilder: (context, index) {
              return InteractiveViewer(
                // pinch-zoom 가능
                child: Image.network(images[index], fit: BoxFit.contain),
              );
            },
          ),
        ),
      );
    },
  );
}
