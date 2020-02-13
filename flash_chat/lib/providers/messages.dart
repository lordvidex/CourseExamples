import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends ChangeNotifier {
  Messages({this.user});
  final FirebaseUser user;
  final _db = Firestore.instance;

  Stream<QuerySnapshot> messageStream() {
    return _db.collection('chats').orderBy("time").snapshots();
  }
  String get userEmail{
    return user.email;
  }
  Future<void> sendMessage(String message) async {
    return await _db.collection('chats').add({
      'email': user.email,
      'message': message,
      'time':DateTime.now().toIso8601String(),
    });
  }
}
