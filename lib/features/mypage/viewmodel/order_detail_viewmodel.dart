import 'package:cinemarket/features/mypage/model/orderdetail/order_detail.dart';
import 'package:cinemarket/features/mypage/repository/order_detail_repository.dart';
import 'package:flutter/material.dart';

class OrderDetailViewModel extends ChangeNotifier {
  final OrderDetailRepository _repository = OrderDetailRepository();

  OrderDetail? _orderDetail;
  bool _isLoading = false;
  String? _errorMessage;

  OrderDetail? get orderDetail => _orderDetail;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchOrderDetail(String orderId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _orderDetail = await _repository.fetchOrderDetail(orderId);
    } catch (e) {
      _errorMessage = '주문 상세 조회 실패: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
