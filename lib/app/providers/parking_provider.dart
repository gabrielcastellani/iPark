import 'package:app_estacionamento/app/models/parking_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ParkingProvider extends ChangeNotifier{
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List<ParkingModel> allParking = [];

  ParkingProvider() {
    _loadAllParking();
  }

  Future<void> _loadAllParking() async {
    final QuerySnapshot query =
        await _firebaseFirestore.collection('parkings').get();

    allParking = query.docs.map((e) => ParkingModel.fromDocument(e)).toList();

    notifyListeners();
  }

  Future<void> create({ParkingModel parking}) async {
    await _firebaseFirestore.collection('parkings').add(parking.toJson());
  }
}
