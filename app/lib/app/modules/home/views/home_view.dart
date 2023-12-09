import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => GoogleMap(
          initialCameraPosition: CameraPosition(
            target: controller.latlng.value ?? const LatLng(0, 0),
          ),
          compassEnabled: false,
          myLocationButtonEnabled: false,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          onMapCreated: controller.onMapCreated,
          rotateGesturesEnabled: false,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.goToDeviceLocation,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
