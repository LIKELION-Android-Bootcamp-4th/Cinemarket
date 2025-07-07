import 'package:cinemarket/core/network/tmdb_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SearchTmdbService {
  final Dio _dio = TmdbClient.dio;

  Future<List<SearchMovie>> searchMovies(String query) async {
    final apiKey = dotenv.env['TMDB_API_KEY'] ?? '';
    final response = await _dio.get(
      '/search/movie',
      queryParameters: {
        'api_key' : apiKey,
        'query' : query,
        'language': 'ko-KR',
      }
    );

    final List results = response.data['results'];
    return results.map((e) => SearchMovie.fromJson(e)).toList();
  }
}

class SearchMovie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final double voteAverage;
  final double popularity;

  SearchMovie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.popularity,
  });

  factory SearchMovie.fromJson(Map<String, dynamic> json) {
    return SearchMovie(
      id: json['id'],
      title: json['title'] ?? '',
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] as String? ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      popularity: (json['popularity'] ?? 0).toDouble(),
    );
  }
}