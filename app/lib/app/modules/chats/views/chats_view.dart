import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/chats_controller.dart';

class ChatsView extends GetView<ChatsController> {
  const ChatsView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut<ChatsController>(() => ChatsController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: controller.getChats(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!["chats"] == null || snapshot.data!["chats"].length == 0) {
              return const Center(
                child: Text("No chats yet"),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!["chats"].length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("Chat ${index + 1}"),
                  onTap: () => controller.openChat(snapshot.data!["chats"][index]),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
