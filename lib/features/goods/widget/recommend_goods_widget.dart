import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/goods/viewmodel/goods_recommended_viewmodel.dart';
import 'package:cinemarket/widgets/goods_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RecommendGoodsWidget extends StatelessWidget {
  static const double _listHeight = 220;


  const RecommendGoodsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GoodsRecommendedViewModel>(
      builder:  (context, vm, _) {
        if (vm.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (vm.errorMessage != null) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(vm.errorMessage!, style: AppTextStyle.body),
          );
        }
        if (vm.recommendedGoods.isEmpty) {
          return const SizedBox();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text('추천 굿즈', style: AppTextStyle.section),
            const SizedBox(height: 8),
            SizedBox(
              height: _listHeight,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: vm.recommendedGoods.length,
                itemBuilder: (context, index) {
                  final item = vm.recommendedGoods[index];
                    return GestureDetector(
                      onTap: () {
                        context.push('/goods/${item.id}');
                      },
                      child: SizedBox(
                        width: 200,
                        child: GoodsItem(
                          goodsId: item.id,
                          imageUrl: item.images.main,
                          goodsName: item.name,
                          movieTitle: '없음',
                          price: '￦${item.price}',
                          stock: item.stock,
                          // rating: item.reviewStats.averageRating,
                          reviewCount: item.reviewCount,
                          rating: 0.0,
                          // reviewCount:10,
                          isFavorite: item.isFavorite,
                        ),
                      ),
                    );
                },
              ),
            ),
          ],
        );
      },
    );

  }
}
