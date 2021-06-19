import 'dart:io';
import 'package:app_estacionamento/app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

class ProfileProvider extends ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserModel user = new UserModel();
  List<UserModel> allUsers = [];

  ProfileProvider() {
    _loadDataProfile();
  }

  Future<void> _loadDataProfile() async {
    var uid = _firebaseAuth.currentUser.uid;

    final QuerySnapshot query1 = await _firebaseFirestore
        .collection('profile')
        .where('id', isEqualTo: uid)
        .get();
    notifyListeners();
    if (query1.docs.length > 0) {
      user = UserModel.fromDocument(query1.docs.first);
    }
  }

  Future<void> create({UserModel myUser}) async {
    await _firebaseFirestore.collection('profile').add(myUser.toJson());
  }

  Future<void> updateAllProperties({UserModel myUser}) async {
    var ref = _firebaseFirestore.collection('profile').doc(myUser.id);
    await ref.update({
      'name': myUser.name,
      'email': myUser.email,
      'cpf': myUser.cpf,
      'kind': myUser.kind
    });
  }

  Future<void> getImagesUrls(String userID) async {
    var image = user.img;

    var storageRef = FirebaseStorage.instance.ref();
    var imageRef = storageRef.child("images/$userID/img.jpg");
    var file = File(image);
    var upload = imageRef.putFile(file);
    var path = "";

    await upload.then((snapshot) =>
        snapshot.ref.getDownloadURL().then((value) => path = value));

    user.img = path;
  }

  Future<void> updateImages(UserModel userModel) async {
    var ref = _firebaseFirestore.collection('profile').doc(userModel.id);
    await ref.update({'img': userModel.img.toString()});
  }
}
