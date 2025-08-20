import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? role;
  DateTime? createdAt;
  DateTime? loginDate;
  String? status;
  String? signInMethod;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.role,
      this.createdAt,
      this.loginDate,
      this.status,
      this.signInMethod});

  UserModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["email"] is String) {
      email = json["email"];
    }
    if (json["role"] is String) {
      role = json["role"];
    }
    if (json["createdAt"] is Timestamp) {
      createdAt = (json["createdAt"] as Timestamp).toDate();
    }
    if (json["loginDate"] is Timestamp) {
      loginDate = (json["loginDate"] as Timestamp).toDate();
    }
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["signInMethod"] is String) {
      signInMethod = json["signInMethod"];
    }
  }

  static List<UserModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(UserModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["email"] = email;
    _data["role"] = role;
    if (createdAt != null) _data["createdAt"] = Timestamp.fromDate(createdAt!);
    if (loginDate != null) _data["loginDate"] = Timestamp.fromDate(loginDate!);
    if (status != null) _data["status"] = status;
    _data["signInMethod"] = signInMethod;
    return _data;
  }
}
