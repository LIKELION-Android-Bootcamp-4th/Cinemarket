import 'dart:convert';

import 'package:cinemarket/core/model/list_response.dart';
import 'package:cinemarket/core/network/api_client.dart';
import 'package:cinemarket/features/mypage/model/order/order.dart';
import 'package:cinemarket/features/mypage/model/orderdetail/order_detail.dart';
import 'package:logger/logger.dart';

class OrderService {
  final _dio = ApiClient.dio;

  final logger = Logger();
  Future<ListResponse<Order>> fetchMyOrders({
    int page = 1,
    int limit = 5,
    String? status,
    String? startDate,
    String? endDate,
    String sort = 'createdAt',
    String order = 'desc',
  }) async {
    try {
      final response = await _dio.get('/api/mypage/orders', queryParameters: {
        'page': page,
        'limit': limit,
        if (status != null) 'status': status,
        if (startDate != null) 'startDate': startDate,
        if (endDate != null) 'endDate': endDate,
        'sort': sort,
        'order': order,
      });
      // logger.i('응답 데이터: ${const JsonEncoder.withIndent('  ').convert(response.data)}');

      return ListResponse<Order>.fromJson(response.data,(itemJson) => Order.fromJson(itemJson));
    } catch (e) {
      throw Exception('주문 목록을 불러오는 데 실패했습니다: $e');
    }
  }

  Future<OrderDetail> fetchOrderDetail(String orderId) async {
    final response = await _dio.get('/api/mypage/orders/$orderId');

    if (response.statusCode == 200 && response.data['success'] == true) {
      final data = response.data['data'];
      logger.i('응답 데이터: ${const JsonEncoder.withIndent('  ').convert(data)}');

      return OrderDetail.fromJson(data);
    } else {
      throw Exception('주문 상세 조회 실패: ${response.data['message']}');
    }
  }
}
