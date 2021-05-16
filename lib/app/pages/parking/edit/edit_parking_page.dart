import 'package:app_estacionamento/app/models/parking_model.dart';
import 'package:app_estacionamento/app/pages/parking/edit/components/image_source_sheet.dart';
import 'package:app_estacionamento/app/providers/parking_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/images_form.dart';

class EditParkingPage extends StatelessWidget {
  EditParkingPage(this.parkingModel);

  final ParkingModel parkingModel;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Estacionamento'),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(10),
          children: <Widget>[
            ImagesForm(parkingModel),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  createNameField(),
                  createLocationField(),
                  createPhoneField(),
                  createSpacesField(),
                  createPriceField(),
                  const SizedBox(
                    height: 40,
                  ),
                  createButton(context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget createNameField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Nome',
      ),
      style: TextStyle(
        fontSize: 16,
      ),
      validator: (name) {
        if (name.isEmpty) {
          return 'Nome do estacionamento está inválido';
        }
        return null;
      },
      onSaved: (value) => parkingModel.name = value,
    );
  }

  Widget createLocationField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Localização'),
      style: TextStyle(
        fontSize: 16,
      ),
      validator: (location) {
        if (location.isEmpty) {
          return 'Localização do estacionamento está inválida';
        }
        return null;
      },
      onSaved: (value) => parkingModel.localization = GeoPoint(10, 10),
    );
  }

  Widget createPhoneField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Telefone'),
      style: TextStyle(fontSize: 16),
      keyboardType: TextInputType.number,
      validator: (phone) {
        if (phone.isEmpty) {
          return 'Telefone do estacionamento está inválido';
        }
        return null;
      },
      onSaved: (value) => parkingModel.phone = value,
    );
  }

  Widget createSpacesField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Quantidade de vagas'),
      style: TextStyle(fontSize: 16),
      keyboardType: TextInputType.number,
      validator: (space) {
        if (space.isEmpty || int.parse(space) < 0) {
          return 'Quantidade de vagas do estacionamento está inválida';
        }
        return null;
      },
      onSaved: (value) => parkingModel.numberParkingSpace = int.parse(value),
    );
  }

  Widget createPriceField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Preço por vaga'),
      style: TextStyle(fontSize: 16),
      keyboardType: TextInputType.number,
      validator: (price) {
        if (price.isEmpty) {
          return 'Preço da vaga do estacionamento está inválida';
        }
        return null;
      },
      onSaved: (value) => parkingModel.parkingSpaceValue = double.parse(value),
    );
  }

  Widget createButton(BuildContext context) {
    return SizedBox(
      height: 60,
      child: RaisedButton(
          color: Colors.red,
          disabledColor: Theme.of(context).primaryColor.withAlpha(100),
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.red),
          ),
          onPressed: () {
            if (formKey.currentState.validate()) {
              formKey.currentState.save();
              context.read<ParkingProvider>().create(parking: parkingModel);

              Navigator.pop(context);
            }
          },
          child: const Text(
            'CADASTRAR',
            style: TextStyle(fontSize: 18),
          )),
    );
  }
}
