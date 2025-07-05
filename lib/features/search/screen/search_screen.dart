import 'package:cinemarket/core/constants/enums/item_type.dart';
import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/features/search/widgets/search_app_bar.dart';
import 'package:cinemarket/features/search/widgets/search_empty_result_widgets.dart';
import 'package:cinemarket/features/search/widgets/search_section_title_widgets.dart';
import 'package:cinemarket/widgets/common_gridview.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}


class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool hasSearched = false;

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

  List<Map<String, dynamic>> goodsResults = [];
  List<Map<String, dynamic>> movieResults = [];

  void _handleSearch(String query) {
    setState(() {
      hasSearched = true;

      goodsResults = dummyGoods
          .where((item) => item['goodsName']
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase()))
          .toList();

      movieResults = dummyMovies
          .where((item) => item['movieName']
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase()))
          .toList();

      print('goodsResults: ${goodsResults.length}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            SearchAppBar(
              controller: _searchController,
              onSearch: _handleSearch,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 32),
                children: [
                  const SearchSectionTitle(title: '굿즈'),
                  if (!hasSearched || goodsResults.isEmpty)
                    const SearchEmptyResultText()
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CommonGridview(
                        items: goodsResults,
                        itemType: ItemType.goods,
                        isInScrollView: true,
                      ),
                    ),

                  const SizedBox(height: 24),
                  const SearchSectionTitle(title: '영화'),
                  if (!hasSearched || movieResults.isEmpty)
                    const SearchEmptyResultText()
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CommonGridview(
                        items: movieResults,
                        itemType: ItemType.movie,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}