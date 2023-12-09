import 'package:app/main.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:weather_icons/weather_icons.dart';

import '../controllers/weather_controller.dart';

class WeatherView extends GetView<WeatherController> {
  const WeatherView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut<WeatherController>(() => WeatherController());
    controller;
    return Scaffold(
      appBar: AppBar(),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Now",
                          style: TextStyle(fontSize: 17),
                        ),
                        Row(
                          children: [
                            Text(
                              "${(controller.current["temperature_2m"] as double).round()}°",
                              style: const TextStyle(fontSize: 50),
                            ),
                            BoxedIcon(
                              controller.icon.value,
                              size: 50,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      controller.current["weather_code"].toString(),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
