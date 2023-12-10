import 'package:app/app/models/info.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SensorDetailsController extends GetxController {
  Info info = Get.arguments["info"];

  LatLng get latlng => LatLng(
        double.parse(info.location.latitude),
        double.parse(info.location.longitude),
      );

  String valueType(String type) {
    switch (type.toLowerCase()) {
      case "humidity":
        return "%";

      case "temperature":
        return "°C";

      case "pressure":
        return "hPa";

      case "p1":
      case "p2":
      case "p10":
        return "µg/m³";

      case "pm10":
      case "pm25":
      case "pm100":
        return "µg/m³";

      case "radiation":
        return "µSv/h";

      case "co2":
        return "ppm";

      case "noise":
        return "dB";

      case "altitude":
      case "gps-accuracy":
        return "m";

      case "gps-satellites":
        return "satellites";

      default:
        return "";
    }
  }

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

  bool particulate = false;
  bool temperature = false;
  bool humidity = false;
  bool pressure = false;
  bool radiation = false;
  bool barometric = false;
  bool co2 = false;
  bool noise = false;
  bool altitude = false;

  String categorizeSensor(String sensorName) {
    switch (sensorName) {
      case "SDS011":
        particulate = true;
        return "Air quality";
      case "BME280":
        temperature = true;
        humidity = true;
        barometric = true;
        return "temperature, humidity, and barometric";
      case "SPS30DNMS (Laerm)":
        noise = true;
        return "Noise";

      case "BMP180":
      case "BMP280":
        barometric = true;
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
        particulate = true;
        return "Particulate Matter";
      case "Radiation Si22G":
      case "Radiation SBM-19":
      case "Radiation SBM-20":
        radiation = true;
        return "Gamma radiation";

      case "DHT22":
      case "HTU21D":
      case "SHT31":
      case "SHT85":
      case "SHT35":
      case "SHT11":
      case "SCD30":
      case "GPS-NEO-6M":
        temperature = true;
        humidity = true;
        return "temperature and humidity";
      default:
        return "Unknown";
    }
  }
}
