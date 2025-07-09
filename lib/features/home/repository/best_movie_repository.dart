
import 'package:cinemarket/features/home/model/tmdb_movie.dart';
import 'package:cinemarket/features/home/service/tmdb_service.dart';

class BestMovieRepository {
  final TmdbService _tmdbService = TmdbService();

  Future<List<TmdbMovie>> fetchTrendingMovies() {
    return _tmdbService.fetchTrendingMovies();
  }

}