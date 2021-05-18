import 'package:app_estacionamento/app/common/custom_dialog/custom_dialog.dart';
import 'package:app_estacionamento/app/models/credit_card.dart';
import 'package:app_estacionamento/app/models/price_space.dart';
import 'package:app_estacionamento/app/providers/ProfileProvider.dart';
import 'package:app_estacionamento/app/services/cielo_payment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/cpf_field.dart';
import 'components/credit_card_widget.dart';

class PaymentCardPage extends StatelessWidget {
  PaymentCardPage(this.creditCard, this.priceSpace);

  final CieloPayment cieloPayment = new CieloPayment();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final CreditCardModel creditCard;
  final PriceSpaceModel priceSpace;

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
            createSizedBox(12),
            createSpaceField(),
            createSizedBox(4),
            createAssessmentField(),
            createSizedBox(4),
            createDiscountField(),
            createSizedBox(12),
            createTotalField(context),
            createSizedBox(12),
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
                onPressed: () async {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();

                    if (creditCard.id == null) {
                      CustomDialog(context, creditCard).show();
                    }

                    try {
                      String payId = await cieloPayment.authorize(
                        creditCardModel: creditCard,
                        priceSpaceModel: priceSpace,
                        orderId: '1',
                        user: context.read<ProfileProvider>().user,
                      );
                    } catch (e) {}
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget createSizedBox(double height) {
    return SizedBox(
      height: height,
    );
  }

  Widget createAssessmentField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const Text('Multa'),
        Text(
          'R\$ ' + priceSpace.assessment.toString(),
          style: TextStyle(color: Colors.red.withAlpha(200)),
        )
      ],
    );
  }

  Widget createDiscountField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const Text('Desconto'),
        Text(
          'R\$ ' + priceSpace.discount.toString(),
          style: TextStyle(color: Colors.green.withAlpha(200)),
        )
      ],
    );
  }

  Widget createTotalField(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Total',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        Text(
          'R\$ ' + priceSpace.getTotal().toString(),
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),
        )
      ],
    );
  }

  Widget createSpaceField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const Text('Vaga'),
        Text('R\$ ' + priceSpace.price.toString())
      ],
    );
  }
}
