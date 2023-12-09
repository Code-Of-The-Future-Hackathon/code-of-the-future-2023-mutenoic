class SensorDataValue {
  // {
  //       "id": 41443085259,
  //       "value": "7.31",
  //       "value_type": "P1"
  //     },

  int? id;
  double value = 0;
  String valueType;

  SensorDataValue(this.id, this.value, this.valueType);
}
