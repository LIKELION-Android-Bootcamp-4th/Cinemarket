class Pagination {
  final int currentPage;
  final int totalPages;
  final int total;
  final int limit;
  final bool hasNext;
  final bool hasPrev;

  Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.total,
    required this.limit,
    required this.hasNext,
    required this.hasPrev,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      total: json['total'],
      limit: json['limit'],
      hasNext: json['hasNext'],
      hasPrev: json['hasPrev'],
    );
  }
}