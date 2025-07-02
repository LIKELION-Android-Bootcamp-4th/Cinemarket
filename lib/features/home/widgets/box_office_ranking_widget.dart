import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class BoxOfficeRankingWidget extends StatelessWidget {
  const BoxOfficeRankingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyPosters = [
      'https://picsum.photos/seed/movie1/500/300',
      'https://picsum.photos/seed/movie2/500/300',
      'https://picsum.photos/seed/movie3/500/300',
      'https://picsum.photos/seed/movie4/500/300',
      'https://picsum.photos/seed/movie5/500/300',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '박스오피스 순위',
          style: AppTextStyle.headline,
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dummyPosters.length,
            itemBuilder: (context, index) {
              return Container(
                width: 200,
                margin: const EdgeInsets.only(right: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    dummyPosters[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
