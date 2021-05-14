import 'package:cloud_firestore/cloud_firestore.dart';

class ParkingModel {
  ParkingModel(
      {this.name,
      this.phone,
      this.localization,
      this.numberParkingSpace,
      this.parkingSpaceValue,
      this.isRentable,
      this.isClosed,
      this.images});

  ParkingModel.fromDocument(DocumentSnapshot document) {
    name = document['name'] as String;
    localization = document['localization'] as GeoPoint;
    parkingSpaceValue = double.parse(document['parkingSpaceValue'].toString());
    numberParkingSpace = int.parse(document['numberParkingSpace'].toString());
    phone = document['phone'] as String;
  }

  String name;
  String phone;
  GeoPoint localization;
  int numberParkingSpace;
  double parkingSpaceValue;
  bool isClosed;
  bool isRentable;
  List<String> images;

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'localization': new GeoPoint(10, 10),
        'numberParkingSpace': numberParkingSpace,
        'parkingSpaceValue': parkingSpaceValue,
        'isRentable': isRentable,
        'isClosed': false
      };
}
