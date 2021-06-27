import 'dart:io';
import 'package:app_estacionamento/app/models/price_space.dart';
import 'package:app_estacionamento/app/models/tipopessoa_model.dart';
import 'package:app_estacionamento/app/models/user_model.dart';
import 'package:app_estacionamento/app/pages/paymentcard/paymentcard_page.dart';
import 'package:app_estacionamento/app/pages/signin/SignInPage.dart';
import 'package:app_estacionamento/app/providers/credit_card_provider.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_estacionamento/app/providers/ProfileProvider.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:app_estacionamento/app/pages/parking/edit/components/image_source_sheet.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> Logout() async {
    await FirebaseAuth.instance.signOut();
  }

  List<TipoPessoa> tipoPessoa = TipoPessoa.values;
  var selectedPessoa;

  @override
  Widget build(BuildContext context) {
    final pp = Provider.of<ProfileProvider>(context);
    UserModel profile = new UserModel();

    if (pp.user.kind) {
      selectedPessoa = TipoPessoa.juridica.descricao;
    } else {
      selectedPessoa = TipoPessoa.fisica.descricao;
    }

    return FormField<List<dynamic>>(
        initialValue: [pp.user.img],
        builder: (state) {
          void onImageSelected(File file) {
            state.value.add(file);
            state.didChange(state.value);
            pp.user.img = file.path;
            Navigator.of(context).pop();
            pp.getImagesUrls(pp.user.profileID);
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.lightBlue,
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      SystemChannels.platform
                          .invokeMethod<void>('SystemNavigator.pop');

                      /*
                      Logout();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => SignInPage()));*/
                    },
                    icon: Icon(Icons.exit_to_app),
                    label: Text("Logout"))
              ],
            ),
            body: Consumer<ProfileProvider>(
              builder: (_, profileProvider, __) {
                var material = Material(
                  color: Colors.white,
                  child: IconButton(
                    icon: Icon(Icons.add_a_photo),
                    color: Theme.of(context).primaryColor,
                    iconSize: 25,
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (_) => ImageSourceSheet(
                                onImageSelected: onImageSelected,
                              ));
                    },
                  ),
                );

                var nome = pp.user.name;
                var email = pp.user.email;
                var cpf = pp.user.cpf;

                CircleAvatar background = new CircleAvatar(
                  child: material,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.white,
                  radius: 100.0,
                );

                if (pp.user.img != null && pp.user.img.length > 0) {
                  print('nome img:' + pp.user.img.toString());
                  var image = NetworkImage(pp.user.img);

                  background = new CircleAvatar(
                      child: material,
                      foregroundColor: Colors.white,
                      radius: 100.0,
                      backgroundImage: image);
                }

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      shrinkWrap: true,
                      children: <Widget>[
                        background,
                        TextFormField(
                          // enabled: !userProvider.isLoading,
                          decoration: const InputDecoration(
                              labelText: 'Nome', icon: Icon(Icons.email)),
                          keyboardType: TextInputType.text,
                          initialValue: nome,
                        ),
                        TextFormField(
                          // enabled: !userProvider.isLoading,
                          decoration: const InputDecoration(
                            labelText: 'CPF',
                            icon: Icon(Icons.account_circle_rounded),
                          ),
                          inputFormatters: [CpfInputFormatter()],
                          initialValue: cpf,
                          keyboardType: TextInputType.number,
                          validator: (cpf) {
                            if (cpf.isEmpty) {
                              return 'Digite um CPF';
                            }
                            return null;
                          },
                          onChanged: (cpf) {
                            pp.user.cpf = cpf;
                          },
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
                          initialValue: email,
                          //onSaved: (email) => _user.email = email,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(Icons.person),
                              Text('Tipo Pessoa:'),
                              DropdownButton(
                                value: selectedPessoa,
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
                              )
                            ]),
                        // BOTÃO PROVISÓRIO, SÓ PRA ACESSAR A PÁGINA DO CARTÃO
                        FloatingActionButton.extended(
                          onPressed: () async {
                            var creditCard = await context
                                .read<CreditCardProvider>()
                                .getCreditCardByCurrentUser();

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => PaymentCardPage(
                                        creditCard, PriceSpaceModel(5, 0, 0))));
                          },
                          label: Text('Cartão'),
                        ),

                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 60,
                          child: RaisedButton(
                            color: Colors.blue,
                            disabledColor:
                                Theme.of(context).primaryColor.withAlpha(100),
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: BorderSide(color: Colors.blue),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Salvar Alterações',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
