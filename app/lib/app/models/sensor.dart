import 'package:app/app/models/sensor_type.dart';

class Sensor {
  // "sensor": {
  //     "id": 253,
  //     "pin": "1",
  //     "sensor_type": {
  //       "id": 14,
  //       "name": "SDS011",
  //       "manufacturer": "Nova Fitness"
  //     }
  //   },

  int id;
  String pin;
  SensorType sensorType;

  Sensor(this.id, this.pin, this.sensorType);
}
