class ReviewProduct {
  final String id;
  final String name;
  final String mainImageUrl;

  ReviewProduct({
    required this.id,
    required this.name,
    required this.mainImageUrl,
  });

  factory ReviewProduct.fromJson(Map<String, dynamic> json) {
    return ReviewProduct(
      id: json['id'] as String,
      name: json['name'] as String,
      mainImageUrl: json['images']?['main'] ?? '',
    );
  }
}
