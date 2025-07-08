import 'package:cinemarket/features/goods/model/goods.dart';
import 'package:cinemarket/features/goods/model/pagination.dart';

class GoodsResponse {
  final bool success;
  final String message;
  final List<Goods> items;  // data -> items 구조 해체
  final Pagination pagination;

  GoodsResponse({
    required this.success,
    required this.message,
    required this.items,
    required this.pagination,
  });

  factory GoodsResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return GoodsResponse(
      success: json['success'],
      message: json['message'],
      items: List<Goods>.from(
        data['items'].map((item) => Goods.fromJson(item)),
      ),
      pagination: Pagination.fromJson(data['pagination']),
    );
  }
}
