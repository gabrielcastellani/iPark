import 'dart:collection';

import 'package:app_estacionamento/app/models/credit_card.dart';
import 'package:app_estacionamento/app/models/price_space.dart';
import 'package:app_estacionamento/app/models/user_model.dart';
import 'package:cloud_functions/cloud_functions.dart';

class CieloPayment {
  final FirebaseFunctions functions = FirebaseFunctions.instance;

  Future<String> authorize(
      {CreditCardModel creditCardModel,
      PriceSpaceModel priceSpaceModel,
      String orderId,
      UserModel user}) async {
    try {
      final Map<String, dynamic> dataSale = {
        'merchantOrderId': orderId,
        'amount': (priceSpaceModel.getTotal() * 100).toInt(),
        'softDescriptor': 'iPark',
        'installments': 1,
        'creditCard': creditCardModel.toJsonCielo(),
        'cpf': user.cpf,
        'paymentType': 'CreditCard',
      };

      final HttpsCallable callable = functions.httpsCallable('authorizeCC');
      final response = await callable.call(dataSale);
      final data = Map<String, dynamic>.from(response.data as LinkedHashMap);

      if (data['success'] as bool) {
        return data['paymentId'] as String;
      } else {
        return Future.error(data['error']['message']);
      }
    } catch (e) {
      return Future.error('Falha ao processar transação. Tente novamente.');
    }
  }

  Future<void> capture(String payId) async {
    final Map<String, dynamic> captureData = {'payId': payId};
    final HttpsCallable callable = functions.httpsCallable('captureCC');
    final response = await callable.call(captureData);
    final data = Map<String, dynamic>.from(response.data as LinkedHashMap);

    if (data['success'] as bool) {
      return;
    } else {
      return Future.error(data['error']['message']);
    }
  }

  Future<void> cancel(String payId) async {
    final Map<String, dynamic> cancelData = {'payId': payId};
    final HttpsCallable callable = functions.httpsCallable('cancelCC');
    final response = await callable.call(cancelData);
    final data = Map<String, dynamic>.from(response.data as LinkedHashMap);

    if (data['success'] as bool) {
      return;
    } else {
      return Future.error(data['error']['message']);
    }
  }
}
