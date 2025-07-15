import 'package:cinemarket/features/goods/model/goods.dart';
import 'package:cinemarket/features/goods/repository/goods_repository.dart';
import 'package:flutter/material.dart';

class GoodsAllViewModel extends ChangeNotifier {
  final GoodsRepository _goodsRepository;

  List<Goods> goodsList = [];
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isLoading = false;


  GoodsAllViewModel({GoodsRepository? goodsRepository})
    : _goodsRepository = goodsRepository ?? GoodsRepository();

  bool get hasMore => _hasMore;
  bool get isLoading => _isLoading;

  Future<void> getAllGoods({
    bool force = false,
    String? sortBy,
    String sortOrder = 'desc',
  }) async {
    if (!force && (_isLoading || !_hasMore)) return;

    if (force) {
      clearGoods();
    }

    if (_isLoading || !_hasMore) {
      return;
    }
    _isLoading = true;
    notifyListeners();

    debugPrint('page👊👊👊: $_currentPage');
    debugPrint('sortBy👊👊👊: $sortBy');
    debugPrint('sortOrder👊👊👊: $sortOrder');


    try {
      final result = await _goodsRepository.getAllGoodsList(
        page: _currentPage,
        sortBy: sortBy,
        sortOrder: sortOrder,
      );

      debugPrint("굿즈 전체 조회 result $result");


      if (result.isEmpty) {
        _hasMore = false;
      } else {
        goodsList.addAll(result);
        _currentPage++;
      }

    } catch (e, stackTrace) {
      print("굿즈 전체 조회 err 😂😂😂 ");
      print(e);
      print('$stackTrace');

    } finally {
      debugPrint('goodsList length 👊👊👊: ${goodsList.length}');

      _isLoading = false;
      notifyListeners();
    }
  }

  void clearGoods() {
    _currentPage = 1;
    goodsList.clear();
    _hasMore = true;

    notifyListeners();
  }

  Future<String> getMovieTitleFromGoodsId({required String goodsId}) {
    return _goodsRepository.tempGetMovieTitleFromGoodsId(goodsId: goodsId); // 서버 api에서 title 제공 시 삭제 예정
    // return _goodsRepository.getMovieTitleFromGoodsId(goodsId: goodsId);
  }
}