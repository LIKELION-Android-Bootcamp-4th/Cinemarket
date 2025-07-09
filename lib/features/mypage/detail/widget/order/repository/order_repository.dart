import 'package:cinemarket/features/mypage/detail/widget/order/service/order_service.dart';

class OrderRepository {
  final OrderService _orderService;

  OrderRepository({OrderService? orderService})
    : _orderService = orderService ?? OrderService();

  Future<Map<String, dynamic>> fetchOrders({
    int page = 1,
    int limit = 20,
    String status = 'delivered',
    String startDate = '2025-01-01',
    String endDate = '2025-12-31',
    String sort = 'createdAt',
    String order = 'desc',
  }) async {
    return await _orderService.fetchOrders(
      page: page,
      limit: limit,
      status: status,
      startDate: startDate,
      endDate: endDate,
      sort: sort,
      order: order,
    );
  }
}
