import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  final String id;
  final String storyId;
  final String reportType;
  final String message;
  final String reporterId;
  final DateTime? reportedAt;

  ReportModel({
    required this.id,
    required this.storyId,
    required this.reportType,
    required this.message,
    required this.reporterId,
    this.reportedAt,
  });

  factory ReportModel.fromJson(String id, Map<String, dynamic> json) {
    return ReportModel(
      id: id,
      storyId: json['storyId'],
      reportType: json['reportType'],
      message: json['message'],
      reporterId: json['reporterId'],
      reportedAt: (json['reportedAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'storyId': storyId,
      'reportType': reportType,
      'message': message,
      'reporterId': reporterId,
      'reportedAt': reportedAt,
    };
  }
}
