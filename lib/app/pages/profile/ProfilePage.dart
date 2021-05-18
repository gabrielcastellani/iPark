import 'package:app_estacionamento/app/models/price_space.dart';
import 'package:app_estacionamento/app/models/user_model.dart';
import 'package:app_estacionamento/app/pages/paymentcard/paymentcard_page.dart';
import 'package:app_estacionamento/app/providers/credit_card_provider.dart';
import 'package:app_estacionamento/app/models/tipopessoa_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_estacionamento/app/providers/ProfileProvider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  ProfileProvider pp = ProfileProvider();
  UserModel user;
  @override
  Widget build(BuildContext context) {
    List<TipoPessoa> tipoPessoa = TipoPessoa.values;
    var selectedPessoa = TipoPessoa.fisica;
    return Scaffold(
      body: Consumer<ProfileProvider>(
        builder: (_, profileProvider, __) {
          for (var lista in tipoPessoa) {
            var profile = profileProvider.allUsers
                .where((element) => element.kind == lista.descricao)
                .first;
            user = profile;
          }

          // }
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
                        user.img.toString(),
                      ),
                      radius: 100.0),
                  TextFormField(
                    // enabled: !userProvider.isLoading,
                    decoration: const InputDecoration(
                        labelText: 'Nome', icon: Icon(Icons.email)),
                    keyboardType: TextInputType.text,
                    initialValue: user.name.toString(),
                  ),
                  TextFormField(
                    // enabled: !userProvider.isLoading,
                    decoration: const InputDecoration(
                      labelText: 'CPF',
                      icon: Icon(Icons.account_circle_rounded),
                    ),
                    initialValue: user.cpf,
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
                    initialValue: user.email.toString(),
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
