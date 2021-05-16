import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({this.email, this.password, this.name, this.cpf, this.kind});

  UserModel.fromDocument(DocumentSnapshot document) {
    name = document['name'] as String;
    email = document['email'] as String;
    password = document['password'] as String;
    cpf = document['cpf'] as String;
    kind = document['kind'] as String;
  }

  String id;
  String name;
  String email;
  String password;
  String confirmPassword;
  String cpf;
  String img;
  String kind;

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'cpf': cpf,
        'kind': kind,
      };
}
