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

  Future<Response> fetchOrderDetail(String orderId) async {
    try {
      final response = await _dio.get('/api/orders/$orderId');
      return response;
    } catch (e) {
      throw Exception('주문 상세 조회 실패: $e');
    }
  }
}
