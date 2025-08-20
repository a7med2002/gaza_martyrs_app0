import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaza_martyer_app/components/custom_my_app_bar.dart';
import 'package:gaza_martyer_app/controllers/User/my_map_controller.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MapOfGaza extends StatelessWidget {
  const MapOfGaza({super.key});
  @override
  Widget build(BuildContext context) {
    final MapController _mapController = MapController();
    final myMapController = Get.put(MyMapController());
    return Scaffold(
      appBar: CustomMyAppBar(title: "mapOfGaza".tr),
      body: Obx(() => Padding(
            padding: EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Map of Gaza
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: SizedBox(
                      width: double.infinity,
                      height: 300,
                      child: FlutterMap(
                        mapController: _mapController,
                        options: MapOptions(
                            initialCenter:
                                myMapController.selectedLatLng.value ??
                                    LatLng(31.5, 34.47),
                            initialZoom: 9.0),
                        children: [
                          TileLayer(
                            tileProvider: NetworkTileProvider(
                              headers: {
                                'User-Agent':
                                    'gaza_martyer_app/1.0 (ahmd2002mqdad@gmail.com)'
                              },
                            ),
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          ),
                          if (myMapController.selectedLatLng.value != null)
                            MarkerLayer(markers: [
                              Marker(
                                  width: 40,
                                  height: 40,
                                  point: myMapController.selectedLatLng.value!,
                                  child: Icon(
                                    Icons.location_pin,
                                    color: Colors.red,
                                  ))
                            ])
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Cities
                  myMapController.cities.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: myMapController.cities.entries.map(
                            (headCity) {
                              return Column(
                                children: [
                                  Container(
                                    width: 70,
                                    height: 60,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Center(
                                      child: Text(
                                        headCity.key.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  SvgPicture.asset(
                                    "assets/svgs/ArrowDown.svg",
                                    width: 24,
                                    height: 24,
                                  ),
                                  SizedBox(height: 8),
                                  Column(
                                    children: headCity.value.entries.map(
                                      (city) {
                                        return InkWell(
                                          onTap: () {
                                            myMapController.selectedLatLng
                                                .value = city.value;
                                            _mapController.move(
                                                city.value, 13.0);
                                          },
                                          child: Container(
                                            width: 70,
                                            height: 70,
                                            margin: EdgeInsets.only(bottom: 8),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 6),
                                            decoration: BoxDecoration(
                                                color: city.value ==
                                                        myMapController
                                                            .selectedLatLng
                                                            .value
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                    : Theme.of(context)
                                                        .colorScheme
                                                        .primaryContainer,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Center(
                                              child: Text(
                                                city.key.tr,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: city.value ==
                                                            myMapController
                                                                .selectedLatLng
                                                                .value
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .onPrimary
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ).toList(),
                                  )
                                ],
                              );
                            },
                          ).toList(),
                        )
                ],
              ),
            ),
          )),
    );
  }
}
