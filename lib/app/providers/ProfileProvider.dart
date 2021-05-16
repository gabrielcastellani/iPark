import 'package:app_estacionamento/app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

class ProfileProvider extends ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserModel user = new UserModel();

  ProfileProvider() {
    _loadDataProfile();
  }

  Future<void> _loadDataProfile() async {

    final QuerySnapshot query =
        await _firebaseFirestore.collection('profile').get();

    List<UserModel> listUsers = query.docs.map((e) => UserModel.fromDocument(e)).toList();

    user = listUsers.firstWhere((r) => r.id == _firebaseAuth.currentUser.uid);
  }

  Future<void> create({UserModel myUser}) async {
    await _firebaseFirestore.collection('profile').add(myUser.toJson());
  }
}
