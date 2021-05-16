import 'package:app_estacionamento/app/models/credit_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class CreditCardProvider extends ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final String COLLECTION_NAME = 'creditCards';

  Future<CreditCardModel> getCreditCardByCurrentUser() async {
    var uid = _firebaseAuth.currentUser.uid;
    var creditCard = CreditCardModel();

    final QuerySnapshot query = await _firebaseFirestore
        .collection(COLLECTION_NAME)
        .where('uid', isEqualTo: uid)
        .get();

    notifyListeners();

    if (query.docs.length > 0) {
      creditCard = CreditCardModel.fromDocument(query.docs[0]);
    }

    return creditCard;
  }

  Future<void> createCreditCardForCurrentUser(
      {CreditCardModel creditCardModel,
      Function onSucess,
      Function onFail}) async {
    try {
      var uid = _firebaseAuth.currentUser.uid;
      creditCardModel.uid = uid;

      await _firebaseFirestore
          .collection(COLLECTION_NAME)
          .add(creditCardModel.toJson());

      onSucess();
    } on PlatformException catch (e) {
      onFail(e.message);
    }
  }
}
