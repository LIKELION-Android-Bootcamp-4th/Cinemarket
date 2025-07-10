import 'package:cinemarket/core/model/list_response.dart';
import 'package:cinemarket/features/mypage/model/order/order.dart';
import 'package:cinemarket/features/mypage/service/order_service.dart';

class OrderRepository {
  final OrderService _service = OrderService();

  Future<ListResponse<Order>> getOrders() async {
    try {
      final response = await _service.fetchOrders();

      final parsed = ListResponse<Order>.fromJson(
        response.data,
            (json) => Order.fromJson(json as Map<String, dynamic>),
      );

      return parsed;
    } catch (e) {
      throw Exception('주문 목록 파싱 실패: $e');
    }
  }
}
