import 'package:flutter/material.dart';

import 'components/credit_card_widget.dart';

class PaymentCardPage extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            CreditCardWidget(),
            button(context),
          ],
        ),
      ),
    );
  }

  Widget button(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextButton(
        child: const Text(
          'Salvar',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        style: TextButton.styleFrom(
          backgroundColor: Colors.red,
          padding: EdgeInsets.all(16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: () {
          if (formKey.currentState.validate()) {
            print('Enviar');
          }
        },
      ),
    );
  }
}
