import 'package:cinemarket/features/goods/model/goods.dart';

class GoodsDetailResponse {
  final bool success;
  final String message;
  final Goods data;

  GoodsDetailResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GoodsDetailResponse.fromJson(Map<String, dynamic> json) {

    return GoodsDetailResponse(
      success: json['success'],
      message: json['message'],
      data: Goods.fromJson(json['data']),
    );
  }
}
