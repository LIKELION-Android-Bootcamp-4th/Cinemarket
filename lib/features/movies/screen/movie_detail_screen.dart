import 'package:cinemarket/features/movies/widgets/movie_detail_header.dart';
import 'package:cinemarket/features/movies/widgets/movie_info_row.dart';
import 'package:cinemarket/features/movies/widgets/synopsis_text.dart';
import 'package:cinemarket/widgets/common_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/widgets/common_app_bar.dart';

class MovieDetailScreen extends StatefulWidget {
  final String movieId;

  const MovieDetailScreen({super.key, required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final String posterUrl = 'https://image.tmdb.org/t/p/original/vqBmyAj0Xm9LnS1xe1MSlMAJyHq.jpg';
    final String thumbnailUrl = 'https://image.tmdb.org/t/p/original/vqBmyAj0Xm9LnS1xe1MSlMAJyHq.jpg';

    final double screenHeight = MediaQuery.of(context).size.height;


    return Scaffold(
      appBar: const CommonAppBar(title: '영화 상세'),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              MovieDetailHeader(
                posterUrl: posterUrl,
                thumbnailUrl: thumbnailUrl,
                isFavorite: isFavorite,
                onFavoriteToggle: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                },
              ),

              const MovieInfoRow(),
              const SizedBox(height: 30),

              // Tab View - 높이 지정
              SizedBox(
                height: screenHeight * 0.6, // 예: 전체 높이의 60%
                child: CommonTabView(
                  tabTitles: const ['줄거리 요약', '상품', '출연진'],
                  tabViews: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: SynopsisText(synopsis:
                          //추후 바꿔야함 -> 더미 데이터
                          "최고가 되지 못한 전설 VS 최고가 되고 싶은 루키! 한때 주목받는 유망주였지만 끔찍한 사고로 F1®에서 우승하지 못하고 한순간에 추락한 드라이버 '소니 헤이스'(브래드 피트). 그의 오랜 동료인 '루벤 세르반테스'(하비에르 바르뎀)에게 레이싱 복귀를 제안받으며 최하위 팀인 APXGP에 합류한다. 그러나 팀 내 떠오르는 천재 드라이버 '조슈아 피어스'(댐슨 이드리스)와 '소니 헤이스'의 갈등은 날이 갈수록 심해지고. 설상가상 우승을 향한 APXGP 팀의 전략 또한 번번이 실패하며 최하위권을 벗어나지 못하고 고전하는데··· 빨간 불이 꺼지고 운명을 건 레이스가 시작된다!"),
                    ),
                    Center(child: Text('상품 탭', style: AppTextStyle.body)),
                    Center(child: Text('출연진 탭', style: AppTextStyle.body)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
