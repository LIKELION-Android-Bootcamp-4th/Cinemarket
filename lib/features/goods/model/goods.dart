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
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      stock: json['stock'] ?? 0,
      status: json['status'] ?? 'unknown',
      favoriteCount: json['favoriteCount'] ?? 0,
      viewCount: json['viewCount'] ?? 0,
      orderCount: json['orderCount'] ?? 0,
      reviewCount: json['reviewCount'] ?? 0,
      createdAt: json['createdAt'] ?? '',
      images: json['images'] != null
          ? GoodsImages.fromJson(json['images'])
          : GoodsImages.empty(),
      reviewStats: json['reviewStats'] != null
          ? ReviewStats.fromJson(json['reviewStats'])
          : null,
      isFavorite: json['isFavorite'] ?? false,
    );
  }


  // 로그용 모델 출력
  @override
  String toString() {
    return 'Goods( id: $id, name: $name, price: $price, isFavorite: $isFavorite,)';
  }
}
