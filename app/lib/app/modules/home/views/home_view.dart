import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inner_drawer/inner_drawer.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
      key: controller.drawerKey,
      onTapClose: true,
      colorTransitionChild: Colors.transparent,
      colorTransitionScaffold: Colors.transparent,
      boxShadow: const [
        BoxShadow(
          offset: Offset(0, 15),
          color: Colors.black26,
          blurRadius: 30,
          spreadRadius: 10,
        )
      ],
      offset: const IDOffset.only(left: 0.5),
      scale: const IDOffset.horizontal(0.8), // set the offset in both directions
      proportionalChildArea: false, // default true
      borderRadius: 50, // default 0
      leftAnimationType: InnerDrawerAnimation.static,
      backgroundDecoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      swipe: false,
      leftChild: const SizedBox(),
      scaffold: Scaffold(
        body: Stack(
          children: [
            Obx(
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
            Align(
              alignment: const Alignment(-0.9, -0.9),
              child: FloatingActionButton(
                onPressed: () {
                  controller.drawerKey.currentState?.open(direction: InnerDrawerDirection.start);
                },
                child: const Icon(Icons.menu),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.goToDeviceLocation,
          child: const Icon(Icons.my_location),
        ),
      ),
    );
  }
}
