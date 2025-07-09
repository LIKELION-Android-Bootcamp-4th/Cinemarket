import 'package:cinemarket/features/goods/model/goods.dart';
import 'package:cinemarket/features/goods/model/pagination.dart';

class GoodsAllResponse {
  final bool success;
  final String message;
  final List<Goods> items;  // data -> items 구조 해체
  final Pagination pagination;

  GoodsAllResponse({
    required this.success,
    required this.message,
    required this.items,
    required this.pagination,
  });

  factory GoodsAllResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return GoodsAllResponse(
      success: json['success'],
      message: json['message'],
      items: List<Goods>.from(
        data['items'].map((item) => Goods.fromJson(item)),
      ),
      pagination: Pagination.fromJson(data['pagination']),
    );
  }
}
