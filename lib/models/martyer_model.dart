class MartyerModel {
  final String id;
  final String firstName;
  final String midName;
  final String lastName;
  final String martyerCity;
  final String martyerGender;
  final String martyerAge;
  final String monthMartyer;
  final String yearMartyer;
  final String jobMartyer;
  final String photoUrl;
  final String story;
  final String submittedBy; // UID of the user
  final DateTime submittedAt; // Timestamp
  final String status;

  MartyerModel({
    required this.id,
    required this.firstName,
    required this.midName,
    required this.lastName,
    required this.martyerCity,
    required this.martyerGender,
    required this.martyerAge,
    required this.monthMartyer,
    required this.yearMartyer,
    required this.jobMartyer,
    required this.photoUrl,
    required this.story,
    required this.submittedBy,
    required this.submittedAt,
    this.status = "pending",
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "firstName": firstName,
      "midName": midName,
      "lastName": lastName,
      "martyerCity": martyerCity,
      "martyerGender": martyerGender,
      "martyerAge": martyerAge,
      "monthMartyer": monthMartyer,
      "yearMartyer": yearMartyer,
      "jobMartyer": jobMartyer,
      "photoUrl": photoUrl,
      "story": story,
      "submittedBy": submittedBy,
      "submittedAt": submittedAt.toIso8601String(),
      "status": status,
    };
  }

  factory MartyerModel.fromJson(Map<String, dynamic> json) {
    return MartyerModel(
      id: json['id'],
      firstName: json['firstName'],
      midName: json['midName'],
      lastName: json['lastName'],
      martyerCity: json['martyerCity'],
      martyerGender: json['martyerGender'],
      martyerAge: json['martyerAge'],
      monthMartyer: json['monthMartyer'],
      yearMartyer: json['yearMartyer'],
      jobMartyer: json['jobMartyer'],
      photoUrl: json['photoUrl'],
      story: json['story'],
      submittedBy: json['submittedBy'],
      submittedAt: DateTime.parse(json['submittedAt']),
      status: json["status"] ?? "pending",
    );
  }
}
