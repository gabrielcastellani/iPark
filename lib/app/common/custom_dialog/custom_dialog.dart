import 'package:app_estacionamento/app/models/credit_card.dart';
import 'package:app_estacionamento/app/providers/credit_card_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDialog {
  CustomDialog(this.context, this.creditCardModel);

  BuildContext context;
  CreditCardModel creditCardModel;

  Future<void> show() async {
    return showDialog<void>(
      context: this.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Prezado cliente,'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Gostaria de salvar esse cartão para pagamentos futuros?')
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Sim'),
              onPressed: () async {
                await this
                    .context
                    .read<CreditCardProvider>()
                    .createCreditCardForCurrentUser(
                        creditCardModel: creditCardModel,
                        onSucess: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Cartão cadastrado com sucesso!'),
                            backgroundColor: Colors.green[800],
                          ));
                        },
                        onFail: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text('Não foi possível cadastrar o cartão'),
                            backgroundColor: Colors.red,
                          ));
                        });

                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Não'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
