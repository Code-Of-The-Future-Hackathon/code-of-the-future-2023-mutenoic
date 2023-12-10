import 'package:app/app/modules/chat_details/views/chat_details_view.dart';
import 'package:app/app/services/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance.collection("Reports").snapshots(),
              builder: (context, snapshot) {
                List<Marker> markers = [];

                if (snapshot.hasData) {
                  for (var doc in snapshot.data!.docs) {
                    markers.add(
                      Marker(
                        markerId: MarkerId(doc.id),
                        position: LatLng(
                          (doc["location"] as GeoPoint).latitude,
                          (doc["location"] as GeoPoint).longitude,
                        ),
                        onTap: () {
                          ChatService().joinChat(doc.data()["chat"]);
                          Get.to(() => const ChatDetailsView(), arguments: {
                            "chatId": doc.data()["chat"],
                          });
                        },
                      ),
                    );
                  }
                }

                return Obx(
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
                    markers: markers.toSet(),
                  ),
                );
              }),
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
