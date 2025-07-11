class GoodsImages {
  final String main;
  final List<String> sub;

  GoodsImages({
    required this.main,
    required this.sub,
  });

  factory GoodsImages.fromJson(Map<String, dynamic> json) {
    return GoodsImages(
      main: json['main'] ?? '',
      sub: (json['sub'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ??
          [],
    );
  }

  factory GoodsImages.empty() {
    return GoodsImages(main: '', sub: []);
  }
}
