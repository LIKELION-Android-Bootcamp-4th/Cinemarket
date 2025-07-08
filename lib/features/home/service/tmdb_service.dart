import 'package:cinemarket/features/home/model/tmdb_movie.dart';
import 'package:dio/dio.dart';
import 'package:cinemarket/core/network/tmdb_client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TmdbService {
  final Dio _dio = TmdbClient.dio;
  final _apiKey = dotenv.env['TMDB_API_KEY'] ?? '';


  Future<TmdbMovie?> searchMovieByTitle(String title) async {
    try {
      final response = await _dio.get('/search/movie', queryParameters: {
        'api_key': _apiKey,
        'query': title,
        'language': 'ko-KR',
        'page': 1,
        'include_adult': false,
      });


      final results = response.data['results'] as List<dynamic>?;
      if (results == null || results.isEmpty) return null;

      final today = DateTime.now();

      // 미래 데이터 제외
      final filtered = results.where((movie) {
        final releaseDateStr = movie['release_date'] ?? '';
        if (releaseDateStr.isEmpty) return false;
        final releaseDate = DateTime.tryParse(releaseDateStr);
        if (releaseDate == null) return false;
        return !releaseDate.isAfter(today);
      }).toList();

      if (filtered.isEmpty) return null;

      //개봉 일자로 데이터 가져오기 위한 정렬
      filtered.sort((a, b) {
        final dateA = DateTime.parse(a['release_date']);
        final dateB = DateTime.parse(b['release_date']);
        return dateB.compareTo(dateA);
      });

      final movieJson = filtered.first as Map<String, dynamic>;
      return TmdbMovie.fromJson(movieJson);

    } catch (e) {
      rethrow;
    }
  }

  Future<List<TmdbMovie>> fetchTrendingMovies({String timeWindow = 'week'}) async {
    final response = await _dio.get('/trending/movie/$timeWindow', queryParameters: {
      'api_key': _apiKey,
      'language': 'ko-KR',
    });

    final movies = _mapResults(response.data['results']);

    return Future.wait(
      movies.map((movie) async {
        final providers = await fetchProviders(movie.id);
        return movie.copyWithProviders(providers);
      }),
    );
  }

  List<TmdbMovie> _mapResults(List<dynamic>? results) {
    if (results == null) return [];
    return results
        .map((json) => TmdbMovie.fromJson(json))
        .where((movie) => movie.posterPath.isNotEmpty)
        .toList();
  }

  Future<List<Map<String,String>>> fetchProviders(int movieId) async {
    final response = await _dio.get(
      '/movie/$movieId/watch/providers',
      queryParameters: {
        'api_key': _apiKey,
      },
    );
    final results = response.data['results'];
    final krData = results?['KR'];
    if (krData == null || krData['flatrate'] == null) return [];
    return (krData['flatrate'] as List)
        .where((item) => item['logo_path'] != null && item['provider_name'] != null)
        .map<Map<String, String>>((item) => {
      'providerName': item['provider_name'] as String,
      'logoUrl': 'https://image.tmdb.org/t/p/w500${item['logo_path']}',
    })
        .toList();
  }
}
