import 'package:cinemarket/core/network/tmdb_client.dart';
import 'package:cinemarket/features/home/model/tmdb_movie.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MoviesService {
  final Dio _dio = TmdbClient.dio;
  final String _apiKey = dotenv.env['TMDB_API_KEY'] ?? '';

  Future<List<TmdbMovie>> fetchNowPlayingMovies() async {
    final response = await _dio.get('/movie/now_playing', queryParameters: {
      'api_key': _apiKey,
      'language': 'ko-KR',
      'region': 'KR',
      'page': 1,
    });

    final movies = _mapResults(response.data['results']);

    return Future.wait(
      movies.map((movie) async {
        final providers = await fetchProviders(movie.id);
        return movie.copyWithProviders(providers);
      }),
    );
  }

  Future<List<TmdbMovie>> fetchTopRatedMovies() async {
    final response = await _dio.get('/movie/top_rated', queryParameters: {
      'api_key': _apiKey,
      'language': 'ko-KR',
      'region': 'KR',
      'page': 1,
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
