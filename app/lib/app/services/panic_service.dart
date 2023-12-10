import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class PanicService {
  Future<void> sendPanic() async {
    bool? confirm = await showDialog<bool>(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: const Text("Panic"),
        content: const Text("Are you sure you want to send a panic message?"),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text("Confirm"),
          ),
        ],
      ).animate().scaleXY(
            curve: Curves.easeInOutCubicEmphasized,
            duration: const Duration(milliseconds: 600),
          ),
    );

    if (confirm != null && confirm) {
      Get.snackbar(
        "Panic",
        "Panic message sent!",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red[200],
        colorText: Colors.black,
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(15),
        borderRadius: 15,
        icon: const Icon(Icons.warning),
      );
    }
  }
}
