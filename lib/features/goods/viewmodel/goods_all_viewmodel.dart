import 'package:cinemarket/features/goods/model/goods.dart';
import 'package:cinemarket/features/goods/repository/goods_repository.dart';
import 'package:flutter/material.dart';

class GoodsAllViewModel extends ChangeNotifier {
  final GoodsRepository _goodsRepository;

  List<Goods> goodsList = [];
  bool _isLoaded = false;

  GoodsAllViewModel({GoodsRepository? goodsRepository})
    : _goodsRepository = goodsRepository ?? GoodsRepository();

  bool get isLoaded => _isLoaded;

  Future<void> getAllGoods({
    bool force = false,
    String? sortBy,
    String sortOrder = 'desc',
  }) async {
    if (!force && _isLoaded) return;

    try {
      goodsList = await _goodsRepository.getAllGoodsList(
        sortBy: sortBy,
        sortOrder: sortOrder,
      );
      notifyListeners();
      _isLoaded = true;

      // 로그 출력
      print("😍😍😍");
      goodsList.forEach((goods) {
        print(goods); // 👍👍👍 toString()이 오버라이드되어 있어 보기 좋게 출력됨
      });
    } catch (e, stackTrace) {
      print(e);
      print('$stackTrace');
      print("😂😂😂 err");
      // 에러 처리
    } finally {
      // notifyListeners();
      print("😎😎😎 통과");
    }
  }

  void clearGoods() {
    goodsList.clear();
    _isLoaded = false;
    notifyListeners();
  }

  Future<String> getMovieTitleFromGoodsId({required String goodsId}) {
    return _goodsRepository.tempGetMovieTitleFromGoodsId(goodsId: goodsId); // 서버 api에서 title 제공 시 삭제 예정
    // return _goodsRepository.getMovieTitleFromGoodsId(goodsId: goodsId);
  }
}