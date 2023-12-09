import 'package:app/app/modules/home/controllers/home_controller.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  var homeController = Get.find<HomeController>();

  final emergency = false.obs;

  final RxList<Marker> markers = <Marker>[].obs;

  @override
  void onInit() {
    emergency.listen((value) {
      if (value) {
        onEmergency();
      }
    });
    super.onInit();
  }

  void onEmergency() {
    homeController.goToDeviceLocation();

    final player = AudioPlayer();
    player.play(AssetSource("lib/assets/sounds/emergency.mp3"));

    markers.add(
      Marker(markerId: const MarkerId("sd"), position: homeController.latlng.value!),
    );
  }
}
