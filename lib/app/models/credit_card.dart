import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credit_card_type_detector/credit_card_type_detector.dart';

class CreditCardModel {
  String uid;
  String number;
  String holder;
  String expirationDate;
  String securityCode;
  String brand;

  CreditCardModel.fromDocument(DocumentSnapshot document) {
    uid = document['uid'] as String;
    number = document['number'] as String;
    holder = document['holder'] as String;
    expirationDate = document['expirationDate'] as String;
  }

  void setHolder(String name) => holder = name;

  void setExpirationDate(String date) => expirationDate = date;

  void setCVV(String cvv) => securityCode = cvv;

  void setNumber(String number) {
    this.number = number;
    brand = detectCCType(number.replaceAll(' ', '')).toString();
  }

  @override
  String toString() {
    return 'CreditiCard{number: $number, holder: $holder, expirationDate: $expirationDate, securityCode: $securityCode, brand: $brand}';
  }
}
