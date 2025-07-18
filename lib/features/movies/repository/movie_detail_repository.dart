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

  Future<List<BestGoods>> fetchMovieProducts(String contentId) async {
    final response = await _service.fetchMovieProducts(contentId);

    final data = response.data;

    final success = data['success'] == true;
    if (!success) throw Exception(data['message'] ?? '굿즈 정보 불러오기 실패');

    final itemsJson = data['data']?['items'] as List<dynamic>? ?? [];

    final goodsList = itemsJson
        .map((item) => BestGoods.fromJson(item as Map<String, dynamic>))
        .toList();

    return goodsList;
  }

  Future<List<Map<String, String>>> getMovieProviders(int movieId) {
    return _service.fetchProviders(movieId);
  }


}
