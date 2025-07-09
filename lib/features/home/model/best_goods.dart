import 'package:cinemarket/features/goods/model/goods_images.dart';
import 'package:cinemarket/features/goods/model/review_stats.dart';

class BestGoods {
  final String id;
  final String name;
  // final String movieName;
  final GoodsImages images;
  final int price;
  final ReviewStats reviewStats;
  final int reviewCount;
  final bool isFavorite;

  BestGoods({
    required this.id,
    required this.name,
    // required this.movieName,
    required this.images,
    required this.price,
    required this.reviewStats,
    required this.reviewCount,
    required this.isFavorite,
  });

  factory BestGoods.fromJson(Map<String, dynamic> json) {
    return BestGoods(
      id: json['id'],
      name: json['name'],
      // movieName: json['movieName'] ?? '',
      images: GoodsImages.fromJson(json['images']),
      price: json['price'] ?? 0,
      reviewStats: ReviewStats.fromJson(json['reviewStats']),
      reviewCount: json['reviewCount'] ?? 0,
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}
