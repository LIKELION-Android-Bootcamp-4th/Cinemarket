import 'package:cinemarket/core/network/api_client.dart';
import 'package:cinemarket/core/model/list_response.dart';
import 'package:cinemarket/features/mypage/model/order/order.dart';

class OrderStatusService {
  final _dio = ApiClient.dio;

  Future<ListResponse<Order>> fetchAllOrders({
    int page = 1,
    int limit = 100,
    String sort = 'createdAt',
    String order = 'desc',
  }) async {
    final response = await _dio.get('/api/mypage/orders', queryParameters: {
      'page': page,
      'limit': limit,
      'sort': sort,
      'order': order
    });

    return ListResponse<Order>.fromJson(
      response.data,
          (itemJson) => Order.fromJson(itemJson),
    );
  }
}
