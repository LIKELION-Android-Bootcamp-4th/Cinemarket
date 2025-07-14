import 'package:cinemarket/features/home/model/tmdb_movie.dart';
import 'package:cinemarket/features/movies/service/movies_service.dart';

enum MovieSortType {
  latest, //최신순
  rating, //평점순
  popularity, //인기순 (실제 사용자들이 많이 본 영화 기준)
  reviewCount //대중적 흥행작
}

class MoviesRepository {
  final MoviesService _service = MoviesService();

  Future<List<TmdbMovie>> fetchMovies(MovieSortType sortType,{int page = 1}) async {
    List<TmdbMovie> movies;

    switch (sortType) {
      case MovieSortType.rating:
        movies = await _service.fetchMoviesBySortKey('vote_average.desc',page: page);
        break;
      case MovieSortType.popularity:
        movies = await _service.fetchMoviesBySortKey('popularity.desc', page: page);
        break;
      case MovieSortType.reviewCount:
        movies = await _service.fetchMoviesBySortKey('vote_count.desc', page: page);
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

