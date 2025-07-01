import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/widgets/goods_item.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dummyGoods = List.generate(10, (i) {
      return {
        'image':
            'https://image.tmdb.org/t/p/original//lkDYN0whyE82mcM20rwtwjbniKF.jpg',
        'name': '상품 ${i + 1}',
        'price': '${(i + 1) * 1000}원',
        'isFavorite': false,
      };
    });

    return DefaultTabController(
      length: 2,
      child: Container(
        color: AppColors.background,
        child: Column(
          children: [
            const Material(
              color: AppColors.widgetBackground,
              child: TabBar(
                tabs: [
                  // Tab(child: Text('굿즈', style: TextStyle(fontSize: 20))),
                  Tab(child: Text('굿즈', style: TextStyle(fontSize: 20))),
                  Tab(child: Text('영화', style: AppTextStyle.headline)),
                  // todo: 커스텀 색상 사용 시 라벨 적용 안댐
                  // Tab(child: Text('영화', style: AppTextStyle.headline)),
                ],
                labelColor: AppColors.textPoint,
                unselectedLabelColor: AppColors.textPrimary,
                indicatorColor: AppColors.innerWidget,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: TabBarView(
                  children: [
                    GridView.builder(
                      itemCount: dummyGoods.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                      itemBuilder: (context, index) {
                        final product = dummyGoods[index];
                        return GoodsItem(
                          imageUrl: product['image'],
                          name: product['name'],
                          price: product['price'],
                        );
                      },
                    ),
                    const Center(child: Text('영화 탭 (미구현)')),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
