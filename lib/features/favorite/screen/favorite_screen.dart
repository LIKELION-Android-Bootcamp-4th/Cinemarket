import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/favorite/widget/favorite_gridview.dart';
import 'package:cinemarket/features/favorite/widget/item_type.dart';
import 'package:cinemarket/widgets/goods_item.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dummyGoods = List.generate(10, (i) {
      return {
        'image':
            'https://i.ebayimg.com/images/g/64YAAOSwDqhnttak/s-l1200.png',
        'goodsName': '굿즈 ${i + 1}',
        'price': '${(i + 1) * 1000}원',
        'isFavorite': false,
      };
    });
    final List<Map<String, dynamic>> dummyMovies = List.generate(10, (i) {
      return {
        'image': 'https://image.tmdb.org/t/p/original/cQoCu9KQ0qCeFkWmpwYgWOyWFg2.jpg',
        'movieName': '영화 ${i + 1}',
        'cumulativeSales': '${(i + 1) * 100}',
        'provider': [ // todo: 이미지만 set으로 받아오기 ?
          'https://image.tmdb.org/t/p/original/hPcjSaWfMwEqXaCMu7Fkb529Dkc.jpg',
          'https://image.tmdb.org/t/p/original/8z7rC8uIDaTM91X0ZfkRf04ydj2.jpg',
          'https://image.tmdb.org/t/p/original/97yvRBw1GzX7fXprcF80er19ot.jpg'
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
                    FavoriteGridview(itemType: ItemType.goods, items: dummyGoods),
                    FavoriteGridview(itemType: ItemType.movie, items: dummyMovies),
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
