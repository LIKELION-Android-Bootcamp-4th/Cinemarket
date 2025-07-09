import 'package:cinemarket/features/mypage/detail/widget/order/repository/order_repository.dart';
import 'package:flutter/material.dart';
import 'package:cinemarket/features/mypage/detail/widget/order/order_history_widget.dart';

class OrderViewModel extends ChangeNotifier {
  final OrderRepository _orderRepository;
  OrderViewModel({OrderRepository? orderRepository})
      : _orderRepository = orderRepository ?? OrderRepository();

  String? _error;
  String? get error => _error;

  List<OrderItem> _orders = [];
  List<OrderItem> get orders => _orders;

  List<OrderItem> parseOrderItems(List<dynamic> items) {
    return items.map((order) {
      final firstProduct = order['items'][0];
      final product = firstProduct['productId'];
      return OrderItem(
        date: order['createdAt']?.substring(0, 10),
        status: order['statusText'] ?? '',
        productName: product['name'] ?? '',
        movieTitle: '더미데이터',
        productImage: product['imageUrl'],
        quantity: '${firstProduct['quantity']}개',
        price: '${order['finalAmount']}원',
        reviewStatus: order['canReview'] == true ? '리뷰쓰기' : '리뷰완료',
      );
    }).toList();
  }

  Future<void> fetchOrders({
    int page = 1,
    int limit = 20,
    String status = 'delivered',
    String startDate = '2025-01-01',
    String endDate = '2025-12-31',
    String sort = 'createdAt',
    String order = 'desc',
  }) async {
    try {
      final result = await _orderRepository.fetchOrders(
        page: page,
        limit: limit,
        status: status,
        startDate: startDate,
        endDate: endDate,
        sort: sort,
        order: order,
      );
      final items = result['data']['items'] as List<dynamic>;
      _orders = parseOrderItems(items);
    } catch (e) {
      _error = "주문 내역 조회 에러 : $e";
    }
  }
}
