import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeoService {
  Future<LatLng?> getDeviceLocation() async {
    var sd = await Geolocator.checkPermission();

    if (sd == LocationPermission.denied) {
      sd = await Geolocator.requestPermission();
    }

    if (sd == LocationPermission.deniedForever) {
      return null;
    }

    var value = await Geolocator.getCurrentPosition();

    return LatLng(value.latitude, value.longitude);
  }
}
