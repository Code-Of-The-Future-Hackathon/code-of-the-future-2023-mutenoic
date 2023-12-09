import 'package:app/app/modules/home/controllers/home_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherController extends GetxController {
  //TODO: Implement WeatherController

  RxBool isLoading = true.obs;
  RxMap<String, dynamic> current = RxMap.from({});
  RxMap<String, dynamic> hourly = RxMap.from({});

  @override
  void onInit() {
    getInformation();
    super.onInit();
  }

  Map<int, String> weatherConditions = {
    0: 'Clear sky',
    1: 'Partly cloudy',
    2: 'Overcast',
    3: 'Rain showers',
    4: 'Overcast',
    10: 'Mist',
  };

  Rx<IconData> icon = WeatherIcons.day_sunny.obs;

  Future<void> getInformation() async {
    isLoading.value = true;
    var dio = Dio();

    var latlng = Get.find<HomeController>().latlng.value;

    // https://api.open-meteo.com/v1/forecast?latitude=42.6975&longitude=23.3241&hourly=temperature_2m,relative_humidity_2m,weather_code,surface_pressure,cloud_cover,visibility,wind_direction_10m
    var result = await dio.get(
      "https://api.open-meteo.com/v1/forecast?latitude=${latlng!.latitude}&longitude=${latlng.longitude}&hourly=temperature_2m,relative_humidity_2m,weather_code,surface_pressure,cloud_cover,visibility,wind_direction_10m&current=temperature_2m,relative_humidity_2m,weather_code",
    );

    print(result.data);
    current = RxMap.from(result.data["current"]);
    hourly = RxMap.from(result.data["hourly"]);

    current["weather_code"] = weatherConditions[current["weather_code"]];
    icon.value = getIcon(current["weather_code"]);

    isLoading.value = false;
  }

  IconData getIcon(String weatherCode) {
    switch (weatherCode) {
      case "Clear sky":
        return WeatherIcons.day_sunny;
      case "Partly cloudy":
        return WeatherIcons.day_cloudy;
      case "Overcast":
        return WeatherIcons.cloud;
      case "Rain showers":
        return WeatherIcons.rain;
      case "Mist":
        return WeatherIcons.fog;
      default:
        return WeatherIcons.day_sunny;
    }
  }
}
