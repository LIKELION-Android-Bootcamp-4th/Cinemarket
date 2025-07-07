import 'package:cinemarket/features/goods/model/goods.dart';
import 'package:cinemarket/features/goods/repository/goods_all_repository.dart';
import 'package:flutter/material.dart';

class GoodsAllViewModel extends ChangeNotifier {
  final GoodsAllRepository _goodsAllRepository;

  List<Goods> goodsList = [];

  GoodsAllViewModel({GoodsAllRepository? goodsAllRepository})
    : _goodsAllRepository = goodsAllRepository ?? GoodsAllRepository();

  Future<void> getAllGoods() async {
    try {
      goodsList = await _goodsAllRepository.getAllGoodsList();
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

}