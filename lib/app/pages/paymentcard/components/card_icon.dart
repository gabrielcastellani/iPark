import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardIcon extends StatelessWidget {
  CardIcon(this._creditCardType, this._iconSize);

  final double _iconSize;
  final CreditCardType _creditCardType;

  @override
  Widget build(BuildContext context) {
    switch (_creditCardType) {
      case CreditCardType.visa:
        return visa();
      case CreditCardType.amex:
        return amex();
      case CreditCardType.mastercard:
        return masterCard();
      case CreditCardType.discover:
        return discover();
      default:
        return Container(color: Color(0x00000000));
    }
  }

  Widget visa() {
    return FaIcon(
      FontAwesomeIcons.ccVisa,
      size: _iconSize,
      color: Color(0xffffffff),
    );
  }

  Widget amex() {
    return FaIcon(
      FontAwesomeIcons.ccAmex,
      size: _iconSize,
      color: Color(0xffffffff),
    );
  }

  Widget masterCard() {
    return FaIcon(
      FontAwesomeIcons.ccMastercard,
      size: _iconSize,
      color: Color(0xffffffff),
    );
  }

  Widget discover() {
    return FaIcon(
      FontAwesomeIcons.ccDiscover,
      size: _iconSize,
      color: Color(0xffffffff),
    );
  }
}
