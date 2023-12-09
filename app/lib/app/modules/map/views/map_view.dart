import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/map_controller.dart';

class MapView extends GetView<MapController> {
  const MapView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MapController());
    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => GoogleMap(
              initialCameraPosition: CameraPosition(
                target: controller.homeController.latlng.value ?? const LatLng(0, 0),
              ),
              compassEnabled: false,
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              onMapCreated: controller.homeController.onMapCreated,
              rotateGesturesEnabled: false,
              markers: controller.markers.toSet(),
            ),
          ),
          Align(
            alignment: const Alignment(-0.9, -0.9),
            child: FloatingActionButton(
              onPressed: controller.homeController.openDrawer,
              heroTag: "menu",
              child: const Icon(Icons.menu),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.homeController.goToDeviceLocation,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
