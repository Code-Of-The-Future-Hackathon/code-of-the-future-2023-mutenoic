import 'dart:async';
import 'dart:math';

import 'package:app/app/modules/home/controllers/home_controller.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  var homeController = Get.find<HomeController>();

  final emergencyLatLng = const LatLng(0, 0).obs;

  final RxList<Marker> markers = <Marker>[].obs;

  Future<void> onEmergency(LatLng location) async {
    homeController.goToDeviceLocation();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light));

    // read darkMap.json at assets/darkMap.json
    var style = await rootBundle.loadString('lib/app/data/assets/darkMap.json');
    homeController.mapController.value!.setMapStyle(style);

    // final player = AudioPlayer();
    // player.play(AssetSource("lib/assets/sounds/emergency.mp3"));

    markers.addAll(
      {
        Marker(
          markerId: MarkerId("emergency${Random().nextInt(25)}"),
          position: location,
        ),
      },
    );

    Timer(const Duration(seconds: 30), () {
      markers.clear();
      homeController.mapController.value!.setMapStyle(null);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark));
    });
  }
}
