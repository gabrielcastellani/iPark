import 'package:app_estacionamento/app/models/tipopessoa_model.dart';

class UserModel {
  UserModel({this.email, this.password, this.name});

  String name;
  String email;
  String password;
  String confirmPassword;
  //String tipoPessoa;
}
