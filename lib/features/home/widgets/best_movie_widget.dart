import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/home/viewmodel/best_movie_viewmodel.dart';
import 'package:cinemarket/widgets/movie_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BestMovieWidget extends StatelessWidget {
  const BestMovieWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BestMovieViewModel>(
      create: (_) {
        final vm = BestMovieViewModel();
        vm.loadTrendingMovies();
        return vm;
      },
      child: Consumer<BestMovieViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.errorMessage != null) {
            return Center(child: Text('에러: ${vm.errorMessage}'));
          }

          if (vm.movies.isEmpty) {
            return const Center(child: Text('데이터가 없습니다.'));
          }

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
                        onPressed: () {
                          context.push('/movieslist');
                        },
                        child: const Text(
                          '영화 더보기',
                          style: AppTextStyle.point
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
                  itemCount: vm.movies.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final movie = vm.movies[index];
                    return GestureDetector(
                      onTap: () {
                        context.push('/movies/${movie.id}');
                      },
                      child: SizedBox(
                        width: 150,
                        child: MovieItem(
                          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                          movieName: movie.title,
                          cumulativeSales: 12112, //추후 API 연동..
                          providers: movie.providers,
                          isFavorite: false, //추후 추가 예정  // todo:
                          movieId: movie.id,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }


      )
    );


  }
}