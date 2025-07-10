import 'package:cinemarket/features/mypage/model/orderdetail/order_detail.dart';
import 'package:cinemarket/features/mypage/repository/order_detail_repository.dart';
import 'package:flutter/material.dart';

class OrderDetailViewModel extends ChangeNotifier{
  final OrderDetailRepository _repository = OrderDetailRepository();

  bool _isLoading = false;
  String? _errorMessage;
  OrderDetail? _orderDetail;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  OrderDetail? get orderDetail => _orderDetail;



  Future<void> fetchOrderDetail(String orderId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final detail = await _repository.getOrderDetail(orderId);
      _orderDetail = detail;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
      _orderDetail = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}