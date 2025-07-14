import 'package:flutter/material.dart';
import 'package:cinemarket/features/mypage/model/order/order.dart';
import 'package:cinemarket/features/mypage/repository/order_status_repository.dart';

class OrderStatusViewModel extends ChangeNotifier {
  final OrderStatusRepository _repository = OrderStatusRepository();

  List<Order> _trackingOrders = [];
  List<Order> get trackingOrders => _trackingOrders;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> loadTrackingOrders() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _trackingOrders = await _repository.fetchTrackingOrders();
    } catch (e) {
      _errorMessage = '배송 조회 실패: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
