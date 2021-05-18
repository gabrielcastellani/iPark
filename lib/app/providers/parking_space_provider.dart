import 'package:app_estacionamento/app/models/parking_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ParkingSpaceProvider extends ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List<ParkingModel> allParkingSpaces = [];

  ParkingSpaceProvider() {
    _loadAllParkingSpaces();
  }

  Future<void> _loadAllParkingSpaces() async {
    final QuerySnapshot query =
    await _firebaseFirestore.collection('parkings').get();

    allParkingSpaces = query.docs.map((e) => ParkingModel.fromDocument(e)).toList();

    notifyListeners();
  }

  Future<String> create({ParkingModel parking}) async {
    String id = "";
    await _firebaseFirestore
        .collection('parkings')
        .add(parking.toJson())
        .then((value) => id = value.id);
    return id;
  }
}
