import 'package:cinemarket/features/goods/model/goods.dart';
import 'package:cinemarket/features/goods/repository/goods_repository.dart';
import 'package:flutter/material.dart';

class GoodsAllViewModel extends ChangeNotifier {
  final GoodsRepository _goodsRepository;

  List<Goods> goodsList = [];

  GoodsAllViewModel({GoodsRepository? goodsRepository})
    : _goodsRepository = goodsRepository ?? GoodsRepository();

  Future<void> getAllGoods({bool force = false}) async {
    if (!force && goodsList.isNotEmpty) return;

    try {
      goodsList = await _goodsRepository.getAllGoodsList();
      notifyListeners();

      // 로그 출력
      print("😍😍😍");
      goodsList.forEach((goods) {
        print(goods);  // 👍👍👍 toString()이 오버라이드되어 있어 보기 좋게 출력됨
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
    notifyListeners();
  }

}