import 'package:credit_card_type_detector/credit_card_type_detector.dart';

class CreditCardModel {
  String number;
  String holder;
  String expirationDate;
  String securityCode;
  String brand;

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
