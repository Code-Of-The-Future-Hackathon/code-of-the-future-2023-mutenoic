import 'package:app/app/api/firebase_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Login function
  Future<bool> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      print("Login error: $e");
      return false;
    }
  }

  // Register function
  Future<bool> register(String email, String password, Map<String, dynamic> data) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseFirestore.instance.collection("Users").doc(_auth.currentUser!.uid).set(data);
      FirebaseApi().initNotifications();
      return true;
    } catch (e) {
      print("Registration error: $e");
      return false;
    }
  }

  // Forgot password function
  Future<bool> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print("Forgot password error: $e");
      return false;
    }
  }

  User getProfileInfo() {
    return FirebaseAuth.instance.currentUser!;
  }

  // update data
  Future<DocumentReference> updateData(Map<String, dynamic> data) async {
    return await FirebaseFirestore.instance.collection("Users").add(data);
  }
}
