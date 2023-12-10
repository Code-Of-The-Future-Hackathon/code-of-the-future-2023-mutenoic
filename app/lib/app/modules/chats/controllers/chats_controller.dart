import 'package:app/app/modules/chat_details/bindings/chat_details_binding.dart';
import 'package:app/app/modules/chat_details/views/chat_details_view.dart';
import 'package:app/app/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatsController extends GetxController {
  //TODO: Implement ChatsController
  Stream<DocumentSnapshot<Map<String, dynamic>>> getChats() {
    return FirebaseFirestore.instance.collection("Users").doc(AuthService().getProfileInfo().uid).snapshots();
  }

  void openChat(param0) {
    Get.to(() => const ChatDetailsView(), arguments: {
      "chatId": param0,
    });
  }
}
