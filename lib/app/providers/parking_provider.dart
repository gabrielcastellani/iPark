import 'package:app_estacionamento/app/models/parking_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ParkingProvider {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List<ParkingModel> _allParking = [];

  ParkingProvider() {
    _loadAllParking();
  }

  Future<void> _loadAllParking() async {
    QuerySnapshot query = await _firebaseFirestore.collection('parkings').get();

    // _allParking = query.docs.map((e) => ParkingModel.fromDocument(e));
  }

  Future<void> create({ParkingModel parking}) async {
    await _firebaseFirestore.collection('parkings').add(parking.toJson());
  }
}
