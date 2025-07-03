import 'package:cinemarket/features/home/widgets/best_goods_widget.dart';
import 'package:cinemarket/features/home/widgets/best_movie_widget.dart';
import 'package:cinemarket/features/home/widgets/box_office_ranking_widget.dart';
import 'package:cinemarket/features/home/widgets/recommended_goods_widget.dart';
import 'package:flutter/material.dart';
import 'package:cinemarket/core/network/api_client.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  //API 테스트용 코드 - 추후 삭제 예정
  Future<void> _testLogin() async {
    try {
      final response = await ApiClient.dio.post(
        '/api/auth/login',
        data: {
          "email": "admin@git.hansul.kr",
          "password": "qwer1234!@#\$"
        },
      );
      print('✅ 로그인 성공');
      print(response.data);
    } catch (e) {
      print('로그인 실패: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    _testLogin(); // 홈 진입 시 바로 로그인 요청
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        BoxOfficeRankingWidget(),
        SizedBox(height: 24),
        BestGoodsWidget(),
        SizedBox(height: 24),
        BestMovieWidget(),
        SizedBox(height: 24),
        RecommendedGoodsWidget()
      ],
    );
  }
}
