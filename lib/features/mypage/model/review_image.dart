class ReviewImage {
  final String id;
  final String url;

  ReviewImage({
    required this.id,
    required this.url,
  });

  factory ReviewImage.fromJson(Map<String, dynamic> json) {
    return ReviewImage(
      id: json['id'] as String,
      url: json['url'] as String,
    );
  }
}