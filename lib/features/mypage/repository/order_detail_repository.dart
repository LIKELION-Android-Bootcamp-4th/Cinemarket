import 'package:cinemarket/features/mypage/model/orderdetail/order_detail.dart';
import 'package:cinemarket/features/mypage/service/order_service.dart';

class OrderDetailRepository {
  final OrderService _service = OrderService();

  Future<OrderDetail> getOrderDetail(String orderId) async {
    try {
      final response = await _service.fetchOrderDetail(orderId);

      return OrderDetail.fromJson(response.data['data'] as Map<String, dynamic>);
    } catch (e) {
      throw Exception('주문 상세 파싱 실패: $e');
    }
  }

}
