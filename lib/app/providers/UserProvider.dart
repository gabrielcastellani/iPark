import 'package:app_estacionamento/app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class UserProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> connect(
      {UserModel user, Function onFail, Function onSucess}) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
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

      user.id = _firebaseAuth.currentUser.uid;
      var createdProfile = await _firebaseFirestore.collection('profile').add(user.toJson());




      onSucess();
    } on PlatformException catch (e) {
      onFail(e.message);
    }
  }
}
