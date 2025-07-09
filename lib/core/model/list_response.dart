import 'package:cinemarket/core/model/pagination.dart';

class ListResponse<T> {
  final bool success;
  final String message;
  final List<T> items;
  final Pagination pagination;
  final DateTime timestamp;

  ListResponse({
    required this.success,
    required this.message,
    required this.items,
    required this.pagination,
    required this.timestamp,
  });

  factory ListResponse.fromJson(
      Map<String, dynamic> json,
      T Function(dynamic json) fromItem,
      ) {
    final data = json['data'] ?? {};
    final itemsJson = data['items'] as List<dynamic>? ?? [];
    final paginationJson = data['pagination'] ?? {};

    return ListResponse(
      success: json['success'],
      message: json['message'],
      items: itemsJson.map(fromItem).toList(),
      pagination: Pagination.fromJson(paginationJson),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
