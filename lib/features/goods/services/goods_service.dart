import 'package:cinemarket/core/network/api_client.dart';
import 'package:cinemarket/features/goods/model/goods_all_response.dart';
import 'package:cinemarket/features/goods/model/goods_detail_response.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class GoodsService {
  final Dio _dio = ApiClient.dio;

  Future<GoodsAllResponse> getAllGoods({
    int page = 1,
    int limit = 20,
    String? categoryId,
    String? category,
    String? search,
    String? sortBy,
    String sortOrder = 'desc',
  }) async {
    try {
      final response = await _dio.get(
        '/api/products',
        queryParameters: {
          'page': page,
          'limit': limit,
          if (categoryId != null) 'categoryId': categoryId,
          if (category != null) 'category': category,
          if (search != null) 'search': search,
          if (sortBy != null) 'sortBy': sortBy,
          'sortOrder': sortOrder,
        },
      );

      return GoodsAllResponse.fromJson(response.data);
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? e.message;
      throw Exception('상품 조회 실패: $message');
    }
  }

  Future<GoodsDetailResponse> getDetailGoods({required String? goodsId}) async {
    try {
      final respones = await _dio.get(
        '/api/products/$goodsId',
      );

      return GoodsDetailResponse.fromJson(respones.data);
    } on DioException catch (e, stackTrace) {
      final message = e.response?.data['message'] ?? e.message;

      Error.throwWithStackTrace(Exception('상품상세 조회 실패: $message'), stackTrace);
    }
  }

  Future<Response> getGoodsReviews({required String? goodsId}) async {
    try {
      return await _dio.get('/api/products/$goodsId/reviews');
    } on DioException catch (e) {
      Logger().e(e.message);
      Logger().e(e.stackTrace);

      rethrow;
    }
  }
  
  Future<Response> getMovieTitleFromGoodsId({required String goodsId}) async {
    try {
      return await _dio.get('/api/content-product/contents/$goodsId');
    } on DioException catch (e) {
      Logger().e(e.message);
      Logger().e(e.stackTrace);

      rethrow;
    }
  } 
}
