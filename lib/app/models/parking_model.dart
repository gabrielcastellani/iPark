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
      this.images,
      this.allRatings,
      this.rating}) {
    rating = rating ?? 0;
  }

  ParkingModel.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document['name'] as String;
    phone = document['phone'] as String;
    localization = document['localization'] as GeoPoint;
    numberParkingSpace = int.parse(document['numberParkingSpace'].toString());
    parkingSpaceValue = double.parse(document['parkingSpaceValue'].toString());
    isClosed = document['isClosed'] as bool;
    isRentable = document['isRentable'] as bool;
    images = List<String>.from(document['images']);
    rating = double.parse(document['rating'].toString());

    if (allRatings == null) allRatings = new List<double>();
    var numbersList = List.from(document['allRatings']);

    for (var d in numbersList) {
      var c = d as double;
      allRatings.add(c);
    }
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
  List<double> allRatings;
  double rating;

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'localization': localization,
        'numberParkingSpace': numberParkingSpace,
        'parkingSpaceValue': parkingSpaceValue,
        'isRentable': isRentable,
        'isClosed': false,
        'images': [],
        'rating': rating,
        'allRatings': allRatings,
      };
}
