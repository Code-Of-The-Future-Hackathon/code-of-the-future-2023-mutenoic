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

  static Map<String, LatLng> regions = {
    "Видин": const LatLng(43.9796788, 22.8361745),
    "Монтана": const LatLng(43.4142573, 23.1862031),
    "Враца": const LatLng(43.2074399, 23.5081144),
    "Плевен": const LatLng(43.4212324, 24.5733336),
    "Ловеч": const LatLng(43.1445293, 24.669845),
    "Велико Търново": const LatLng(43.0840923, 25.4772306),
    "Габрово": const LatLng(42.8490305, 25.2428752),
    "Русе": const LatLng(43.8217113, 25.8773911),
    "Тарговище": const LatLng(43.2566209, 26.4854426),
    "Разград": const LatLng(43.5297294, 26.5085427),
    "Силистра": const LatLng(44.1112406, 27.234157),
    "Добрич": const LatLng(43.5752939, 27.6560285),
    "Варна": const LatLng(43.2049731, 27.7780994),
    "Шумен": const LatLng(43.2697708, 26.8180391),
    "Перник": const LatLng(42.5963485, 23.010248),
    "Кюстендил": const LatLng(42.2867362, 22.6727961),
    "София-град": const LatLng(42.6545373, 23.0353193),
    "Пазарджик": const LatLng(42.1887991, 24.2524007),
    "Пловдив": const LatLng(42.1442187, 24.6584732),
    "Стара Загора": const LatLng(42.4193111, 25.5836621),
    "Сливен": const LatLng(42.6654771, 26.2426619),
    "Ямбол": const LatLng(42.4771955, 26.46175),
    "Бургас": const LatLng(42.5061, 27.4678),
    "Благоевград": const LatLng(42.0138205, 23.0168014),
    "Смолян": const LatLng(41.5791427, 24.6999554),
    "Кърджали": const LatLng(41.6288288, 25.3414993),
    "Хасково": const LatLng(41.9328333, 25.5074588),
  };
}
