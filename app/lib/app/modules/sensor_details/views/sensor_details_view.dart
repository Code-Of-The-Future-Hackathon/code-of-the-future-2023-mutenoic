import 'package:app/app/components/map_switcher.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/sensor_details_controller.dart';

class SensorDetailsView extends GetView<SensorDetailsController> {
  const SensorDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut<SensorDetailsController>(() => SensorDetailsController());
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Sensor ID: ${controller.info.id}\n${controller.info.sensor.sensorType.name}',
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 300,
                width: Get.width / 1.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  clipBehavior: Clip.hardEdge,
                  child: MapSwitcher(
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: controller.latlng,
                        zoom: 15,
                      ),

                      markers: {
                        Marker(
                          markerId: MarkerId(controller.info.id.toString()),
                          position: controller.latlng,
                        )
                      },
                      liteModeEnabled: true,
                      zoomControlsEnabled: false,
                      compassEnabled: false,
                      myLocationButtonEnabled: false,
                      myLocationEnabled: true,
                      rotateGesturesEnabled: false,
                      // onMapCreated: controller.homeController.onMapCreated,
                      // markers: controller.markers.toSet(),
                      // onMapCreated: controller.onMapCreated,
                      mapToolbarEnabled: false,
                    ),
                  ),
                ),
              ),
              Text("Sensor name: ${controller.info.sensor.sensorType.name}"),
              Text("Sensor manufacturer: ${controller.info.sensor.sensorType.manufacturer}"),
              Text("Sensor type: ${controller.categorizeSensor(controller.info.sensor.sensorType.name.trim())}"),
              for (var i in controller.info.sensorDataValues)
                Text(
                    "${i.valueType.split('_').join(' ').capitalize} - ${i.value} ${controller.valueType(i.valueType.split('_').first)}"),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: BarChart(
                        BarChartData(
                          minY: 0,
                          maxY: 100,
                          titlesData: const FlTitlesData(
                            bottomTitles: AxisTitles(
                              axisNameWidget: Text(
                                "Humidity",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          barGroups: [
                            BarChartGroupData(
                              x: controller.info.sensorDataValues[0].value.toInt(),
                              barRods: [
                                BarChartRodData(fromY: 0, toY: controller.info.sensorDataValues[0].value),
                              ],
                              groupVertically: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (controller.temperature) barChartSensor(),
                    Expanded(
                      child: BarChart(
                        BarChartData(
                          minY: 0,
                          maxY: controller.info.sensorDataValues[1].value.toInt() + 10000,
                          titlesData: const FlTitlesData(
                            bottomTitles: AxisTitles(
                              axisNameWidget: Text(
                                "Pressure",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          barGroups: [
                            BarChartGroupData(
                              x: controller.info.sensorDataValues[1].value.toInt(),
                              barRods: [
                                BarChartRodData(fromY: 0, toY: controller.info.sensorDataValues[1].value),
                              ],
                              groupVertically: true,
                            ),
                            BarChartGroupData(
                              x: controller.info.sensorDataValues[3].value.toInt(),
                              barRods: [
                                BarChartRodData(fromY: 0, toY: controller.info.sensorDataValues[3].value),
                              ],
                              groupVertically: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom + 15,
              ),
            ],
          ),
        ));
  }

  Expanded barChartSensor({
    String title = "Temperature",
    String unit = "°C",
    double min = -256,
    double max = 100,
    double value = 0,
  }) {
    var sensorDataValues = controller.info.sensorDataValues
        .where((el) => el.valueType.toLowerCase().split("_").join(" ") == title.toLowerCase());
    var value = sensorDataValues.first.value;
    return Expanded(
      child: BarChart(
        BarChartData(
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              axisNameWidget: Text(
                title,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
          minY: value,
          maxY: value + 10,
          barGroups: [
            BarChartGroupData(
              x: controller.info.sensorDataValues[2].value.toInt(),
              barRods: [
                BarChartRodData(
                  fromY: -256,
                  toY: controller.info.sensorDataValues[2].value,
                ),
              ],
              groupVertically: true,
            ),
          ],
        ),
      ),
    );
  }
}
