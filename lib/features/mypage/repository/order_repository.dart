import 'package:cinemarket/core/model/list_response.dart';
import 'package:cinemarket/features/mypage/model/order/order.dart';
import 'package:cinemarket/features/mypage/service/order_service.dart';

class OrderRepository {
  final OrderService _service = OrderService();

  Future<ListResponse<Order>> fetchMyOrders({
    int page = 1,
    int limit = 5,
    String? status,
    String? startDate,
    String? endDate,
    String sort = 'createdAt',
    String order = 'desc',
  }) {
    return _service.fetchMyOrders(
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
