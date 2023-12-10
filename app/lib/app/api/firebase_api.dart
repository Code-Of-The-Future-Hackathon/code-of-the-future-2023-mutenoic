import 'dart:async';

import 'package:app/app/modules/map/controllers/map_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FirebaseApi {
  final firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotifications() async {
    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    final fCMToken = await firebaseMessaging.getToken();
    print(fCMToken);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

// FOREGROUND

    FirebaseMessaging.onMessage.listen((message) {
      print('Title: ${message.notification?.title}');
      print('Body: ${message.notification?.body}');
      print('Payload: ${message.data}');

      if (message.data['emergency'] == 'true') {
        Get.find<MapController>().markers.add(
              Marker(
                markerId: MarkerId(message.data['lat']),
                position: LatLng(
                  double.parse(message.data['lat']),
                  double.parse(message.data['long']),
                ),
              ),
            );
        Get.find<MapController>().onEmergency(
          LatLng(
            double.parse(message.data['lat']),
            double.parse(message.data['long']),
          ),
        );
      }

      Get.snackbar(
        message.notification?.title ?? '',
        message.notification?.body ?? '',
        duration: const Duration(seconds: 5),
        snackPosition: SnackPosition.TOP,
      );
    });
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Payload: ${message.data}');
  }
}
