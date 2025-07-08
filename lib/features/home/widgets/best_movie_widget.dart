import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/home/widgets/best_goods_widget.dart';
import 'package:cinemarket/widgets/movie_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BestMovieWidget extends StatelessWidget {
  const BestMovieWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final movies = [
      {
        "id": 1,
        "imageUrl": "https://search.pstatic.net/common?quality=75&direct=true&src=https%3A%2F%2Fmovie-phinf.pstatic.net%2F20240612_151%2F1718180074487NH0V5_JPEG%2Fmovie_image.jpg",
        "movieName": "인사이드 아웃 2",
        "cumulativeSales": 13874512,
        "providers": [
          {
            "Disney+": "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Disney_plus_icon.png/960px-Disney_plus_icon.png?20231225065415"
          }
        ],
        "isFavorite": false,
      },
      {
        "id": 2,
        "imageUrl": "https://search.pstatic.net/common?quality=75&direct=true&src=https%3A%2F%2Fmovie-phinf.pstatic.net%2F20240425_256%2F17140073560223JK9r_JPEG%2Fmovie_image.jpg",
        "movieName": "범죄도시 4",
        "cumulativeSales": 9876543,
        "providers": [
          {
            "Netflix": "https://upload.wikimedia.org/wikipedia/commons/thumb/7/75/Netflix_icon.svg/640px-Netflix_icon.svg.png"
          }
        ],
        "isFavorite": true,
      },
      {
        "id": 3,
        "imageUrl": "https://i.namu.wiki/i/BrJlUyt7V_w4jzAHrS6ksBilrTyY-wZYmD8GZCCOSy-YaH92ZIhP5l2ayOsgmamJTA7Ob18BoMYu8RmeaxMCrA.webp",
        "movieName": "퓨리오사: 매드맥스 사가",
        "cumulativeSales": 7521345,
        "providers": [
          {
            "Netflix": "https://upload.wikimedia.org/wikipedia/commons/thumb/7/75/Netflix_icon.svg/640px-Netflix_icon.svg.png"
          },
          {
            "Watcha": "https://play-lh.googleusercontent.com/vAkKvTtE8kdb0MWWxOVaqYVf0_suB-WMnfCR1MslBsGjhI49dAfF1IxcnhtpL3PnjVY"
          }
        ],
        "isFavorite": false,
      },
      {
        "id": 4,
        "imageUrl": "https://i.namu.wiki/i/2ic9bxOdR86soB6PNyQK6sEVbvzG-5Dys9Yfqh6HnWXxsXJT2gZxaIKcyHkUR9bgnICJyxhe5F5p9eGyf7thYA.webp",
        "movieName": "IF: 상상의 친구",
        "cumulativeSales": 6234987,
        "providers": [
          {
            "Netflix": "https://upload.wikimedia.org/wikipedia/commons/thumb/7/75/Netflix_icon.svg/640px-Netflix_icon.svg.png"
          },
          {
            "Watcha": "https://play-lh.googleusercontent.com/vAkKvTtE8kdb0MWWxOVaqYVf0_suB-WMnfCR1MslBsGjhI49dAfF1IxcnhtpL3PnjVY"
          }
        ],
        "isFavorite": false,
      },
      {
        "id": 5,
        "imageUrl": "https://search.pstatic.net/common?quality=75&direct=true&src=https%3A%2F%2Fmovie-phinf.pstatic.net%2F20240508_299%2F1715149331590vuPj9_JPEG%2Fmovie_image.jpg",
        "movieName": "혹성탈출: 새로운 시대",
        "cumulativeSales": 8431123,
        "providers": [
          {
            "Disney+": "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Disney_plus_icon.png/960px-Disney_plus_icon.png?20231225065415"
          },
          {
            "Netflix": "https://upload.wikimedia.org/wikipedia/commons/thumb/7/75/Netflix_icon.svg/640px-Netflix_icon.svg.png"
          },
          {
            "Watcha": "https://play-lh.googleusercontent.com/vAkKvTtE8kdb0MWWxOVaqYVf0_suB-WMnfCR1MslBsGjhI49dAfF1IxcnhtpL3PnjVY"
          }
        ],
        "isFavorite": true,
      },
    ];



    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '베스트 영화',
                  style: AppTextStyle.headline,
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      '더보기',
                      style: TextStyle(color: Colors.grey),
                    )
                )
              ]
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: movies.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final movie = movies[index];
                return GestureDetector(
                  onTap: () {
                    final movieId = movie['id'];
                    context.push('/movies/$movieId');
                  },
                  child: SizedBox(
                    width: 150,
                    child: MovieItem(
                      imageUrl: movie['imageUrl'] as String,
                      movieName: movie['movieName'] as String,
                      cumulativeSales: movie['cumulativeSales'] as int,
                      providers: movie['providers'] as List<Map<String,String>>,
                      isFavorite: movie['isFavorite'] as bool,
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