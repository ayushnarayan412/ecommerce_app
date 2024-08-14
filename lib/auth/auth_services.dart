// ignore_for_file: use_build_context_synchronously

import 'package:ecommerce_app/auth/firebase_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthServices {
  static signupUser(
      String email, String password, String name, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);

      await FirebaseAuth.instance.currentUser!.verifyBeforeUpdateEmail(email);

      await FireStoreServices.saveUser(name, email, userCredential.user!.uid);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful')));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'password is too weak');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'email already provided');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  static signinUser(String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Fluttertoast.showToast(msg: 'login successful');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user not found') {
        Fluttertoast.showToast(msg: "no user found with this email");
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Enter correct password');
      }
    }
  }
}
