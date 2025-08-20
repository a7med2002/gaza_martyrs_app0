import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gaza_martyer_app/models/martyer_model.dart';
import 'package:gaza_martyer_app/models/report_model.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class ReportController extends GetxController {
  RxString reportType = ''.obs;
  RxString reportDescription = ''.obs;

  RxList<ReportModel> reports = <ReportModel>[].obs;
  Rx<ReportModel?> selectedReport = Rx<ReportModel?>(null);
  Rx<MartyerModel?> selectedStory = Rx<MartyerModel?>(null);

  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final uid = Uuid();

  RxBool isLoading = false.obs;

  Future<void> submitReport({required String storyId}) async {
    isLoading.value = true;
    final user = auth.currentUser;
    if (user == null) {
      isLoading.value = false;
      Get.snackbar(
        "Error".tr,
        "User not logged in".tr,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    if (reportType.value.isEmpty || reportDescription.value.trim().isEmpty) {
      isLoading.value = false;
      Get.snackbar(
        "Missing Data".tr,
        "Please fill all report fields".tr,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    try {
      final report = new ReportModel(
          id: uid.v4(),
          storyId: storyId,
          reportType: reportType.value,
          message: reportDescription.value.trim(),
          reporterId: user.uid);
      await db.collection('reports').add(report.toJson());

      // Clear fields after submission
      reportType.value = '';
      reportDescription.value = '';
      isLoading.value = false;
      Get.back(); // Close dialog
      Get.snackbar(
        "Success".tr,
        "Report submitted successfully".tr,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Error".tr,
        "${"Failed to submit report".tr}: $e",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    }
  }

  Future<void> getReports() async {
    try {
      final snapshot = await db.collection("reports").get();
      reports.value = snapshot.docs
          .map((report) => ReportModel.fromJson(report.id, report.data()))
          .toList();
      print("Fetching reports from Firestore...");
    } catch (e) {
      print("Error: $e");
    }
    ;
  }

  Future<MartyerModel> getStoryById(String storyId) async {
    final doc = await db.collection("stories").doc(storyId).get();
    return MartyerModel.fromJson(doc.data()!);
  }

  Future<void> deleteReport(String reportID) async {
    try {
      await db.collection("reports").doc(reportID).delete();
      getReports();
      Get.back();
    } catch (e) {
      print("Error: $e");
    }
  }

  int reportCountPerStory(String storyId) {
    var count = 0;
    for (var report in reports) {
      if (report.storyId == storyId) {
        count += 1;
      }
    }
    return count;
  }

  @override
  void onInit() {
    getReports();
    super.onInit();
  }
}
