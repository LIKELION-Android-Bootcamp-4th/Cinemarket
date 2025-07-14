
import 'package:cinemarket/features/home/model/best_goods.dart';
import 'package:cinemarket/features/home/repository/best_goods_repository.dart';
import 'package:flutter/material.dart';

class BestGoodsViewModel extends ChangeNotifier {
  final BestGoodsRepository _repository = BestGoodsRepository();

  List<BestGoods> _goodsList = [];
  bool _isLoading = false;
  String? _errorMessage;
  bool? _success;
  String? _message;

  List<BestGoods> get goodsList => _goodsList;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool? get success => _success;
  String? get message => _message;


  Future<void> loadBestGoods({bool force = false}) async {
    if (!force && goodsList.isNotEmpty) return;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final listResponse = await _repository.fetchBestGoods();
      _success = listResponse.success;
      _message = listResponse.message;

      if (_success == true) {
        _goodsList = listResponse.items;
      } else {
        _goodsList = [];
        _errorMessage = listResponse.message;
      }
    } catch (e) {
      _errorMessage = '상품 불러오기 실패: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
