class SearchItem {
  final String id;
  final String name;
  final String description;
  final int price;
  final String mainImage;
  final int? tmdbId;

  SearchItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.mainImage,
    this.tmdbId,
  });

  factory SearchItem.fromJson(Map<String, dynamic> json) {
    final imageMap = json['images'] ?? {};
    return SearchItem(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      mainImage: imageMap['main'] ?? '',
    );
  }
}