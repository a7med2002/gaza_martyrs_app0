import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/controllers/User/Helper/image_helper.dart';
import 'package:gaza_martyer_app/models/massacres_model.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class MassacresController extends GetxController {
  final db = FirebaseFirestore.instance;
  final RxList<MassacresModel> massacres = <MassacresModel>[].obs;
  final uid = Uuid();

// For date picker
  TextEditingController dateController = TextEditingController();

  RxString massacresName = ''.obs;
  RxString massacresDate = ''.obs;
  RxInt massacresMartyer = 0.obs;
  RxInt massacresWounded = 0.obs;
  RxString massacresLocation = ''.obs;
  RxString massacresPhoto = ''.obs;

  Rx<Uint8List?> uploadedBytes = Rx<Uint8List?>(null); // للويب فقط
  ImagePicker picker = ImagePicker();
  RxString imagePickedPath = ''.obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMassacres();
  }

  Future<void> fetchMassacres() async {
    isLoading.value = true;
    try {
      final snapshot = await db
          .collection("massacres")
          .orderBy("createdAt", descending: true)
          .get();
      massacres.value = snapshot.docs
          .map((element) => MassacresModel.fromJson(element.data(), element.id))
          .toList();
    } catch (e) {
      print("Error fetching massacres: $e");
    }
    isLoading.value = false;
  }

  Future<void> addMassacres() async {
    isLoading.value = true;
    if (imagePickedPath.value.isEmpty) {
      Get.snackbar(
        "Missing Image".tr,
        "Please pick an image before submitting.".tr,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    String? uploadedUrl;

    if (kIsWeb) {
      uploadedUrl = await uploadImageToCloudinary(null);
    } else {
      uploadedUrl = await uploadImageToCloudinary(File(imagePickedPath.value));
    }

    if (uploadedUrl == null) {
      Get.snackbar(
        "Upload Failed".tr,
        "Could not upload image.".tr,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
      return;
    }
    massacresPhoto.value = uploadedUrl;
    final massacresId = uid.v4();

    final massacres = new MassacresModel(
        id: massacresId,
        imagePath: massacresPhoto.value,
        name: massacresName.value,
        date: massacresDate.value,
        location: massacresLocation.value,
        martyerNumber: massacresMartyer.value,
        woundedNumber: massacresWounded.value,
        createdAt: DateTime.now());
    try {
      await db.collection("massacres").doc(massacresId).set(massacres.toJson());
      isLoading.value = false;
      Get.snackbar(
        "Success".tr,
        "Massacres Added successfully".tr,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Error".tr,
        "Error added massacres".tr,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
      print("Error add masacress: $e");
    }
  }

// Validate Submit Story Form
  bool validateFormFields() {
    if (massacresName.value.trim().isEmpty ||
        massacresDate.value.trim().isEmpty ||
        massacresLocation.value.trim().isEmpty ||
        massacresMartyer.value == 0 ||
        massacresWounded.value == 0 ||
        (massacresPhoto.value.isEmpty && imagePickedPath.value.isEmpty)) {
      Get.snackbar(
        "Error".tr,
        "Please fill all required fields.".tr,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
      return false;
    }
    return true;
  }

  // Pick iamge from Gallery
  Future<void> pickImage() async {
    // Pick an image from Gal.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Check size limit (5MB = 5 * 1024 * 1024 bytes)
      final int sizeInBytes = await image.length();
      const int maxSizeInBytes = 5 * 1024 * 1024;

      if (sizeInBytes > maxSizeInBytes) {
        print("Image is larger than 5MB!");
        Get.snackbar(
          "Image Too Large".tr,
          "Please select an image smaller than 5 MB.".tr,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
        return;
      }

      if (kIsWeb) {
        final bytes = await image.readAsBytes();
        uploadedBytes.value = bytes;

        imagePickedPath.value = createWebImageUrl(bytes);
      } else {
        imagePickedPath.value = image.path;
        print("Image Path: ${image.path}");
      }
    } else {
      print("No Image Selected!");
    }
  }

  // Upload image to Cloudinary
  Future<String?> uploadImageToCloudinary(File? imageFile) async {
    final cloudinaryUrl =
        "https://api.cloudinary.com/v1_1/dqxdy9cdc/image/upload";
    final presetName = "massacres_photo";

    final request = http.MultipartRequest('POST', Uri.parse(cloudinaryUrl))
      ..fields['upload_preset'] = presetName;

    if (kIsWeb) {
      if (uploadedBytes.value == null) return null;

      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          uploadedBytes.value!,
          filename: 'upload.jpg',
          contentType: MediaType('image', 'jpeg'),
        ),
      );
    } else {
      if (imageFile == null) return null;

      request.files.add(
        await http.MultipartFile.fromPath('file', imageFile.path),
      );
    }

    final response = await request.send();
    final res = await http.Response.fromStream(response);

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      return data['secure_url'];
    } else {
      print("Upload failed: ${res.body}");
      return null;
    }
  }

  Future<void> showPickerofDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime(2023, 10, 7),
      firstDate: DateTime(2023, 10, 7),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      String formattedDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      massacresDate.value = formattedDate;
      dateController.text = formattedDate;
    }
  }

  void clear() {
    massacresName.value = '';
    massacresDate.value = '';
    massacresMartyer.value = 0;
    massacresWounded.value = 0;
    massacresLocation.value = '';
    massacresPhoto.value = '';
  }
}
