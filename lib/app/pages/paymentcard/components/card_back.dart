import 'package:app_estacionamento/app/models/credit_card.dart';
import 'package:app_estacionamento/app/pages/paymentcard/components/card_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardBack extends StatelessWidget {
  const CardBack({this.creditCard, this.cvvFocus, this.finished});

  final FocusNode cvvFocus;
  final CreditCardModel creditCard;
  final VoidCallback finished;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 16,
      child: Container(
        height: 200,
        color: const Color(0xFF1B4B52),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.black,
              height: 40,
              margin: const EdgeInsets.symmetric(vertical: 16),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 70,
                  child: Container(
                    color: Colors.grey[500],
                    margin: const EdgeInsets.only(left: 12),
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: CardTextField(
                      hint: '123',
                      maxLength: 3,
                      textAlign: TextAlign.end,
                      textInputType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (cvv) {
                        if (cvv.length != 3) return 'Inválido';
                        return null;
                      },
                      onSubmitted: (_) {
                        finished();
                      },
                      focusNode: cvvFocus,
                      onSaved: creditCard.setCVV,
                    ),
                  ),
                ),
                Expanded(
                  flex: 30,
                  child: Container(),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
