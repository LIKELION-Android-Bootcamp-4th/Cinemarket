class SuccessResponse<T> {
  final bool success;
  final String message;
  final T data;
  final DateTime timestamp;

  SuccessResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.timestamp,
  });

  factory SuccessResponse.fromJson(
      Map<String, dynamic> json,
      T Function(dynamic json) fromData,
      ) {
    return SuccessResponse(
      success: json['success'],
      message: json['message'],
      data: fromData(json['data']),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
