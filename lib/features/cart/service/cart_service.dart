import 'package:cinemarket/core/network/api_client.dart';
import 'package:cinemarket/features/cart/model/cart_item_model.dart';
import 'package:dio/dio.dart';

class CartService {
  final Dio _dio = ApiClient.dio;

  Future<List<CartItemModel>> fetchCartItems() async {
    try {
      final response = await _dio.get('/api/cart');

      if (response.statusCode == 200) {
        final data = response.data;
        final List items = data is Map && data['data'] != null
            ? data['data']['items'] ?? []
            : data;

        print('[장바구니 응답 원본]: $items');

        final parsedItems = items
            .map((e) => CartItemModel.fromJson(e))
            .toList();

        for (final item in parsedItems) {
          print('[파싱된 모델] name: ${item.name}, price: ${item
              .price}, quantity: ${item.quantity}');
        }

        return parsedItems;
      } else {
        throw Exception('장바구니 조회 실패: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('장바구니 조회 중 오류 발생: $e');
    }
  }

  Future<void> addItemToCart({
    required String productId,
    required int quantity,
    required int unitPrice,
    Map<String, dynamic>? options,
    Map<String, dynamic>? discount,
  }) async {
    try {
      final body = {
        'productId': productId,
        'quantity': quantity,
        'unitPrice': unitPrice,
        if (options != null) 'options': options,
        if (discount != null) 'discount': discount,
      };

      final response = await _dio.post(
          '/api/cart', data: body
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('장바구니 추가 실패: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('장바구니 추가 중 오류: $e');
    }
  }

  Future<void> removeItemsFromCart(List<String> cartIds) async {
    try {
      final response = await _dio.delete(
        '/api/cart',
        data: {'cartIds': cartIds},
      );
      print('[삭제 성공] $response');
    } catch (e) {
      print('[삭제 실패] $e');
      rethrow;
    }
  }

  Future<void> checkoutCart(List<String> cartIds) async {
    try {
      final body = {'cartIds': cartIds};
      final response = await _dio.post('/api/cart/checkout', data: body);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('주문 생성 실패: ${response.statusCode}');
      }
      print('[주문 생성 성공] $response');
    } catch (e) {
      print('[주문 생성 실패] $e');
      rethrow;
    }
  }
}