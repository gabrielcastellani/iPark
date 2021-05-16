import 'package:app_estacionamento/app/models/credit_card.dart';
import 'package:app_estacionamento/app/pages/paymentcard/components/card_back.dart';
import 'package:app_estacionamento/app/pages/paymentcard/components/card_front.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class CreditCardWidget extends StatelessWidget {
  CreditCardWidget(this.creditCard);

  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  final FocusNode numberFocus = FocusNode();
  final FocusNode dateFocus = FocusNode();
  final FocusNode nameFocus = FocusNode();
  final FocusNode cvvFocus = FocusNode();

  final CreditCardModel creditCard;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FlipCard(
            key: cardKey,
            direction: FlipDirection.HORIZONTAL,
            speed: 700,
            flipOnTouch: false,
            front: CardFront(
              creditCard: creditCard,
              numberFocus: numberFocus,
              dateFocus: dateFocus,
              nameFocus: nameFocus,
              finished: () {
                cardKey.currentState.toggleCard();
                cvvFocus.requestFocus();
              },
            ),
            back: CardBack(
              creditCard: creditCard,
              cvvFocus: cvvFocus,
            ),
          ),
          TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              onPressed: () {
                cardKey.currentState.toggleCard();
              },
              child: const Text('Virar cartão')),
        ],
      ),
    );
  }
}
