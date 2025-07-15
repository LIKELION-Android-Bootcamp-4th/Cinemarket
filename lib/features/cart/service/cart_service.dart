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

    } catch (e) {

      rethrow;
    }
  }


  Future<int> fetchCartCount() async {
    try {
      final response = await _dio.get('/api/cart/count');
      final data = response.data;

      if (data is Map && data['data'] is int) {
        return data['data'];
      } else {
        throw Exception('잘못된 장바구니 수량 응답: $data');
      }
    } catch (e) {
      throw Exception('장바구니 개수 조회 오류: $e');
    }
  }

  Future<void> updateCartItemQuantity({
    required String cartId,
    required int quantity,
  }) async {
    try {
      final response = await _dio.patch(
        '/api/cart/$cartId',
        data: {'quantity': quantity},
      );

      if (response.statusCode != 200) {
        throw Exception('수량 수정 실패: ${response.statusCode}');
      }


    } catch (e) {

      rethrow;
    }
  }
}