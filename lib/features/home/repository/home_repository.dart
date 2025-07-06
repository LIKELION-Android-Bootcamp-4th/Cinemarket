
import 'package:cinemarket/features/home/model/tmdb_movie.dart';
import 'package:cinemarket/features/home/service/kobis_service.dart';
import 'package:cinemarket/features/home/service/tmdb_service.dart';

class HomeRepository {
  final KobisService _kobisService = KobisService();
  final TmdbService _tmdbService = TmdbService();

  Future<List<TmdbMovie>> fetchBoxOfficeWithTmdbDetails(String date) async {
    final boxOfficeList = await _kobisService.fetchDailyBoxOffice(date);
    List<TmdbMovie> tmdbMovies = [];

    for (var boxOfficeMovie in boxOfficeList) {
      try {
        final tmdbMovie = await _tmdbService.searchMovieByTitle(boxOfficeMovie.movieNm);
        if (tmdbMovie != null) {
          tmdbMovies.add(tmdbMovie);
        }
      } catch (_) {

      }
    }
    return tmdbMovies;
  }
}
