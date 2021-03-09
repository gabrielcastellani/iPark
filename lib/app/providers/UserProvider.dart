import 'package:app_estacionamento/app/helpers/firebase_errors.dart';
import 'package:app_estacionamento/app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class UserProvider {
  FirebaseAuth _firebaseAuth;

  UserProvider() {
    _firebaseAuth = FirebaseAuth.instance;
  }

  Future<void> signIn(
      {UserModel user, Function onFail, Function onSucess}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: user.email, password: user.password);

      onSucess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
  }
}
