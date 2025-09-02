import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateController extends GetxController {
  final latestVersion = ''.obs;
  final downloadUrl = ''.obs;

  final String jsonUrl = "https://gaza-martyer-app.web.app/app_version.json";

  Future<void> checkForUpdate(BuildContext context) async {
    try {
      PackageInfo info = await PackageInfo.fromPlatform();
      String currentVersion = info.version;

      final response = await http.get(Uri.parse(jsonUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        latestVersion.value = data['latest_version'];
        downloadUrl.value = data['download_url'];

        // 3) مقارنة النسخ
        if (_isNewerVersion(latestVersion.value, currentVersion)) {
          _showUpdateDialog(context);
        }
      }
    } catch (e) {
      debugPrint("Failed Update: $e");
    }
  }

  bool _isNewerVersion(String latest, String current) {
    List<int> a = latest.split('.').map((e) => int.tryParse(e) ?? 0).toList();
    List<int> b = current.split('.').map((e) => int.tryParse(e) ?? 0).toList();

    while (a.length < 3) a.add(0);
    while (b.length < 3) b.add(0);

    for (int i = 0; i < 3; i++) {
      if (a[i] > b[i]) return true;
      if (a[i] < b[i]) return false;
    }
    return false;
  }

  void _showUpdateDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: Text("New update available".tr),
        content: Text(
            "A new version of the app ($latestVersion) is available. Do you want to update now?"),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text("later".tr),
          ),
          ElevatedButton(
            onPressed: () async {
              final rawUrl = downloadUrl.value;
              final encodedUrl =
                  Uri.encodeFull(rawUrl); // يحل مشكلة الرموز مثل + و =
              final uri = Uri.parse(encodedUrl);

              try {
                final success =
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                if (!success) {
                  Get.snackbar("Error", "Cannot open the link: $encodedUrl");
                }
              } catch (e) {
                Get.snackbar("Error", "Failed to launch: $e");
              }
            },
            child: Text("Update".tr),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  @override
  void onReady() {
    super.onReady();
    if (Platform.isAndroid) {
      Future.delayed(
          Duration(microseconds: 300), () => checkForUpdate(Get.context!));
    }
  }
}
