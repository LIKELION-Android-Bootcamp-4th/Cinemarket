import 'package:cinemarket/features/goods/model/goods_images.dart';
import 'package:cinemarket/features/goods/model/review_stats.dart';

class Goods {
  final String id;
  final String name;
  final String description;
  final int price;
  final int stock;
  final String status;
  final int favoriteCount;
  final int viewCount;
  final int orderCount;
  final int reviewCount;
  final String createdAt;
  final GoodsImages images;
  final ReviewStats? reviewStats;
  final bool isFavorite;

  Goods({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.status,
    required this.favoriteCount,
    required this.viewCount,
    required this.orderCount,
    required this.reviewCount,
    required this.createdAt,
    required this.images,
    this.reviewStats,
    required this.isFavorite,
  });

  factory Goods.fromJson(Map<String, dynamic> json) {
    return Goods(
      id: json['id'],
      name: json['name'],
      description: json['description'],  // todo: 기본값 처리 필요
      price: json['price'],
      stock: json['stock'],
      status: json['status'],
      favoriteCount: json['favoriteCount'],
      viewCount: json['viewCount'],
      orderCount: json['orderCount'],
      reviewCount: json['reviewCount'],
      createdAt: json['createdAt'],
      images: GoodsImages.fromJson(json['images']),  // todo: 기본값 처리 필요
      reviewStats: json['reviewStats'] != null
      ? ReviewStats.fromJson(json['reviewStats'])
      : null,
      isFavorite: json['isFavorite'],
    );
  }

  // 로그용 모델 출력
  @override
  String toString() {
    return 'Goods( id: $id, name: $name, price: $price, isFavorite: $isFavorite,)';
  }
}
