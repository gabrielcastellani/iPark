import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //RandomColor _randomColor = RandomColor();
    //Color _color = _randomColor.randomColor(
    //    colorBrightness : ColorBrightness.light
    //);

    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            children: <Widget>[
              CircleAvatar(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  backgroundImage: NetworkImage(
                    "https://media-exp1.licdn.com/dms/image/C5603AQGXEg7Ec14L1w/profile-displayphoto-shrink_200_200/0/1597960710114?e=1624492800&v=beta&t=KcDjytYLR4tOop7FIQ8jZBfIdj0G5nrojiRqX2Ap-kI",
                  ),
                  radius: 100.0,
                  child: Text('Gabriel',
                      style:TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 20.0)
                  )),
              TextFormField(
                  // enabled: !userProvider.isLoading,
                  decoration: const InputDecoration(
                      labelText: 'Nome', icon: Icon(Icons.email)),
                  keyboardType: TextInputType.text),
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
      ),
    );
  }
}
