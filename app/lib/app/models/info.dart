import 'package:app/app/models/location.dart';
import 'package:app/app/models/sensor.dart';

import 'sensor_data_values.dart';

class Info {
  // id": 18289642104,
  //   "sampling_rate": null,
  //   "timestamp": "2023-12-08 15:22:32",
  //   "location": {
  //     "id": 590,
  //     "latitude": "48.772",
  //     "longitude": "8.846",
  //     "altitude": "390.3",
  //     "country": "DE",
  //     "exact_location": 0,
  //     "indoor": 0
  //   },
  //   "sensor": {
  //     "id": 253,
  //     "pin": "1",
  //     "sensor_type": {
  //       "id": 14,
  //       "name": "SDS011",
  //       "manufacturer": "Nova Fitness"
  //     }
  //   },
  //   "sensordatavalues": [
  //     {
  //       "id": 41443085259,
  //       "value": "7.31",
  //       "value_type": "P1"
  //     },
  //     {
  //       "id": 41443085264,
  //       "value": "6.92",
  //       "value_type": "P2"
  //     }
  //   ]

  int id;
  int? samplingRate;
  DateTime timestamp;
  Location location;
  Sensor sensor;
  List<SensorDataValue> sensorDataValues;

  Info(this.id, this.samplingRate, this.timestamp, this.location, this.sensor, this.sensorDataValues);
}
