
import 'package:cinemarket/features/home/model/tmdb_movie.dart';
import 'package:cinemarket/features/home/service/tmdb_service.dart';
import 'package:cinemarket/features/movies/service/movies_service.dart';

class BestMovieRepository {
  final TmdbService _tmdbService = TmdbService();

  Future<List<TmdbMovie>> fetchTrendingMovies() async {
    List<TmdbMovie> movies;
    movies = await _tmdbService.fetchTrendingMovies().then((value) => value);
    final futures = movies.map((movie) async {
      final sales = await MoviesService().fetchCumulativeSales(movie.id);
      return movie.copyWithCumulativeSales(sales);
    }).toList();
    return Future.wait(futures);
  }

}