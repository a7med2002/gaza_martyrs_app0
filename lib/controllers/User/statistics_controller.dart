import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatisticsController extends GetxController {
  RxInt martyerNumber = 0.obs;
  RxInt maleMartyer = 0.obs;
  RxInt femaleMartyer = 0.obs;
  RxInt childrenMartyer = 0.obs;
  RxInt oldMartyer = 0.obs;
  RxInt journalistsMartyer = 0.obs;
  RxInt doctorMartyer = 0.obs;
  RxBool isShowSubStatistics = false.obs;

  RxInt woundedNumbers = 0.obs;
  RxInt massacres = 0.obs;
  RxInt missing = 0.obs;
  RxInt residentialUnits = 0.obs;
  RxInt prisoners = 0.obs;

  final FirebaseFirestore db = FirebaseFirestore.instance;

  RxBool isLoading = false.obs;

  TextEditingController martyerNumberController = TextEditingController();
  TextEditingController maleMartyerController = TextEditingController();
  TextEditingController femaleMartyerController = TextEditingController();
  TextEditingController childrenMartyerController = TextEditingController();
  TextEditingController oldMartyerController = TextEditingController();
  TextEditingController journalistsMartyerController = TextEditingController();
  TextEditingController doctorMartyerController = TextEditingController();
  TextEditingController woundedNumbersController = TextEditingController();
  TextEditingController massacresController = TextEditingController();
  TextEditingController missingController = TextEditingController();
  TextEditingController residentialUnitsController = TextEditingController();
  TextEditingController prisonersController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchStatistics();
  }

  Future<void> fetchStatistics() async {
    isLoading.value = true;
    try {
      DocumentSnapshot doc =
          await db.collection("statistics").doc("current").get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        martyerNumber.value = data["martyerNumber"] ?? 0;
        maleMartyer.value = data["maleMartyer"] ?? 0;
        femaleMartyer.value = data["femaleMartyer"] ?? 0;
        childrenMartyer.value = data["childrenMartyer"] ?? 0;
        oldMartyer.value = data["oldMartyer"] ?? 0;
        journalistsMartyer.value = data["journalistsMartyer"] ?? 0;
        doctorMartyer.value = data["doctorMartyer"] ?? 0;

        woundedNumbers.value = data["woundedNumbers"] ?? 0;
        massacres.value = data["massacres"] ?? 0;
        missing.value = data["missing"] ?? 0;
        residentialUnits.value = data["residentialUnits"] ?? 0;
        prisoners.value = data["prisoners"] ?? 0;

        martyerNumberController.text = martyerNumber.value.toString();
        maleMartyerController.text = maleMartyer.value.toString();
        femaleMartyerController.text = femaleMartyer.value.toString();
        childrenMartyerController.text = childrenMartyer.value.toString();
        oldMartyerController.text = oldMartyer.value.toString();
        journalistsMartyerController.text = journalistsMartyer.value.toString();
        doctorMartyerController.text = doctorMartyer.value.toString();
        woundedNumbersController.text = woundedNumbers.value.toString();
        massacresController.text = massacres.value.toString();
        missingController.text = missing.value.toString();
        residentialUnitsController.text = residentialUnits.value.toString();
        prisonersController.text = prisoners.value.toString();
      }
      isLoading.value = false;
    } catch (e) {
      print("Error fetching statistics: $e");
      isLoading.value = false;
    }
  }

  Future<void> updateStatistics() async {
    isLoading.value = true;
    try {
      martyerNumber.value = int.tryParse(martyerNumberController.text) ?? 0;
      maleMartyer.value = int.tryParse(maleMartyerController.text) ?? 0;
      femaleMartyer.value = int.tryParse(femaleMartyerController.text) ?? 0;
      childrenMartyer.value = int.tryParse(childrenMartyerController.text) ?? 0;
      oldMartyer.value = int.tryParse(oldMartyerController.text) ?? 0;
      journalistsMartyer.value =
          int.tryParse(journalistsMartyerController.text) ?? 0;
      doctorMartyer.value = int.tryParse(doctorMartyerController.text) ?? 0;
      woundedNumbers.value = int.tryParse(woundedNumbersController.text) ?? 0;
      massacres.value = int.tryParse(massacresController.text) ?? 0;
      missing.value = int.tryParse(missingController.text) ?? 0;
      residentialUnits.value =
          int.tryParse(residentialUnitsController.text) ?? 0;
      prisoners.value = int.tryParse(prisonersController.text) ?? 0;

      await db.collection("statistics").doc("current").update({
        "martyerNumber": martyerNumber.value,
        "maleMartyer": maleMartyer.value,
        "femaleMartyer": femaleMartyer.value,
        "childrenMartyer": childrenMartyer.value,
        "oldMartyer": oldMartyer.value,
        "journalistsMartyer": journalistsMartyer.value,
        "doctorMartyer": doctorMartyer.value,
        "woundedNumbers": woundedNumbers.value,
        "massacres": massacres.value,
        "missing": missing.value,
        "residentialUnits": residentialUnits.value,
        "prisoners": prisoners.value,
      });
      isLoading.value = false;

      Get.snackbar(
        "Updated".tr,
        "Statistics updated successfully".tr,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      print("Error update Satistics: $e");
      Get.snackbar(
        "Error".tr,
        "Error in Updating Statistics".tr,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
      isLoading.value = false;
    }
  }
}
