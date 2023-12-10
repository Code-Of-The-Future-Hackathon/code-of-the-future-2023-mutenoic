import 'package:app/app/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatService {
  void joinChat(String chatId) {
    FirebaseFirestore.instance.collection("Users").doc(AuthService().getProfileInfo().uid).update({
      "chats": FieldValue.arrayUnion([chatId]),
      "people": FieldValue.increment(1),
    });
  }

  void sendMessage(String chatId, String message) {
    FirebaseFirestore.instance.collection("Chats").doc(chatId).collection("Messages").doc().set({
      "author": AuthService().getProfileInfo().uid,
      "message": message,
      "time": DateTime.now(),
    });
  }

  void reportChat(chatId) {
    FirebaseFirestore.instance.collection("Chats").doc(chatId).update({
      "reported": FieldValue.increment(1),
    });

    FirebaseFirestore.instance.collection("Chats").doc(chatId).get().then((value) {
      if (value.data()!["reported"] >= value.data()!["people"] / 2) {
        FirebaseFirestore.instance.collection("Chats").doc(chatId).delete();
      }
    });
  }
}
