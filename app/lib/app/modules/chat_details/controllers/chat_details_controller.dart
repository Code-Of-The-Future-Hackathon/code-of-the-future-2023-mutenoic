import 'package:app/app/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatDetailsController extends GetxController {
  final chatId = Get.arguments["chatId"];
  final messageController = TextEditingController();

  final listController = ScrollController();

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages() {
    return FirebaseFirestore.instance
        .collection("Chats")
        .doc(chatId)
        .collection("Messages")
        .orderBy(
          "timestamp",
          descending: false,
        )
        .snapshots();
  }

  Future<void> sendMessage() async {
    if (messageController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("Chats").doc(chatId).collection("Messages").add({
        "message": messageController.text,
        "sender": AuthService().getProfileInfo().uid,
        "timestamp": Timestamp.now(),
      });
      messageController.clear();

      // listController.animateTo(
      //   listController.position.maxScrollExtent,
      //   duration: const Duration(milliseconds: 300),
      //   curve: Curves.easeOut,
      // );
    }
  }
}
