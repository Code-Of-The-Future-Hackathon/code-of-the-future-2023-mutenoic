import 'package:app/app/models/info.dart';
import 'package:app/app/models/location.dart';
import 'package:app/app/models/sensor.dart';
import 'package:app/app/models/sensor_data_values.dart';
import 'package:app/app/services/geo_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inner_drawer/inner_drawer.dart';

import '../../../models/sensor_type.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final GlobalKey<InnerDrawerState> drawerKey = GlobalKey<InnerDrawerState>();

  final latlng = Rx<LatLng?>(null);
  final mapController = Rx<GoogleMapController?>(null);

  void openDrawer() {
    drawerKey.currentState?.open();
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    // controller.setMapStyle(Utils.mapStyles);
    mapController.value = controller;
    latlng.value = await GeoService().getDeviceLocation();

    await controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: latlng.value ?? const LatLng(0, 0),
      zoom: 15,
    )));
  }

  void goToDeviceLocation() {
    mapController.value?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: latlng.value ?? const LatLng(0, 0),
      zoom: 15,
    )));
  }
}
