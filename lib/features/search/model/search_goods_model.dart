import 'package:cinemarket/features/goods/model/review_stats.dart';

class SearchItem {
  final String id;
  final String name;
  final String description;
  final int price;
  final String mainImage;
  final int stock;
  final String status;
  final int viewCount;
  final int orderCount;
  final int reviewCount;
  final String createdAt;
  final int favoriteCount;
  final ReviewStats? reviewStats;
  final int? tmdbId;
  final bool isFavorite;

  SearchItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.status,
    required this.viewCount,
    required this.orderCount,
    required this.reviewCount,
    required this.createdAt,
    required this.mainImage,
    required this.favoriteCount,
    this.reviewStats,
    this.tmdbId,
    required this.isFavorite,
  });

  factory SearchItem.fromJson(Map<String, dynamic> json) {
    final imageMap = json['images'] ?? {};
    return SearchItem(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      stock: json['stock'] ?? 0,
      status: json['status'] ?? 'unknown',
      favoriteCount: json['favoriteCount'] ?? 0,
      viewCount: json['viewCount'] ?? 0,
      orderCount: json['orderCount'] ?? 0,
      reviewCount: json['reviewCount'] ?? 0,
      mainImage: imageMap['main'] ?? '',
      createdAt: json['createdAt'] ?? '',
      reviewStats: json['reviewStats'] != null
          ? ReviewStats.fromJson(json['reviewStats'])
          : null,
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}