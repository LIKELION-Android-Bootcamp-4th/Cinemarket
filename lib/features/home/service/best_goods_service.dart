import 'package:cinemarket/core/network/api_client.dart';
import 'package:dio/dio.dart';

class BestGoodsService {
  final Dio _dio = ApiClient.dio;

  Future<Response> fetchBestGoods({
    int page = 1,
    int limit = 10,
    String sortBy = 'sales',
    String sortOrder = 'asc',
  }) {
    return _dio.get('/api/products', queryParameters: {
      'page': page,
      'limit': limit,
      'sortBy': sortBy,
      'sortOrder': sortOrder,
    });
  }
}
