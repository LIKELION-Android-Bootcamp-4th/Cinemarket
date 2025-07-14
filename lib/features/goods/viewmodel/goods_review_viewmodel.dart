import 'package:cinemarket/features/goods/model/goods_review.dart';
import 'package:cinemarket/features/goods/repository/goods_repository.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class GoodsReviewsViewModel extends ChangeNotifier {
  final GoodsRepository _goodsRepository;

  GoodsReviewsViewModel({GoodsRepository? goodsRepository})
      : _goodsRepository = goodsRepository ?? GoodsRepository();

  List<GoodsReview> _reviews = [];
  List<GoodsReview> get reviews => _reviews;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> getGoodsReviews({required String goodsId}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _reviews = await _goodsRepository.getGoodsReviews(goodsId: goodsId);
      Logger().i("✅ 리뷰 불러오기 성공");
      Logger().i(_reviews[0].comment);
      Logger().i(reviews[0].images.first.url);
    } catch (e, stackTrace) {
      _errorMessage = '리뷰 불러오기 실패: $e';
      Logger().e("❌ 리뷰 불러오기 실패", error: e, stackTrace: stackTrace);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
