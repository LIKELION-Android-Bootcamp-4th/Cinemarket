import 'package:cinemarket/core/network/api_client.dart';

class GoodsCartService {
  Future<void> addToCart({
    required String productId,
    required int quantity,
    required int unitPrice,
  }) async {
    final dio = ApiClient.dio;
    final response = await dio.post('/api/cart', data: {
      'productId': productId,
      'quantity': quantity,
      'unitPrice': unitPrice,
    });

    if (response.statusCode != 200 || response.data['success'] != true) {
      throw Exception('장바구니 추가 실패');
    }
  }
}