import 'package:cinemarket/core/network/api_client.dart';
import 'package:cinemarket/features/favorite/model/favorite_item.dart';
import 'package:dio/dio.dart';

class FavoriteService {
  final Dio _dio = ApiClient.dio;

  Future<List<FavoriteItem>> getAllFavoriteItems({
    int page = 1,
    int limit = 20,
    String sort = 'createdAt',
    String order = 'desc'
  }) async {
    try {
      final response = await _dio.get(
        '/api/mypage/favorites',
        queryParameters: {
          'page': page,
          'limit': limit,
          'sort': sort,
          'order': order,
        },
      );

      final items = response.data['data']['items'] as List;  // response.data에서 success, message를 제외하고 items만 가져오기


      return items.map((e) => FavoriteItem.fromJson(e)).toList();


    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? e.message;
      throw('찜 목록 조회 실패: $message');
    }
  }

  Future<bool> toggleFavorite({
    required String goodsId,
  }) async {
    try {
      final response = await _dio.post(
          '/api/products/$goodsId/toggle-favorites'
      );

      return response.data['success'] == true;  // bool? 고려

    } on DioException catch (e) {
      return false;
    }
  }

  Future<bool> toggleMovieFavorite({
    required String contentProductId,
  }) async {
    try {
      final response = await _dio.post(
        '/api/content-product/$contentProductId/like-toggle',
      );

      return response.data['success'] == true;

    } on DioException catch (e) {

      return false;
    }
  }

  /**
   * 이제 찜한 콘텐츠 목록 조회   통신
   * 받는 건 List<id> -> id == tmdb ID
   *   이 id로 tmdb 상세 통신하여 -> 포스터, 타이틀 받아내기
   *   라우터로 이동 <- movie_item에서 이미 처리 완료
   */
  Future<Response> getAllFavoriteMovies({
    int page = 1,
    int limit = 20,
}) async {
    try {
      return  await _dio.get(
        '/api/mypage/contents',
          queryParameters: {
            'page': page,
            'limit': limit,
          },
      );

    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? e.message;
      throw('😢😢😢 영화 찜 목록 조회 실패: $message');
    }
  }
}