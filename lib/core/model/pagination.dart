class Pagination {
  final int page;
  final int limit;
  final int total;
  final int totalPages;
  final bool hasNext;
  final bool hasPrev;

  Pagination({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
    required this.hasNext,
    required this.hasPrev,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: int.tryParse(json['currentPage'].toString()) ?? 0,
      limit: int.tryParse(json['limit'].toString()) ?? 0,
      total: int.tryParse(json['total'].toString()) ?? 0,
      totalPages: int.tryParse(json['totalPages'].toString()) ?? 0,
      hasNext: json['hasNext'] == true,
      hasPrev: json['hasPrev'] == true,
    );
  }

}
