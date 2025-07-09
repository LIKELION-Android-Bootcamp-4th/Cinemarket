import 'package:cinemarket/core/model/list_response.dart';
import 'package:cinemarket/features/home/model/best_goods.dart';
import 'package:cinemarket/features/home/service/best_goods_service.dart';

class BestGoodsRepository {
  final BestGoodsService _service = BestGoodsService();

  Future<ListResponse<BestGoods>> fetchBestGoods() async {
    final response = await _service.fetchBestGoods();
    print('[RESPONSE ITEMS]');
    // for (var item in response.data) {
    //   print(item['pagination']);
    // }
    for (var item in response.data['data']['items']) {
      print(item);
    }

    print('[STATUS CODE] ${response.statusCode}');
    final listResponse = ListResponse<BestGoods>.fromJson(
      response.data,
          (json) => BestGoods.fromJson(json),
    );
    return listResponse;
  }
}