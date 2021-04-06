import 'package:app_estacionamento/app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class UserProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> connect(
      {UserModel user, Function onFail, Function onSucess}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: user.email, password: user.password);

      onSucess();
    } on PlatformException catch (e) {
      onFail(e.message);
    }
  }

  Future<void> createNewUser(
      {UserModel user, Function onFail, Function onSucess}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);

      onSucess();
    } on PlatformException catch (e) {
      onFail(e.message);
    }
  }
}
