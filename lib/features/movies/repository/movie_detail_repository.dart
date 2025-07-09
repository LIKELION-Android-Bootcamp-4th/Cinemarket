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
}
