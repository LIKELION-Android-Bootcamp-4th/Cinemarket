import 'package:cinemarket/features/goods/model/goods.dart';
import 'package:cinemarket/features/goods/repository/goods_repository.dart';
import 'package:flutter/material.dart';

class GoodsDetailViewmodel extends ChangeNotifier {

  GoodsDetailViewmodel({GoodsRepository? goodsRepository})
      : _goodsRepository = goodsRepository ?? GoodsRepository();
  final GoodsRepository _goodsRepository;

  Goods? _goods;
  Goods? get goods => _goods;

  Future<Goods> getDetailGoods({required String goodsId,}) async {
    try {
      _goods = await _goodsRepository.getDetailGoods(goodsId: goodsId);
      notifyListeners();

    } catch (e, stackTrace) {

    } finally {

    }

    return _goods!;
  }

}