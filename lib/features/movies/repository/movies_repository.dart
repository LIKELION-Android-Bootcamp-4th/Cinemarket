import 'package:cinemarket/features/home/model/tmdb_movie.dart';
import 'package:cinemarket/features/movies/service/movies_service.dart';

enum MovieSortType { latest, rating }

class MoviesRepository {
  final MoviesService _service = MoviesService();

  Future<List<TmdbMovie>> fetchMovies(MovieSortType sortType,{int page = 1}) {
    switch (sortType) {
      case MovieSortType.rating:
        return _service.fetchTopRatedMovies(page: page);
      case MovieSortType.latest:
      default:
        return _service.fetchNowPlayingMovies(page: page);
    }
  }
}

