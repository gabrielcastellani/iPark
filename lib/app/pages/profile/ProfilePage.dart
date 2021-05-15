import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_estacionamento/app/providers/ProfileProvider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProfileProvider>(
        builder: (_, profileProvider, __) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: ListView(
                padding: const EdgeInsets.all(16),
                shrinkWrap: true,
                children: <Widget>[
                  CircleAvatar(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                       profileProvider.user.img.toString(),
                      ),
                      radius: 100.0),
                  TextFormField(
                    // enabled: !userProvider.isLoading,
                    decoration: const InputDecoration(
                        labelText: 'Nome', icon: Icon(Icons.email)),
                    keyboardType: TextInputType.text,
                    initialValue: profileProvider.user.name,
                  ),
                  TextFormField(
                    // enabled: !userProvider.isLoading,
                    decoration: const InputDecoration(
                      labelText: 'CPF',
                      icon: Icon(Icons.account_circle_rounded),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    // enabled: !userProvider.isLoading,
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      icon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (email.isEmpty) {
                        return 'Campo obrigatório';
                        //} else if (!emailValid(email)) {
                        // return 'E-mail inválido';
                      }
                      return null;
                    },
                    //onSaved: (email) => _user.email = email,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Idade',
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Tipo usuário',
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
