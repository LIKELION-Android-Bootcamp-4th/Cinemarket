import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class BoxOfficeRankingWidget extends StatefulWidget {
  const BoxOfficeRankingWidget({super.key});

  @override
  State<BoxOfficeRankingWidget> createState() => _BoxOfficeRankingWidgetState();
}


class _BoxOfficeRankingWidgetState extends State<BoxOfficeRankingWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> dummyPosters = [
    'https://picsum.photos/seed/movie1/500/750',
    'https://picsum.photos/seed/movie2/500/750',
    'https://picsum.photos/seed/movie3/500/750',
    'https://picsum.photos/seed/movie4/500/750',
    'https://picsum.photos/seed/movie5/500/750',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '박스오피스 순위',
          style: AppTextStyle.headline,
        ),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final height = width * 1.5;

            return SizedBox(
              height: height,
              width: width,
              child: PageView.builder(
                controller: _pageController,
                itemCount: dummyPosters.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: AspectRatio(
                      aspectRatio: 2 / 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          dummyPosters[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(dummyPosters.length, (index) {
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
