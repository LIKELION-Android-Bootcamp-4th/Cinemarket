import 'package:cinemarket/features/goods/model/goods_images.dart';
import 'package:cinemarket/features/goods/model/review_stats.dart';

class BestGoods {
  final String id;
  final String name;
  final GoodsImages images;
  final int price;
  final ReviewStats reviewStats;
  final int reviewCount;
  final int viewCount;
  final bool isFavorite;
  final int stock;


  BestGoods({
    required this.id,
    required this.name,
    required this.images,
    required this.price,
    required this.reviewStats,
    required this.reviewCount,
    required this.isFavorite,
    required this.viewCount,
    required this.stock
  });

  factory BestGoods.fromJson(Map<String, dynamic> json) {
    print('Parsing item: $json');
    return BestGoods(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      images: GoodsImages.fromJson(json['images'] ?? {}),
      price: json['price'] is int ? json['price'] : int.tryParse('${json['price']}') ?? 0,
      reviewStats: ReviewStats.fromJson(json['reviewStats'] ?? {'averageRating': 0.0}),
      reviewCount: json['reviewCount'] is int ? json['reviewCount'] : int.tryParse('${json['reviewCount']}') ?? 0,
      isFavorite: json['isFavorite'] ?? false,
      viewCount: json['viewCount'] ?? 0,
      stock: json['stock'] is int ? json['stock'] : int.tryParse('${json['stock']}') ?? 0,
    );
  }




}
