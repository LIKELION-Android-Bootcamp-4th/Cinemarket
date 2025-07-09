import 'package:cinemarket/features/goods/model/goods.dart';
import 'package:cinemarket/features/goods/repository/goods_repository.dart';
import 'package:flutter/material.dart';

class GoodsDetailViewmodel extends ChangeNotifier {

  GoodsDetailViewmodel({GoodsRepository? goodsRepository})
      : _goodsRepository = goodsRepository ?? GoodsRepository();
  final GoodsRepository _goodsRepository;

  Goods? _goods;
  Goods get goods => _goods!;

  Future<Goods> getDetailGoods({required String goodsId,}) async {
    try {
      _goods = await _goodsRepository.getDetailGoods(goodsId: goodsId);
      notifyListeners();

      // 로그 출력
      print('😍😍😍');
      print(goods);// 👍👍👍 toString()이 오버라이드되어 있어 보기 좋게 출력됨
    } catch (e, stackTrace) {

      print("😂😂😂 err");
      print(e);
      print('$stackTrace');
      // 에러 처리
    } finally {
      print("😎😎😎 통과");
    }

    return _goods!;
  }

}