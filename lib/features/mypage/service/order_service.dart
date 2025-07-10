import 'package:cinemarket/core/network/api_client.dart';
import 'package:dio/dio.dart';

class OrderService {
  final _dio = ApiClient.dio;

  Future<Response> fetchOrders() async {
    try {
      final response = await _dio.get('/api/orders');
      return response;
    } catch (e) {
      throw Exception('주문 목록 조회 실패: $e');
    }
  }
}
