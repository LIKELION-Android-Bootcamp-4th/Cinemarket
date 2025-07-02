import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class BoxOfficeRankingWidget extends StatefulWidget {
  const BoxOfficeRankingWidget({super.key});

  @override
  State<BoxOfficeRankingWidget> createState() => _BoxOfficeRankingWidgetState();
}


class _BoxOfficeRankingWidgetState extends State<BoxOfficeRankingWidget> {
  final PageController _pageController = PageController(viewportFraction: 0.7);
  int _currentPage = 0;

  final List<Map<String, String>> dummyMovies = [
    {
      'title': '영화 제목 1',
      'releaseDate': '2024.01.01',
      'poster': 'https://picsum.photos/seed/movie1/300/450',
    },
    {
      'title': '영화 제목 2',
      'releaseDate': '2023.03.25',
      'poster': 'https://picsum.photos/seed/movie2/300/450',
    },
    {
      'title': '영화 제목 3',
      'releaseDate': '2019.01.11',
      'poster': 'https://picsum.photos/seed/movie3/300/450',
    },
    {
      'title': '영화 제목 4',
      'releaseDate': '2022.07.08',
      'poster': 'https://picsum.photos/seed/movie4/300/450',
    },
    {
      'title': '영화 제목 5',
      'releaseDate': '2024.01.15',
      'poster': 'https://picsum.photos/seed/movie5/300/450',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double posterWidth = MediaQuery.of(context).size.width * 0.7;
    final double posterHeight = posterWidth * 1.5;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '박스오피스 순위',
          style: AppTextStyle.headline,
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: posterHeight,
          child: PageView.builder(
            controller: PageController(viewportFraction: 0.7),
            itemCount: dummyMovies.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Transform.scale(
                          scale: index == _currentPage ? 1: 0.9,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              dummyMovies[index]['poster']!,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          dummyMovies[index]['title']!,
                          style: AppTextStyle.body,
                        ),
                        Text(
                          dummyMovies[index]['releaseDate']!,
                          style: AppTextStyle.point,
                        ),
                      ],
                    )

                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(dummyMovies.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentPage == index ? 12 : 8,
              height: _currentPage == index ? 12 : 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index ? AppColors.pointAccent : AppColors.textPrimary,
              ),
            );
          }),
        ),
      ],
    );
  }
}
