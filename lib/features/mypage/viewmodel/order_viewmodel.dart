import 'package:flutter/material.dart';
import 'package:cinemarket/core/model/list_response.dart';
import 'package:cinemarket/features/mypage/model/order/order.dart';
import 'package:cinemarket/features/mypage/repository/order_repository.dart';

class OrderViewModel extends ChangeNotifier {
  final OrderRepository _repository = OrderRepository();

  List<Order> _orders = [];
  List<Order> get orders => _orders;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int _currentPage = 1;
  int get currentPage => _currentPage;

  int _totalPages = 1;
  bool get hasNext => _currentPage < _totalPages;

  Future<void> fetchOrders({
    int page = 1,
    int limit = 5,
    String? status,
    String? startDate,
    String? endDate,
    String sort = 'createdAt',
    String order = 'desc',
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _repository.fetchMyOrders(
        page: page,
        limit: limit,
        status: status,
        startDate: startDate,
        endDate: endDate,
        sort: sort,
        order: order,
      );

      _orders = response.items;
      _currentPage = response.pagination.page;
      _totalPages = response.pagination.totalPages;

    } catch (e) {
      _errorMessage = '주문 목록 불러오기 실패: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 페이징
  Future<void> fetchNextPage() async {
    if (!hasNext || _isLoading) return;
    await fetchOrders(page: _currentPage + 1);
  }
}
