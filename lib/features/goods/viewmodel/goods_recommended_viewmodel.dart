import 'package:flutter/material.dart';
import 'package:cinemarket/features/goods/model/goods.dart';
import 'package:cinemarket/features/goods/repository/goods_recommended_repository.dart';

class GoodsRecommendedViewModel extends ChangeNotifier {
  final GoodsRecommendedRepository _repository = GoodsRecommendedRepository();

  List<Goods> _recommendedGoods = [];
  String? _errorMessage;
  bool _isLoading = false;

  List<Goods> get recommendedGoods => _recommendedGoods;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> loadRecommendedGoods(String productId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final contentId = await _repository.getContentIdByProductId(productId);

      if (contentId == null) {
        _errorMessage = '연결된 영화 정보를 찾을 수 없습니다.';
        _recommendedGoods = [];
      } else {
        final goodsList = await _repository.getRecommendedGoods(
          contentId: contentId,
          excludeProductId: productId,
        );

        _recommendedGoods = goodsList;
      }
    } catch (e) {
      _errorMessage = '추천 굿즈 로딩 실패: $e';
      _recommendedGoods = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
