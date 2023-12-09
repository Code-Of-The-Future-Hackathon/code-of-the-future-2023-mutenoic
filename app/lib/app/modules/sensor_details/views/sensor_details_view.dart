import 'package:app/app/components/map_switcher.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/sensor_details_controller.dart';

class SensorDetailsView extends GetView<SensorDetailsController> {
  const SensorDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut<SensorDetailsController>(() => SensorDetailsController());
    return Scaffold(
        appBar: AppBar(
          title: const Text('SensorDetailsView'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              Text(controller.info.id.toString()),
              Text(controller.info.location.country),
              SizedBox(
                height: 300,
                width: Get.width / 1.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  clipBehavior: Clip.hardEdge,
                  child: MapSwitcher(
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: controller.latlng,
                        zoom: 15,
                      ),

                      markers: {
                        Marker(
                          markerId: MarkerId(controller.info.id.toString()),
                          position: controller.latlng,
                        )
                      },
                      liteModeEnabled: true,
                      zoomControlsEnabled: false,
                      compassEnabled: false,
                      myLocationButtonEnabled: false,
                      myLocationEnabled: true,
                      rotateGesturesEnabled: false,
                      // onMapCreated: controller.homeController.onMapCreated,
                      // markers: controller.markers.toSet(),
                      // onMapCreated: controller.onMapCreated,
                      mapToolbarEnabled: false,
                    ),
                  ),
                ),
              ),
              Text(controller.info.sensor.sensorType.name),
              Text(controller.info.sensor.sensorType.manufacturer),
              Text("Sensor type: ${controller.categorizeSensor(controller.info.sensor.sensorType.name.trim())}"),
            ],
          ),
        ));
  }
}
