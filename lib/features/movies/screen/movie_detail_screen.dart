import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/movies/widgets/build_best_goods_grid.dart';
import 'package:cinemarket/features/movies/viewmodel/movie_detail_viewmodel.dart';
import 'package:cinemarket/features/movies/widgets/cast_grid_view.dart';
import 'package:cinemarket/features/movies/widgets/movie_detail_header.dart';
import 'package:cinemarket/features/movies/widgets/movie_info_row.dart';
import 'package:cinemarket/features/movies/widgets/synopsis_text.dart';
import 'package:cinemarket/widgets/common_tab_view.dart';
import 'package:cinemarket/widgets/common_toast.dart';
import 'package:cinemarket/widgets/movie_item.dart'
    show requireLoginBeforeAction, updateFavoriteStatus;
import 'package:flutter/material.dart';
import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/widgets/common_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

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
    return ChangeNotifierProvider<MovieDetailViewModel>(
      create: (_) => MovieDetailViewModel()
        ..loadMovieDetail(int.parse(widget.movieId))
        ..loadRecommendedGoods(widget.movieId),
      child: Consumer<MovieDetailViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final movieDetail = vm.movieDetail;
          final castList = vm.castList;

          return Scaffold(
            appBar: const CommonAppBar(title: '영화 상세'),
            backgroundColor: AppColors.background,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MovieDetailHeader(
                      posterUrl:
                      'https://image.tmdb.org/t/p/w500${movieDetail!.backdropPath}',
                      thumbnailUrl:
                      'https://image.tmdb.org/t/p/w500${movieDetail.posterPath}',
                      isFavorite: isFavorite,
                      onFavoriteToggle: () async {
                        // 로그인 요청  // 하지 않는다면 바로 action 종료
                        if (!await requireLoginBeforeAction(context)) return;

                        if (await updateFavoriteStatus(movieId: widget.movieId)) {
                          if (!context.mounted) return;

                          setState(() => isFavorite = !isFavorite);
                          CommonToast.show(
                            context: context,
                            message: isFavorite ? '찜 추가 완료 !' : '찜 삭제 완료 !',
                            type: ToastificationType.success,
                          );
                        } else {
                          CommonToast.show(
                            context: context,
                            message: '에러 발생',
                            type: ToastificationType.error,
                          );
                        }
                      },
                      title: movieDetail.title,
                      voteAverage: movieDetail.voteAverage,
                      providers: movieDetail.providers ?? [],
                    ),

                    MovieInfoRow(
                      genres: movieDetail.genres,
                      releaseYear: movieDetail.releaseYear,
                      runtime: movieDetail.runtime,
                    ),
                    const SizedBox(height: 30),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: CommonTabView(
                        tabTitles: const ['줄거리 요약', '굿즈', '출연진'],
                        tabViews: [
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: SynopsisText(synopsis: movieDetail.overview),
                          ),
                          vm.goodsList.isEmpty
                              ? Center(
                            child: Text(
                              '굿즈 정보가 없습니다.',
                              style: AppTextStyle.body,
                            ),
                          )
                              : buildBestGoodsGrid(
                            vm.goodsList,
                            movieDetail.title,
                          ),
                          CastGridView(castList: castList),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
