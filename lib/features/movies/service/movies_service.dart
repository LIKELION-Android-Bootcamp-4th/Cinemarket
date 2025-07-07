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

    return _mapResults(response.data['results']);
  }

  Future<List<TmdbMovie>> fetchTopRatedMovies() async {
    final response = await _dio.get('/movie/top_rated', queryParameters: {
      'api_key': _apiKey,
      'language': 'ko-KR',
      'region': 'KR',
      'page': 1,
    });

    return _mapResults(response.data['results']);
  }

  List<TmdbMovie> _mapResults(List<dynamic>? results) {
    if (results == null) return [];
    return results
        .map((json) => TmdbMovie.fromJson(json))
        .where((movie) => movie.posterPath.isNotEmpty)
        .toList();
  }
}
