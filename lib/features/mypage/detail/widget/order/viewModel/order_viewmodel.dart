import 'package:cinemarket/features/mypage/detail/widget/order/repository/order_repository.dart';
import 'package:flutter/material.dart';

class OrderViewModel extends ChangeNotifier {
  final OrderRepository _orderRepository;
  OrderViewModel({OrderRepository? orderRepository})
      : _orderRepository = orderRepository ?? OrderRepository();

  String? _error;
  String? get error => _error;

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
      print(result['data']['items']); // 주문 배열
      notifyListeners();
    } catch (e) {
      _error = "주문 내역 조회 에러";
      print("주문 내역 조회 에러 $e");
    }
  }
}
