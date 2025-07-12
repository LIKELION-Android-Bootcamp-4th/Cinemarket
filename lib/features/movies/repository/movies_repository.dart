import 'package:cinemarket/features/home/model/tmdb_movie.dart';
import 'package:cinemarket/features/movies/service/movies_service.dart';

enum MovieSortType { latest, rating }

class MoviesRepository {
  final MoviesService _service = MoviesService();

  Future<List<TmdbMovie>> fetchMovies(MovieSortType sortType,{int page = 1}) async {
    List<TmdbMovie> movies;

    switch (sortType) {
      case MovieSortType.rating:
        movies = await _service.fetchTopRatedMovies(page: page);
        break;
      case MovieSortType.latest:
      default:
        movies = await _service.fetchNowPlayingMovies(page: page);
        break;
    }

    final futures = movies.map((movie) async {
      final sales = await _service.fetchCumulativeSales(movie.id);
      return movie.copyWithCumulativeSales(sales);
    }).toList();

    return Future.wait(futures);
  }
}

