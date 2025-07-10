class StatusHistory {
  final String status;
  final DateTime changedAt;
  final String changedBy;
  final String note;
  final String id;

  StatusHistory({
    required this.status,
    required this.changedAt,
    required this.changedBy,
    required this.note,
    required this.id,
  });

  factory StatusHistory.fromJson(Map<String, dynamic> json) {
    return StatusHistory(
      status: json['status'],
      changedAt: DateTime.parse(json['changedAt']),
      changedBy: json['changedBy'],
      note: json['note'],
      id: json['id'],
    );
  }
}