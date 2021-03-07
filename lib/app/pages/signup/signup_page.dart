import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            children: <Widget>[
              Center(
                child: const Text(
                  'iPark',
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Nome Completo', icon: Icon(Icons.person)),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'E-mail', icon: Icon(Icons.mail)),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Senha', icon: Icon(Icons.lock)),
                obscureText: true,
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Repita a Senha', icon: Icon(Icons.lock)),
                obscureText: true,
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 60,
                child: RaisedButton(
                  color: Colors.red,
                  disabledColor: Theme.of(context).primaryColor.withAlpha(100),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.red)),
                  onPressed: () {},
                  child: const Text(
                    'Criar Conta',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
