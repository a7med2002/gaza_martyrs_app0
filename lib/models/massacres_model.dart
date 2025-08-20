import 'package:cloud_firestore/cloud_firestore.dart';

class MassacresModel {
  final String id;
  final String imagePath;
  final String name;
  final String date;
  final String location;
  final int martyerNumber;
  final int woundedNumber;
  final DateTime createdAt;

  MassacresModel({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.date,
    required this.location,
    required this.martyerNumber,
    required this.woundedNumber,
    required this.createdAt,
  });

  factory MassacresModel.fromJson(Map<String, dynamic> json, String id) {
    return MassacresModel(
      id: id,
      imagePath: json['imagePath'] ?? '',
      name: json['name'] ?? '',
      date: json['date'] ?? '',
      location: json['location'] ?? '',
      martyerNumber: json['martyerNumber'] ?? 0,
      woundedNumber: json['woundedNumber'] ?? 0,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "imagePath": imagePath,
      "name": name,
      "date": date,
      "location": location,
      "martyerNumber": martyerNumber,
      "woundedNumber": woundedNumber,
      "createdAt": createdAt,
    };
  }
}
