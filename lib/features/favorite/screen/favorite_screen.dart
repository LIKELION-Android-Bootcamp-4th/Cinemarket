import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/widgets/common_gridview.dart';
import 'package:cinemarket/core/constants/enums/item_type.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dummyGoods = List.generate(10, (i) {
      return {
        'imageUrl':
            'https://i.ebayimg.com/images/g/64YAAOSwDqhnttak/s-l1200.png',
        'goodsName': '굿즈 ${i + 1}',
        'movieName': '관련 영화',
        'price': '${(i + 1) * 1000}원',
        'rating': 4.5,
        'reviewCount': 10,
        'isFavorite': false,
      };
    });
    final List<Map<String, dynamic>> dummyMovies = List.generate(10, (i) {
      return {
        'imageUrl':
            'https://image.tmdb.org/t/p/original/vqBmyAj0Xm9LnS1xe1MSlMAJyHq.jpg',
        'movieName': '영화 ${i + 1}',
        'cumulativeSales': (i + 1) * 100,
        'providers': [
          'https://image.tmdb.org/t/p/original/hPcjSaWfMwEqXaCMu7Fkb529Dkc.jpg',
          'https://image.tmdb.org/t/p/original/8z7rC8uIDaTM91X0ZfkRf04ydj2.jpg',
          'https://image.tmdb.org/t/p/original/97yvRBw1GzX7fXprcF80er19ot.jpg',
        ],
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
                  Tab(child: Text('영화', style: AppTextStyle.section)),
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
                    CommonGridview(
                      itemType: ItemType.goods,
                      items: dummyGoods,
                    ),
                    CommonGridview(
                      itemType: ItemType.movie,
                      items: dummyMovies,
                    ),
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
