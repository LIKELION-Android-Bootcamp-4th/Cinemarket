class OrderItemProduct {
  final String id;
  final String name;
  final String? thumbnailImage;

  OrderItemProduct({
    required this.id,
    required this.name,
    this.thumbnailImage,
  });

  factory OrderItemProduct.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return OrderItemProduct(id: '', name: '', thumbnailImage: null);
    }
    return OrderItemProduct(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      thumbnailImage: json['thumbnailImage'],
    );
  }
}