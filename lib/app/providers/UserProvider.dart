import 'package:app_estacionamento/app/helpers/firebase_errors.dart';
import 'package:app_estacionamento/app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class UserProvider extends ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  bool _loading = false;
  bool get isLoading => _loading;

  User _user;
  User get user => _user;

  UserProvider() {
    _loadCurrentUser();
  }

  Future<void> signIn(
      {UserModel user, Function onFail, Function onSucess}) async {
    loading = true;

    try {
      UserCredential result = await firebaseAuth.signInWithEmailAndPassword(
          email: user.email, password: user.password);

      _user = result.user;

      onSucess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }

    loading = false;
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser() async {
    User currentUser = firebaseAuth.currentUser;

    if (currentUser != null) {
      _user = currentUser;
    }

    notifyListeners();
  }
}
