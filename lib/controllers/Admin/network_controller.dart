import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final RxBool isOnline = true.obs;
  late final StreamSubscription<List<ConnectivityResult>> _subscription;

  @override
  void onInit() {
    super.onInit();
    _checkConnection();

    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      _updateConnectionStatus(result);
    });
  }

  Future<void> _checkConnection() async {
    final List<ConnectivityResult> results =
        await Connectivity().checkConnectivity();
    _updateConnectionStatus(results);
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    final hasConnection = results.any((r) => r != ConnectivityResult.none);
    if (!hasConnection) {
      isOnline.value = false;
      Get.snackbar(
        "No Connection".tr,
        "You're offline. Check your internet connection.".tr,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    } else {
      if (!isOnline.value) {
        Get.snackbar(
          "Back Online".tr,
          "Internet connection is restored.".tr,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
        );
      }
      isOnline.value = true;
    }
  }

  @override
  void onClose() {
    _subscription.cancel(); 
    super.onClose();
  }
}