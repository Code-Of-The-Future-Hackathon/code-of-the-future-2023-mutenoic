import 'package:app/app/models/info.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SensorDetailsController extends GetxController {
  Info info = Get.arguments["info"];

  LatLng get latlng => LatLng(
        double.parse(info.location.latitude),
        double.parse(info.location.longitude),
      );

// SDS011: Particulate Matter (PM) sensor, specifically for PM2.5 and PM10.

// BME280: Environmental sensor measuring temperature, humidity, and barometric pressure.

// SPS30DNMS (Laerm): Particulate Matter (PM) sensor for measuring fine dust.

// DHT22: Measures temperature and humidity.

// HTU21D: Another sensor for measuring temperature and humidity.

// SHT31: Sensor for measuring temperature and humidity.

// BMP180: Barometric pressure sensor.

// PMS7003: Particulate Matter (PM) sensor for measuring PM1.0, PM2.5, and PM10.

// BMP280: Barometric pressure sensor.

// DS18B20: Digital temperature sensor with a unique address.

// PMS3003: Particulate Matter (PM) sensor.

// SHT30: Sensor for measuring temperature and humidity.

// PMS5003: Particulate Matter (PM) sensor for measuring PM1.0, PM2.5, and PM10.

// HPM: High-precision particulate matter (PM) sensor.

// PMS1003: Particulate Matter (PM) sensor.

// PPD42NS: Particulate Matter (PM) sensor.

// Radiation Si22G: Gamma radiation sensor.

// SDS021: Particulate Matter (PM) sensor.

// SHT85: Sensor for measuring temperature and humidity.

// Radiation SBM-19: Beta and gamma radiation sensor.

// PMS6003: Particulate Matter (PM) sensor for measuring PM1.0, PM2.5, and PM10.

// Radiation SBM-20: Beta and gamma radiation sensor.

// SHT35: Sensor for measuring temperature and humidity.

// SCD30: Carbon Dioxide (CO2), temperature, and humidity sensor.

// GPS-NEO-6M: GPS module for determining location coordinates.

// SHT11: Sensor for measuring temperature and humidity.

// NextPM: Particulate Matter (PM) sensor.
  String categorizeSensor(String sensorName) {
    switch (sensorName) {
      case "SDS011":
        return "Particulate Matter";
      case "BME280":
        return "temperature, humidity, and barometric";
      case "SPS30DNMS (Laerm)":
        return "Particulate Matter";
      case "DHT22":
      case "HTU21D":
      case "SHT31":
        return "temperature and humidity";
      case "BMP180":
      case "BMP280":
        return "Barometric pressure";
      case "PMS7003":
      case "PMS3003":
      case "PMS5003":
      case "HPM":
      case "PMS1003":
      case "PPD42NS":
      case "SDS021":
      case "PMS6003":
      case "PPD42NS":
      case "NextPM":
        return "Particulate Matter";
      case "Radiation Si22G":
      case "Radiation SBM-19":
      case "Radiation SBM-20":
        return "Gamma radiation";
      case "SHT85":
      case "SHT35":
      case "SHT11":
      case "SCD30":
      case "GPS-NEO-6M":
        return "temperature and humidity";
      default:
        return "Unknown";
    }
  }
}
