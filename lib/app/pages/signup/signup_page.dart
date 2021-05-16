import 'package:app_estacionamento/app/models/tipopessoa_model.dart';
import 'package:app_estacionamento/app/providers/UserProvider.dart';
import 'package:provider/provider.dart';
import 'package:app_estacionamento/app/helpers/validators.dart';
import 'package:app_estacionamento/app/models/user_model.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UserModel _user = UserModel();
  List<TipoPessoa> tipoPessoa = TipoPessoa.values;
  var selectedPessoa;
  bool isManager = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
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
                  validator: (name) {
                    if (name.isEmpty) {
                      return 'Campo obrigatório';
                    } else if (name.trim().split(' ').length <= 1) {
                      return 'Preencha com seu nome completo';
                    }
                    return null;
                  },
                  onSaved: (name) => _user.name = name,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'E-mail', icon: Icon(Icons.mail)),
                  keyboardType: TextInputType.emailAddress,
                  validator: (email) {
                    if (email.isEmpty) {
                      return 'Campo obrigatório';
                    } else if (!emailValid(email)) {
                      return 'E-mail inválido';
                    }
                    return null;
                  },
                  onSaved: (email) => _user.email = email,
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.person),
                      DropdownButton(
                        items: tipoPessoa
                            .map((value) => DropdownMenuItem(
                                  child: Text(value.descricao),
                                  value: value.descricao,
                                ))
                            .toList(),
                        onChanged: (selectedPessoas) {
                          if (this.mounted) {
                            setState(() {
                              selectedPessoa = selectedPessoas;
                            });
                          }
                        },
                        hint: Text("Selecione o tipo de pessoa"),
                        value: selectedPessoa,
                      )
                    ]),
                const SizedBox(
                  height: 6,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Senha', icon: Icon(Icons.lock)),
                  obscureText: true,
                  validator: (pass) {
                    if (pass.isEmpty) {
                      return 'Campo obrigatório';
                    } else if (pass.length < 6) {
                      return 'Senha muito curta';
                    }
                    return null;
                  },
                  onSaved: (pass) => _user.password = pass,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Repita a Senha', icon: Icon(Icons.lock)),
                  obscureText: true,
                  validator: (pass) {
                    if (pass.isEmpty) {
                      return 'Campo obrigatório';
                    } else if (pass.length < 6) {
                      return 'Senha muito curta';
                    }
                    return null;
                  },
                  onSaved: (pass) => _user.confirmPassword = pass,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 60,
                  child: RaisedButton(
                    color: Colors.red,
                    disabledColor:
                        Theme.of(context).primaryColor.withAlpha(100),
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: Colors.red)),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _user.kind = selectedPessoa;

                        if (_user.kind == null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text('Tipo pessoa vazio!'),
                            backgroundColor: Colors.red,
                          ));
                          return;
                        }

                        _formKey.currentState.save();

                        if (_user.password != _user.confirmPassword) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text('Senhas não coincidem!'),
                            backgroundColor: Colors.red,
                          ));
                          return;
                        }

                        context.read<UserProvider>().createNewUser(
                            user: _user,
                            onFail: (e) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    Text('Erro ao cadastrar novo usuário: $e'),
                                backgroundColor: Colors.red,
                              ));
                            },
                            onSucess: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Usuário criado com sucesso!'),
                                backgroundColor: Colors.green[800],
                              ));
                              Navigator.pop(context);
                            });
                      }
                    },
                    child: const Text(
                      'Criar Conta',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 60,
                  child: RaisedButton(
                    color: Colors.blue,
                    disabledColor:
                        Theme.of(context).primaryColor.withAlpha(100),
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: Colors.blue)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Voltar',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
