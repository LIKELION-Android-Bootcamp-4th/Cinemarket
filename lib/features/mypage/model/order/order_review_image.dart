class OrderReviewImage {
  final String id;
  final String path;

  OrderReviewImage({
    required this.id,
    required this.path,
  });

  factory OrderReviewImage.fromJson(Map<String, dynamic> json) {
    return OrderReviewImage(
      id: json['id'] ?? '',
      path: json['path'] ?? '',
    );
  }

}
