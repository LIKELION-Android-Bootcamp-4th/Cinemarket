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
  final ScrollController _scrollController = ScrollController();
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
      context.read<SearchViewModel>().reset();
    } else {
      Navigator.pop(context);
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SearchViewModel>();
    final movieResults = viewModel.pageMovieResults;
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
                  : Stack(
                children: [
                  ListView(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    children: [
                      const SearchSectionTitle(title: '굿즈'),
                      if (!hasSearched || goodsResults.isEmpty)
                        const SearchEmptyResultText()
                      else ...[
                        CommonGridview<Goods>(
                          items: goodsResults.map((item) {
                            return Goods(
                              id: item.id,
                              name: item.name,
                              description: item.description,
                              price: item.price,
                              stock: item.stock,
                              status: item.status,
                              favoriteCount: item.favoriteCount,
                              viewCount: item.viewCount,
                              orderCount: item.orderCount,
                              reviewCount: item.reviewCount,
                              createdAt: item.createdAt,
                              images: GoodsImages(
                                main: item.mainImage,
                                sub: const [],
                              ),
                              reviewStats: item.reviewStats,
                              isFavorite: item.isFavorite,
                            );
                          }).toList(),
                          itemType: ItemType.goods,
                          isInScrollView: true,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            viewModel.totalPages,
                                (index) {
                              final pageNum = index + 1;
                              final isSelected = pageNum == viewModel.currentPage;
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: ElevatedButton(
                                  onPressed: () {
                                    viewModel.goToGoodsPage(pageNum);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isSelected
                                        ? AppColors.textPrimary
                                        : AppColors.widgetBackground,
                                    foregroundColor: isSelected
                                        ? AppColors.background
                                        : AppColors.textPrimary,
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                  ),
                                  child: Text('$pageNum'),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                      const SizedBox(height: 24),
                      const SearchSectionTitle(title: '영화'),
                      if (!hasSearched || movieResults.isEmpty)
                        const SearchEmptyResultText()
                      else ...[
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
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            viewModel.movieTotalPages,
                                (index) {
                              final pageNum = index + 1;
                              final isSelected = pageNum == viewModel.currentMoviePage;
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: ElevatedButton(
                                  onPressed: () {
                                    viewModel.goToMoviePage(pageNum);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isSelected
                                        ? AppColors.textPrimary
                                        : AppColors.widgetBackground,
                                    foregroundColor: isSelected
                                        ? AppColors.background
                                        : AppColors.textPrimary,
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                  ),
                                  child: Text('$pageNum'),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                      const SizedBox(height: 10),
                    ],
                  ),
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: SizedBox(
                      width: 48,
                      height: 48,
                      child: FloatingActionButton(
                        onPressed: _scrollToTop,
                        backgroundColor: AppColors.pointAccent,
                        elevation: 4,
                        shape: const CircleBorder(),
                        child: const Icon(Icons.arrow_upward, size: 20),
                      ),
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