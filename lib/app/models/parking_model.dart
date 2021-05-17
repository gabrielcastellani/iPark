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
    id = document.id;
    name = document['name'] as String;
    phone = document['phone'] as String;
    localization = document['localization'] as GeoPoint;
    numberParkingSpace = int.parse(document['numberParkingSpace'].toString());
    parkingSpaceValue = double.parse(document['parkingSpaceValue'].toString());
    isClosed = document['isClosed'] as bool;
    isRentable = document['isRentable'] as bool;
<<<<<<< HEAD
    images = List<String>.from(document['images']);
=======
    images = List<String>.from(document['images'] as List<dynamic>); // Ajeitar
>>>>>>> efef854d657ad23671b77bbe5decb35951ee1ad1
  }

  String id;
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
        'localization': localization,
        'numberParkingSpace': numberParkingSpace,
        'parkingSpaceValue': parkingSpaceValue,
        'isRentable': isRentable,
        'isClosed': false,
        'images': []
      };
}
