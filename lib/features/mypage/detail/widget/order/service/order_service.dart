import 'package:cinemarket/core/network/api_client.dart';
import 'package:dio/dio.dart';

class OrderService {
  final Dio _dio = ApiClient.dio;

  Future<Map<String, dynamic>> fetchOrders({
    int page = 1,
    int limit = 20,
    String status = 'delivered',
    String startDate = '2025-01-01',
    String endDate = '2025-12-31',
    String sort = 'createdAt',
    String order = 'desc',
  }) async {
    try {
      final response = await _dio.get(
        '/api/mypage/orders',
        queryParameters: {
          'page': page,
          'limit': limit,
          'status': status,
          'startDate': startDate,
          'endDate': endDate,
          'sort': sort,
          'order': order,
        },
      );
      print(response.data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
