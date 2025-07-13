import 'package:cinemarket/core/network/api_client.dart';
import 'package:dio/dio.dart';

class PurchaseService {
  final Dio _dio = ApiClient.dio;

  Future<void> checkoutCart({
    required List<String> cartIds,
    required String recipient,
    required String address,
    required String phone,
    required String zipCode,
    String memo = '',
  }) async {
    try {
      final body = {
        "shippingInfo": {
          "recipient": recipient,
          "address": address,
          "phone": phone,
          "zipCode": zipCode,
        },
        "memo": memo,
        "cartIds": cartIds,
      };

      final response = await _dio.post('/api/cart/checkout', data: body);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('주문 생성 실패: ${response.statusCode}');
      }

      print('[주문 생성 성공] ${response.data}');
    } catch (e) {
      print('[주문 생성 실패] $e');
      rethrow;
    }
  }
}