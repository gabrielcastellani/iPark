import 'package:app_estacionamento/app/models/credit_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CreditCardProvider extends ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<CreditCardModel> getCreditCardByCurrentUser() async {
    var uid = _firebaseAuth.currentUser.uid;
    var creditCard = CreditCardModel();

    final QuerySnapshot query = await _firebaseFirestore
        .collection('creditCards')
        .where('uid', isEqualTo: uid)
        .get();

    notifyListeners();

    if (query.docs.length > 0) {
      creditCard = CreditCardModel.fromDocument(query.docs[0]);
    }

    return creditCard;
  }
}
