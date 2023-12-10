import 'package:app/app/services/auth_service.dart';
import 'package:app/app/services/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/chat_details_controller.dart';

class ChatDetailsView extends GetView<ChatDetailsController> {
  const ChatDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut<ChatDetailsController>(() => ChatDetailsController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              // Report
              ChatService().reportChat(controller.chatId);
              HapticFeedback.mediumImpact();
            },
            icon: const Icon(Icons.report),
          ),
        ],
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Chats")
                .doc(controller.chatId)
                .collection("Messages")
                .orderBy(
                  "timestamp",
                  descending: false,
                )
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Expanded(
                child: ListView.builder(
                  controller: controller.listController,
                  itemCount: snapshot.data!.docs.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    return Align(
                      alignment:
                          snapshot.data!.docs.reversed.toList()[index]["sender"] == AuthService().getProfileInfo().uid
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: snapshot.data!.docs.reversed.toList()[index]["sender"] ==
                                  AuthService().getProfileInfo().uid
                              ? Theme.of(context).colorScheme.primaryContainer
                              : const Color.fromARGB(255, 121, 101, 101),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(snapshot.data!.docs.reversed.toList()[index]["message"]),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          const Divider(),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: controller.messageController,
                    decoration: const InputDecoration(
                      hintText: "Type a message",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  controller.sendMessage();
                },
                icon: const Icon(Icons.send),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          ),
        ],
      ),
    );
  }
}
