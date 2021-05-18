import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({this.email, this.password, this.name, this.cpf, this.kind});

  UserModel.fromDocument(DocumentSnapshot document) {
    this.id = document['id'] as String;
    this.name = document['name'] as String;
    this.email = document['email'] as String;

    // print(document.data().keys);
    this.profileID = document['profileID'] as String;
    print(name);

    if (document.get('img') != null) {
      this.img = document['img'];
    }

    if (document.get('cpf') != null) {
      this.cpf = document['cpf'] as String;
    }

    /*this.kind = false;
    if (document.get('kind') != null) {
      //this.kind = document['kind'] as bool;
    }*/
  }

  String id = '';
  String profileID = '';
  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  String cpf = '';
  String img = '';
  bool kind;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
        'cpf': cpf,
        'kind': kind,
      };
}
