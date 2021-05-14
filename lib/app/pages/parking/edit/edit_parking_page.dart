import 'package:app_estacionamento/app/models/parking_model.dart';
import 'package:flutter/material.dart';

import 'components/images_form.dart';

class EditParkingPage extends StatelessWidget {

  EditParkingPage(this.parkingModel);

  final ParkingModel parkingModel;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Estacionamento'),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(10),
          children: <Widget>[
            ImagesForm(parkingModel),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nome',
              ),
              keyboardType: TextInputType.name,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Descrição',
              ),
              keyboardType: TextInputType.multiline,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Telefone',
              ),
              keyboardType: TextInputType.phone,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Localização',
              ),
              keyboardType: TextInputType.text,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Quantidade de vagas',
              ),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Preço por vaga',
              ),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Vagas alugavel?',
              ),
              keyboardType: TextInputType.text,
            ),
            RaisedButton(
              color: Colors.red,
              disabledColor:
              Theme.of(context).primaryColor.withAlpha(100),
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: Colors.red),
              ),
              onPressed: () {
                if(formKey.currentState.validate()) {
                  print('V');
                } else {
                  print('F');
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}