import 'package:app/app/components/map_switcher.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/sensors_controller.dart';

class SensorsView extends GetView<SensorsController> {
  const SensorsView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut<SensorsController>(() => SensorsController());
    return Scaffold(
      body: Stack(
        children: [
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return MapSwitcher(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: controller.homeController.latlng.value ?? const LatLng(0, 0),
                ),
                zoomControlsEnabled: false,
                compassEnabled: false,
                myLocationButtonEnabled: false,
                myLocationEnabled: true,
                rotateGesturesEnabled: false,
                // onMapCreated: controller.homeController.onMapCreated,
                markers: controller.markers.toSet(),
                onMapCreated: controller.onMapCreated,
                mapToolbarEnabled: false,
              ),
            );
          }),
          Align(
            alignment: const Alignment(-0.9, -0.9),
            child: FloatingActionButton(
              onPressed: () => Get.back(),
              heroTag: "menu",
              child: const Icon(Icons.arrow_back),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.goToDeviceLocation,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
