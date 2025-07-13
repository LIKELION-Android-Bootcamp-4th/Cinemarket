import 'package:cinemarket/features/mypage/model/order/order.dart';
import 'package:cinemarket/features/mypage/service/order_status_service.dart';

class OrderStatusRepository {
  final OrderStatusService _service = OrderStatusService();

  static const _trackingStatuses = ['pending', 'preparing', 'shipped'];

  Future<List<Order>> fetchTrackingOrders() async {
    final response = await _service.fetchAllOrders();
    final orders = response.items;

    return orders.where((order) => _trackingStatuses.contains(order.status)).toList();
  }
}
