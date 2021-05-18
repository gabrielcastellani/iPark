import 'dart:io';
import 'package:app_estacionamento/app/models/price_space.dart';
import 'package:app_estacionamento/app/pages/paymentcard/paymentcard_page.dart';
import 'package:app_estacionamento/app/providers/credit_card_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_estacionamento/app/providers/ProfileProvider.dart';
import 'package:provider/provider.dart';
import 'package:app_estacionamento/app/pages/parking/edit/components/image_source_sheet.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProfileProvider pp = ProfileProvider();
    print('teste');

    return FormField<List<dynamic>>(
        initialValue: [pp.user.img],
        builder: (state) {
          void onImageSelected(File file) {
            state.value.add(file);
            print('State value:' + state.value.toString());
            print('path: '+file.path);
            state.didChange(state.value);
            pp.user.img = file.uri.path;
            print('diff:' + pp.user.img);
            Navigator.of(context).pop();
            pp.updateImages(pp.user);
          }

          return Scaffold(
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
                          initialValue: profileProvider.user.name.toString(),
                        ),
                        TextFormField(
                          // enabled: !userProvider.isLoading,
                          decoration: const InputDecoration(
                            labelText: 'CPF',
                            icon: Icon(Icons.account_circle_rounded),
                          ),
                          initialValue: profileProvider.user.cpf,
                          keyboardType: TextInputType.number,
                          validator: (cpf) {
                            if (cpf.isEmpty){
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
                          initialValue: profileProvider.user.email.toString(),
                          //onSaved: (email) => _user.email = email,
                        ),
                        /* Row(
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
                          hint: Text("Selecione o tipo de pessoa"),
                          value: selectedPessoa,
                        )
                      ]),*/
                        // BOTÃO PROVISÓRIO, SÓ PRA ACESSAR A PÁGINA DO CARTÃO
                        FloatingActionButton(
                          child: const Text('Cartão'),
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
                        ),
                        FloatingActionButton(
                          child: const Text('Salvar'),
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
