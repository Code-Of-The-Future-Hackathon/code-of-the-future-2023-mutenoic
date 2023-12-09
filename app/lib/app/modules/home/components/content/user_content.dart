import 'package:app/app/modules/sensors/views/sensors_view.dart';
import 'package:app/app/modules/weather/views/weather_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserContent extends StatelessWidget {
  const UserContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.sensors),
          title: const Text('Sensors'),
          onTap: () => Get.to(() => const SensorsView()),
        ),
        ListTile(
          leading: const Icon(Icons.cloud),
          title: const Text('Weather'),
          onTap: () => Get.to(() => const WeatherView()),
        ),
        // const Spacer(),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () {
            FirebaseAuth.instance.signOut();
          },
        ),
      ],
    );
  }
}
