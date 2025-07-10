import 'package:cinemarket/core/model/list_response.dart';
import 'package:cinemarket/features/home/model/best_goods.dart';
import 'package:cinemarket/features/movies/model/tmdb_movie_detail.dart';
import 'package:cinemarket/features/movies/model/cast_member.dart';
import 'package:cinemarket/features/movies/service/movies_service.dart';

class MovieDetailRepository {
  final MoviesService _service = MoviesService();

  Future<TmdbMovieDetail> getMovieDetail(int movieId) {
    return _service.fetchMovieDetail(movieId);
  }

  Future<List<CastMember>> getMovieCredits(int movieId) {
    return _service.fetchMovieCredits(movieId);
  }

  Future<ListResponse<BestGoods>> fetchMovieProducts(String contentId) async {
    final response = await _service.fetchMovieProducts(contentId);
    for (var item in response.data['data']['items']) {
      print(item);
    }
    final listResponse = ListResponse<BestGoods>.fromJson(
      response.data,
          (json) => BestGoods.fromJson(json),
    );
    return listResponse;
  }
}
