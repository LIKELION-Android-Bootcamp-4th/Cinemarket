import 'package:cinemarket/features/home/model/tmdb_movie.dart';
import 'package:cinemarket/features/movies/service/movies_service.dart';

enum MovieSortType { latest, rating }

class MoviesRepository {
  final MoviesService _service = MoviesService();

  Future<List<TmdbMovie>> fetchMovies(MovieSortType sortType) {
    switch (sortType) {
      case MovieSortType.rating:
        return _service.fetchTopRatedMovies();
      case MovieSortType.latest:
      default:
        return _service.fetchNowPlayingMovies();
    }
  }
}

