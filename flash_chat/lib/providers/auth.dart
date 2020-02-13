import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../auth_exception.dart';

class Auth extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  FirebaseUser _user;

  Future<bool> isLoggedUser() async {
    _user = await _auth.currentUser();
    if (_user == null) {
      return false;
    }
    notifyListeners();
    return true;
  }

  FirebaseUser get user {
    if (_user != null) {
      return _user;
    }
    return null;
  }

  //signUp
  Future<FirebaseUser> createNewUserEmailandPassword({
    @required String email,
    @required String password,
  }) async {
    try {
      _user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
    } catch (e) {
      throw (CustomAuthException(e.toString()));
    }
    notifyListeners();
    return _user;
  }

  //SignIn or LogIn
  Future<String> loginUserWithEmailandPassword(
      {String email, String password}) async {
    try {
      await _auth.signOut();
      _user = (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
    } catch (e) {
      throw CustomAuthException(e.toString());
    }
    notifyListeners();
    if (_user != null) {
      return _user.email;
    }
    return null;
  }

  //Signout
  Future<String> signOut() async {
    String userEmail = _user.email;
    if (_user == null) {
      return null;
    }
    _user = null;
    _auth.signOut(); //TODO: try signing out without internet connection
    notifyListeners();
    return userEmail;
  }
}
