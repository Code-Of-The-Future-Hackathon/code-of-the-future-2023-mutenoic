import 'package:app/app/models/info.dart';
import 'package:app/app/models/location.dart';
import 'package:app/app/models/sensor.dart';
import 'package:app/app/models/sensor_data_values.dart';
import 'package:app/app/models/sensor_type.dart';
import 'package:app/app/modules/home/controllers/home_controller.dart';
import 'package:app/app/modules/sensor_details/views/sensor_details_view.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SensorsController extends GetxController {
  //TODO: Implement SensorsController
  var homeController = Get.find<HomeController>();

  RxList<Marker> markers = RxList.empty();

  RxList<Info> infoList = RxList.empty();

  RxBool isLoading = true.obs;

  @override
  void onInit() {
    loadInfo();
    super.onInit();
  }

  Future<void> loadInfo() async {
    var dio = Dio();

    var value = await dio.get('https://data.sensor.community/static/v2/data.json');

    infoList.value = (value.data as List).where((element) => element['location']['country'] == 'BG').map((e) {
      var info = Info(
        e['id'],
        e['sampling_rate'],
        DateTime.parse(e['timestamp']),
        Location(
          e['location']['id'],
          e['location']['latitude'],
          e['location']['longitude'],
          e['location']['altitude'],
          e['location']['country'],
          e['location']['exact_location'],
          e['location']['indoor'],
        ),
        Sensor(
          e['sensor']['id'],
          e['sensor']['pin'],
          SensorType(
            e['sensor']['sensor_type']['id'],
            e['sensor']['sensor_type']['name'],
            e['sensor']['sensor_type']['manufacturer'],
          ),
        ),
        (e['sensordatavalues'] as List).map((e) {
          var sd = e['value'];
          double finalValue;

          try {
            finalValue = sd is String ? double.parse(sd) : sd.toDouble();
          } catch (e) {
            finalValue = 0.0;
          }

          return SensorDataValue(
            e['id'],
            finalValue,
            e['value_type'],
          );
        }).toList(),
      );
      var loc = LatLng(double.parse(info.location.latitude), double.parse(info.location.longitude));
      markers.add(
        Marker(
          markerId: MarkerId(info.id.toString()),
          position: loc,
          onTap: () {
            homeController.mapController.value?.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: loc,
                  zoom: 15,
                ),
              ),
            );

            Get.to(const SensorDetailsView(), arguments: {"info": info});
          },
        ),
      );

      return info;
    }).toList();

    isLoading.value = false;
  }

  Rx<GoogleMapController?> mapController = Rx<GoogleMapController?>(null);

  void onMapCreated(GoogleMapController controller) {
    mapController.value = controller;
    goToDeviceLocation();
  }

  void goToDeviceLocation() {
    mapController.value?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: homeController.latlng.value ?? const LatLng(0, 0),
      zoom: 15,
    )));
  }
}
