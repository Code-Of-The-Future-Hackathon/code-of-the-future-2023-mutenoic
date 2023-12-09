import 'package:app/app/models/info.dart';
import 'package:app/app/models/location.dart';
import 'package:app/app/models/sensor.dart';
import 'package:app/app/models/sensor_data_values.dart';
import 'package:app/app/services/geo_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../models/sensor_type.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final latlng = Rx<LatLng?>(null);

  List<Info> infoList = [];

  @override
  void onInit() {
    loadInfo();
    super.onInit();
  }

  Future<void> loadInfo() async {
    latlng.value = await GeoService().getDeviceLocation();

    var dio = Dio();

    var value = await dio.get('https://data.sensor.community/static/v2/data.json');

    infoList = (value.data as List).map((e) {
      return Info(
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
          double finalValue = 0;

          if (sd is String) {
            finalValue = double.parse(sd);
          } else if (sd is double) {
            finalValue = sd;
          }

          return SensorDataValue(
            e['id'],
            0,
            e['value_type'],
          );
        }).toList(),
      );
    }).toList();
  }
}
