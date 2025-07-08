import 'package:cinemarket/core/network/api_client.dart';
import 'package:cinemarket/core/network/tmdb_client.dart';
import 'package:cinemarket/features/search/model/search_goods_model.dart';
import 'package:cinemarket/features/search/model/search_tmdb_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SearchService {
  final Dio _dio = ApiClient.dio;
  final Dio _tmdbDio = TmdbClient.dio;

  //tmdb
  Future<List<SearchTmdbModel>> searchMovies(String query) async {
    try {
      final apiKey = dotenv.env['TMDB_API_KEY'] ?? '';
      final response = await _tmdbDio.get(
        '/search/movie',
        queryParameters: {
          'api_key': apiKey,
          'query': query,
          'language': 'ko-KR',
        },
      );

      final List results = response.data['results'];
      return results.map((e) => SearchTmdbModel.fromJson(e)).toList();
    } catch (e) {
      print('tmdb 검색 오류: $e');
      rethrow;
    }
  }

  //굿즈 직접 검색
  Future<List<SearchItem>> fetchGoodsByKeyword(String keyword) async {
    try {
      final response = await _dio.get(
        '/api/products',
        queryParameters: {
          'search': keyword
        },
      );
      final items = response.data['data']['items'] as List;
      return items.map((e) => SearchItem.fromJson(e)).toList();
    } catch (e) {
      if (e is DioError) {
        print('❌ DioError: ${e.response?.statusCode}');
        print('응답: ${e.response?.data}');
      } else {
        print('❌ Unknown error: $e');
      }
      rethrow;
    }
  }

  //영화 ID로 굿즈 검색
  Future<List<SearchItem>> fetchMovieByContentId(int contentId) async {
    try {
      final response = await _dio.get(
          '/api/content-product/products/$contentId'
      );
      final items = response.data['data']['items'] as List;
      return items.map((e) => SearchItem.fromJson(e)).toList();
    } catch (e) {
      print('❌ 굿즈 검색 오류 (ID): $e');
      rethrow;
    }
  }
}