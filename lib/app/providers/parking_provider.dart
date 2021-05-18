import 'package:app_estacionamento/app/models/parking_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ParkingProvider extends ChangeNotifier {
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

  Future<String> create({ParkingModel parking}) async {
    String id = "";
    await _firebaseFirestore
        .collection('parkings')
        .add(parking.toJson())
        .then((value) => id = value.id);
    return id;
  }

  Future<void> updateImages(ParkingModel parking, String parkingId) async {
    var ref = _firebaseFirestore.collection('parkings').doc(parkingId);
    await ref.update({'images': FieldValue.arrayUnion(parking.images)});
  }
}
