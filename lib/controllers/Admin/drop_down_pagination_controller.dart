import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gaza_martyer_app/models/martyer_model.dart';
import 'package:gaza_martyer_app/models/user_model.dart';
import 'package:get/get.dart';

class DropDownPaginationController extends GetxController {
  final RxInt currentPage = 1.obs;
  final int userPerPage = 5;
  RxList<UserModel> allUsers = <UserModel>[].obs;

  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  List get pagiantedUsers {
    final start = (currentPage.value - 1) * userPerPage;
    final end = start + userPerPage;
    return allUsers.sublist(
        start, end > allUsers.length ? allUsers.length : end);
  }

  int get totalPages => (allUsers.length / userPerPage).ceil();

  List<int> get pageList => List.generate(totalPages, (index) => index + 1);

  void gotToPage(int page) {
    currentPage.value = page;
  }

  // For Store Number of Story For each User
  Rx<UserModel?> selectedUser = Rx<UserModel?>(null);
  RxMap<String, int> numberOfStoryMap = <String, int>{}.obs;
  RxList<MartyerModel> userStories = <MartyerModel>[].obs;

  Future<void> getAllUsers() async {
    try {
      final snapshot =
          await db.collection("users").where("role", isEqualTo: "user").get();
      final usersList =
          snapshot.docs.map((user) => UserModel.fromJson(user.data())).toList();
      allUsers.value = usersList;

      for (var user in usersList) {
        final snapshot = await db
            .collection("stories")
            .where("submittedBy", isEqualTo: user.id)
            .get();
        numberOfStoryMap[user.id!] = snapshot.docs.length;
      }
    } catch (e) {
      print("Error Getting Users: $e");
    }
  }

  Future<void> getUserStories(String userId) async {
    final snapshot = await db
        .collection("stories")
        .where("submittedBy", isEqualTo: userId)
        .get();
    userStories.value = snapshot.docs
        .map((story) => MartyerModel.fromJson(story.data()))
        .toList();
  }

  Future<void> sendResetPasswordLink(String userEmail) async {
    try {
      await auth.sendPasswordResetEmail(email: userEmail);
      Get.snackbar(
        "Success".tr,
        "reset password link sent successfully to user.".tr,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      print("Error send reset password link: $e");
    }
  }

  @override
  void onInit() {
    getAllUsers();
    super.onInit();
  }
}
