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

    user.img = 'https://media-exp1.licdn.com/dms/image/C5603AQGXEg7Ec14L1w/profile-displayphoto-shrink_200_200/0/1597960710114?e=1624492800&v=beta&t=KcDjytYLR4tOop7FIQ8jZBfIdj0G5nrojiRqX2Ap-kI';
  }

  Future<void> create({UserModel myUser}) async {
    await _firebaseFirestore.collection('profile').add(myUser.toJson());
  }
}
