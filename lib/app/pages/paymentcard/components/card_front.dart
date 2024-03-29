import 'package:app_estacionamento/app/models/credit_card.dart';
import 'package:app_estacionamento/app/pages/paymentcard/components/card_icon.dart';
import 'package:app_estacionamento/app/pages/paymentcard/components/card_text_field.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CardFront extends StatelessWidget {
  CardFront(
      {this.creditCard,
      this.numberFocus,
      this.dateFocus,
      this.nameFocus,
      this.finished});

  final MaskTextInputFormatter dateFormatter = MaskTextInputFormatter(
      mask: '!#/####', filter: {'#': RegExp('[0-9]'), '!': RegExp('[0-1]')});

  final FocusNode numberFocus;
  final FocusNode dateFocus;
  final FocusNode nameFocus;

  final VoidCallback finished;

  final CreditCardModel creditCard;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 16,
      child: Container(
        height: 200,
        color: const Color(0xFF1B4B52),
        padding: const EdgeInsets.all(24),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  CardTextField(
                    title: 'Número',
                    hint: '0000 0000 0000 0000',
                    textInputType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CartaoBancarioInputFormatter()
                    ],
                    validator: (number) {
                      if (number.length != 19)
                        return 'Inválido';
                      else if (detectCCType(number) == CreditCardType.unknown)
                        return 'Inválido';
                      return null;
                    },
                    onSubmitted: (_) {
                      dateFocus.requestFocus();
                    },
                    focusNode: numberFocus,
                    onSaved: creditCard.setNumber,
                    initialValue: creditCard != null ? creditCard.number : '',
                    bold: true,
                  ),
                  CardTextField(
                    title: 'Validade',
                    hint: '11/2020',
                    textInputType: TextInputType.number,
                    inputFormatters: [
                      dateFormatter,
                    ],
                    validator: (date) {
                      if (date.length != 7) return 'Inválido';
                      return null;
                    },
                    onSubmitted: (_) {
                      nameFocus.requestFocus();
                    },
                    focusNode: dateFocus,
                    onSaved: creditCard.setExpirationDate,
                    initialValue:
                        creditCard != null ? creditCard.expirationDate : '',
                  ),
                  CardTextField(
                    title: 'Titular',
                    hint: 'João da Silva',
                    textInputType: TextInputType.text,
                    validator: (name) {
                      if (name.isEmpty) return 'Inválido';
                      return null;
                    },
                    onSubmitted: (_) {
                      finished();
                    },
                    focusNode: nameFocus,
                    onSaved: creditCard.setHolder,
                    initialValue: creditCard != null ? creditCard.holder : '',
                    bold: true,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Icon(
                    Icons.credit_card,
                    color: Colors.white.withAlpha(100),
                    size: 40,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
