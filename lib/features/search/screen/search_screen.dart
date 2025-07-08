import 'package:cinemarket/core/constants/enums/item_type.dart';
import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/features/search/model/search_tmdb_model.dart';
import 'package:cinemarket/features/search/viewmodel/search_view_model.dart';
import 'package:cinemarket/features/search/widgets/search_app_bar.dart';
import 'package:cinemarket/features/search/widgets/search_empty_result.dart';
import 'package:cinemarket/features/search/widgets/search_section_title.dart';
import 'package:cinemarket/widgets/common_gridview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool hasSearched = false;

  void _handleSearch(String query) async {
    if (query.trim().isEmpty) {
      setState(() => hasSearched = false);
      return;
    }

    setState(() => hasSearched = true);
    await context.read<SearchViewModel>().search(query);
  }

  void _handleBack() {
    if (hasSearched) {
      setState(() {
        hasSearched = false;
        _searchController.clear();
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SearchViewModel>();
    final movieResults = viewModel.tmdbResults;
    final goodsResults = viewModel.goodsResults;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            SearchAppBar(
              controller: _searchController,
              onSearch: _handleSearch,
              onBack: _handleBack,
            ),
            Expanded(
              child:
              viewModel.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                children: [
                  const SearchSectionTitle(title: '굿즈'),
                  if (!hasSearched || goodsResults.isEmpty)
                    const SearchEmptyResultText()
                  else
                    CommonGridview(
                      items: goodsResults.map((item) => {
                          'imageUrl': item.mainImage,
                          'goodsName': item.name,
                          'movieName': item.description,
                          'price': '${item.price}원',
                          'rating': 0.0,
                          'reviewCount': 0,
                          'isFavorite': false,
                        },
                      ).toList(),
                      itemType: ItemType.goods,
                      isInScrollView: true,
                    ),
                  const SizedBox(height: 24),
                  const SearchSectionTitle(title: '영화'),
                  if (!hasSearched || movieResults.isEmpty)
                    const SearchEmptyResultText()
                  else
                    CommonGridview(
                      items:
                      movieResults.map(
                            (movie) => {
                          'imageUrl':
                          movie.posterPath.isNotEmpty
                              ? 'https://image.tmdb.org/t/p/original/${movie.posterPath}'
                              : '',
                          'movieName': movie.title,
                          'cumulativeSales': 0,
                          'providers': <String>[],
                          'isFavorite': false,
                        },
                      ).toList(),
                      itemType: ItemType.movie,
                      isInScrollView: true,
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