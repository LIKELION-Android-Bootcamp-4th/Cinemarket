import 'package:cinemarket/core/constants/enums/item_type.dart';
import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/features/goods/model/goods.dart';
import 'package:cinemarket/features/goods/model/goods_images.dart';
import 'package:cinemarket/features/goods/model/review_stats.dart';
import 'package:cinemarket/features/home/model/tmdb_movie.dart';
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
              child: viewModel.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                children: [
                  const SearchSectionTitle(title: '굿즈'),
                  if (!hasSearched || goodsResults.isEmpty)
                    const SearchEmptyResultText()
                  else
                    CommonGridview<Goods>(
                      items: goodsResults.map((item) {
                        return Goods(
                          id: item.id,
                          name: item.name,
                          description: item.description,
                          price: item.price,
                          stock: 0, // 임시값, 실제 데이터가 있다면 반영
                          status: 'on_sale', // 임시값, 실제 item.status 있으면 사용
                          favoriteCount: 0,
                          viewCount: 0,
                          orderCount: 0,
                          reviewCount: 0,
                          createdBy: 'unknown', // 실제 값 필요하면 item.createdBy 사용
                          images: GoodsImages(
                            main: item.mainImage,
                            sub: const [],
                          ),
                          reviewStats: ReviewStats(
                            averageRating: 0.0,
                            totalReviews: 0,
                            ratingDistribution: {},
                          ),
                          isFavorite: false,
                        );
                      }).toList(),
                      itemType: ItemType.goods,
                      isInScrollView: true,
                    ),
                  const SizedBox(height: 24),
                  const SearchSectionTitle(title: '영화'),
                  if (!hasSearched || movieResults.isEmpty)
                    const SearchEmptyResultText()
                  else
                    CommonGridview<TmdbMovie>(
                      items: movieResults.map((movie) {
                        return TmdbMovie(
                          id: movie.id,
                          title: movie.title,
                          overview: movie.overview,
                          posterPath: movie.posterPath,
                          releaseDate: movie.releaseDate,
                          voteAverage: movie.voteAverage,
                          popularity: movie.popularity,
                          providers: [],
                        );
                      }).toList(),
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