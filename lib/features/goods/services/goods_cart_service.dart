import 'package:cinemarket/core/network/api_client.dart';
import 'package:dio/dio.dart';

class GoodsCartService {
  final Dio dio = ApiClient.dio;

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

    if ((response.statusCode != 200 && response.statusCode != 201) || response.data['success'] != true) {
      print('[장바구니 추가 실패 응답] statusCode: ${response.statusCode}, body: ${response.data}');
      throw Exception('장바구니 추가 실패');
    } else {
      print('[장바구니 추가 성공] statusCode: ${response.statusCode}, body: ${response.data}');
    }
  }
}