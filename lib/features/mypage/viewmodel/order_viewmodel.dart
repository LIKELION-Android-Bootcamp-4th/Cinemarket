import 'package:cinemarket/features/mypage/model/order/order.dart';
import 'package:cinemarket/features/mypage/repository/order_repository.dart';
import 'package:flutter/material.dart';
import 'package:cinemarket/core/model/list_response.dart';

class OrderViewModel extends ChangeNotifier {
  final OrderRepository _repository = OrderRepository();

  bool _isLoading = false;
  String? _errorMessage;
  List<Order> _orders = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Order> get orders => _orders;

  Future<void> fetchOrders() async {
    _isLoading = true;
    notifyListeners();

    try {
      final ListResponse<Order> response = await _repository.getOrders();
      _orders = response.items;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
