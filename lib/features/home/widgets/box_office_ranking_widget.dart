import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/home/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class BoxOfficeRankingWidget extends StatefulWidget {
  const BoxOfficeRankingWidget({super.key});

  @override
  State<BoxOfficeRankingWidget> createState() => _BoxOfficeRankingWidgetState();
}

class _BoxOfficeRankingWidgetState extends State<BoxOfficeRankingWidget> {
  final CarouselSliderController _carouselController = CarouselSliderController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<HomeViewModel>();
      String formatDate(DateTime dt) {
        return '${dt.year.toString().padLeft(4, '0')}${dt.month.toString().padLeft(2, '0')}${dt.day.toString().padLeft(2, '0')}';
      }

      vm.loadMovies(formatDate(DateTime.now().subtract(const Duration(days: 1))));
    });
  }

  Widget _buildLoadingSkeleton(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.7;
    final height = width * 1.4;

    return Shimmer.fromColors(
      baseColor: AppColors.widgetBackground,
      highlightColor: AppColors.widgetBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 8),
          Container(width: width * 0.6, height: 20, color: Colors.white),
          const SizedBox(height: 6),
          Container(width: width * 0.3, height: 16, color: Colors.white),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, vm, child) {
        if (vm.isLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.width * 1.4 + 60,
            child: Center(child: _buildLoadingSkeleton(context)),
          );
        }

        if (vm.errorMessage != null) {
          return Center(child: Text(vm.errorMessage!));
        }

        if (vm.movies.isEmpty) {
          return const Center(child: Text('데이터가 없습니다.'));
        }

        final movies = vm.movies;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('박스오피스 순위', style: AppTextStyle.headline),
            const SizedBox(height: 20),
            CarouselSlider.builder(
              carouselController: _carouselController,
              itemCount: movies.length,
              options: CarouselOptions(
                height: MediaQuery.of(context).size.width * 1.2,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                enlargeCenterPage: true,
                viewportFraction: 0.6,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentPage = index;
                  });
                },
              ),
              itemBuilder: (context, index, realIndex) {
                final movie = movies[index];
                final posterUrl = movie.posterPath.isNotEmpty
                    ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                    : 'https://via.placeholder.com/300x450?text=No+Image';

                return GestureDetector(
                  onTap: () {
                    context.push('/movies/${movie.id}');
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 2 / 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            posterUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                            const Center(child: Icon(Icons.broken_image)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Text(
                              movie.title,
                              style: AppTextStyle.section,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star_border, size: 20, color: Colors.amber),
                              const SizedBox(width: 4),
                              Text(
                                movie.voteAverage.toStringAsFixed(1),
                                style: const TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.amber,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),
                      Text(
                        movie.releaseDate,
                        style: AppTextStyle.bodySmall,
                      ),
                    ],
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(movies.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 12 : 8,
                  height: _currentPage == index ? 12 : 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? AppColors.pointAccent
                        : AppColors.textPrimary,
                  ),
                );
              }),
            ),
          ],
        );
      },
    );
  }
}
