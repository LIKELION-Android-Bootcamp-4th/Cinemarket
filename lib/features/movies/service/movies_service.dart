import 'package:cinemarket/core/network/tmdb_client.dart';
import 'package:cinemarket/features/home/model/tmdb_movie.dart';
import 'package:cinemarket/features/movies/model/cast_member.dart';
import 'package:cinemarket/features/movies/model/tmdb_movie_detail.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MoviesService {
  final Dio _dio = TmdbClient.dio;
  final String _apiKey = dotenv.env['TMDB_API_KEY'] ?? '';

  //최신순 데이터 통신
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

  //평점순 데이터 통신
  Future<List<TmdbMovie>> fetchTopRatedMovies() async {
    final response = await _dio.get('/discover/movie', queryParameters: {
      'api_key': _apiKey,
      'language': 'ko-KR',
      'region': 'KR',
      'sort_by': 'vote_average.desc',
      'vote_count.gte': 10000, //1000표 이상 받은 인기 영화만 필터링.
      'primary_release_date.gte': '${DateTime.now().year - 10}-01-01',
      'page': 1,
    });
    print(response.data['results']);

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

  //OTT 제공 이미지 통신
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

  //영화 상세 관련 통신
  Future<TmdbMovieDetail> fetchMovieDetail(int movieId) async {
    final response = await _dio.get(
      '/movie/$movieId',
      queryParameters: {
        'api_key': _apiKey,
        'language': 'ko-KR',
      },
    );

    return TmdbMovieDetail.fromJson(response.data);
  }

  //출연진 정보
  Future<List<CastMember>> fetchMovieCredits(int movieId) async {
    final response = await _dio.get(
      '/movie/$movieId/credits',
      queryParameters: {
        'api_key': _apiKey,
        'language': 'ko-KR',
      },
    );

    final castList = response.data['cast'] as List;
    return castList.map((json) => CastMember.fromJson(json)).toList();
  }


}
