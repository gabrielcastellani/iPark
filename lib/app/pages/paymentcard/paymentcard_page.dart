import 'package:app_estacionamento/app/models/credit_card.dart';
import 'package:flutter/material.dart';

import 'components/cpf_field.dart';
import 'components/credit_card_widget.dart';

class PaymentCardPage extends StatelessWidget {
  PaymentCardPage(this.creditCard);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final CreditCardModel creditCard;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            CreditCardWidget(creditCard),
            CpfField(),
            cardPrice(context),
          ],
        ),
      ),
    );
  }

  Widget cardPrice(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Resumo do pagamento',
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[const Text('Vaga'), Text('R\$ 5.00')],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[const Text('Multa'), Text('R\$ 0.00')],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[const Text('Desconto'), Text('R\$ 0.00')],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Total',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  'R\$ 5.00',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 16),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextButton(
                child: const Text(
                  'Pagar',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    print(creditCard);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
