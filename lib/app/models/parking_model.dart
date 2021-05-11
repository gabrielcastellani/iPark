import 'package:cloud_firestore/cloud_firestore.dart';

class ParkingModel {
  ParkingModel({this.name, this.description, this.phone});

  ParkingModel.fromDocument(DocumentSnapshot document) {
    name = document['name'] as String;
    localization = document['localization'] as GeoPoint;
    parkingSpaceValue = double.parse(document['parkingSpaceValue'].toString());
    // openHour = document['openDate'] as DateTime;
    // closeHour = document['closeDate'] as DateTime;
    // localization = document['localization'] as GeoPoint;
    // numberParkingSpace = document['numberParkingSpace'] as int;
    // parkingSpaceValue = document['parkingSpaceValue'] as double;
    // isClosed = document['isClosed'] as bool;
    // isHourlyValue = document['isHourlyValue'] as bool;
    // images = List<String>.from(document['images'] as List<dynamic>);
  }

  String name;
  String description;
  String phone;
  DateTime openHour;
  DateTime closeHour;
  GeoPoint localization;
  int numberParkingSpace;
  double parkingSpaceValue;
  bool isClosed;
  bool isHourlyValue;
  List<String> images;

  Map<String, dynamic> toJson() => {
        'name': name,
        'localization': new GeoPoint(10, 10),
        'parkingSpaceValue': parkingSpaceValue
      };
}
