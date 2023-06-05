import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  static final auth = FirebaseAuth.instance;
  static User? user = auth.currentUser;

  // Signin process
  static Future<bool?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        Fluttertoast.showToast(
          msg: "The user not found.",
          backgroundColor: Colors.red,
        );
      } else if (error.code == 'invalid-email' ||
          error.code == 'wrong-password') {
        Fluttertoast.showToast(
          msg: 'The Username or password is invalid',
          backgroundColor: Colors.red,
        );
      }
      return false;
    }
  }

  // signup process
  static Future<bool?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        Fluttertoast.showToast(
          msg: "The password provided is too weak.",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
        );
      } else if (error.code == 'email-already-in-use') {
        Fluttertoast.showToast(
          msg: "Entered email already in use",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
        );
      } else if (error.code == 'invalid-email') {
        Fluttertoast.showToast(
          msg: "Invalid email",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
        );
      }
      return false;
    }
  }

  // signout
  static Future<void> logout() async {
    return auth.signOut();
  }
}
