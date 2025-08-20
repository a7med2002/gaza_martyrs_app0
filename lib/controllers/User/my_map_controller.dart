import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MyMapController extends GetxController {
  final selectedLatLng = Rx<LatLng?>(null);
  final db = FirebaseFirestore.instance;
  final cities = <String, Map<String, LatLng>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadCities();
  }

  void loadCities() async {
    final data = await fetchCities();
    cities.assignAll(data);
  }

  Future<Map<String, Map<String, LatLng>>> fetchCities() async {
    final snapshot = await db.collection("cities").get();

    Map<String, Map<String, LatLng>> result = {};

    for (var doc in snapshot.docs) {
      String city = doc.id;
      final data = doc.data();
      final areas = data["areas"] as Map<String, dynamic>;

      Map<String, LatLng> parsedAreas = {};
      areas.forEach((areaName, coords) {
        parsedAreas[areaName] =
            LatLng(coords["lat"] as double, coords["lng"] as double);
      });

      result[city] = parsedAreas;
    }

    return result;
  }
}