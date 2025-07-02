import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/features/favorite/widget/favorite_gridview.dart';
import 'package:cinemarket/features/favorite/widget/item_type.dart';
import 'package:cinemarket/widgets/sort_dropdown.dart';
import 'package:flutter/material.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 4),
                child: SortDropdown(itemType: ItemType.movie),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FavoriteGridview(
                itemType: ItemType.movie,
                items: dummyMovies,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
