import 'package:cinemarket/features/home/widgets/best_goods_widget.dart';
import 'package:cinemarket/features/home/widgets/best_movie_widget.dart';
import 'package:cinemarket/features/home/widgets/box_office_ranking_widget.dart';
import 'package:cinemarket/features/home/widgets/recommended_goods_widget.dart';
import 'package:flutter/material.dart';
import 'package:cinemarket/core/network/api_client.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // //API 테스트용 코드 - 추후 삭제 예정
  // Future<void> _testLogin() async {
  //   try {
  //     final response = await ApiClient.dio.post(
  //       '/api/auth/login',
  //       data: {
  //         "email": "admin@git.hansul.kr",
  //         "password": "qwer1234!@#\$"
  //       },
  //     );
  //     print('✅ 로그인 성공');
  //     print(response.data);
  //   } catch (e) {
  //     print('로그인 실패: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // _testLogin();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BoxOfficeRankingWidget(),
          const SizedBox(height: 24),
          const BestGoodsWidget(),
          ElevatedButton(
            onPressed: () {
              context.go('/movies/123');
            },
            child: const Text('go'),
          ),
          const SizedBox(height: 24),
          const BestMovieWidget(),
          const SizedBox(height: 24),
          const RecommendedGoodsWidget(),
        ],
      ),
    );
  }

}
