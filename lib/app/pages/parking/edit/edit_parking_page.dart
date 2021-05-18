import 'dart:io';

import 'package:app_estacionamento/app/models/parking_model.dart';
import 'package:app_estacionamento/app/providers/parking_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../../models/parking_model.dart';
import '../../../providers/parking_provider.dart';
import '../Utils/Map.dart';
import 'components/images_form.dart';
import 'package:app_estacionamento/app/blocs/application_bloc.dart';

class EditParkingPage extends StatelessWidget {
  EditParkingPage(this.parkingModel);

  final ParkingModel parkingModel;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  BuildContext context;
  Set<Marker> markers = new Set<Marker>();
  LatLng parkingLocation;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Adicionar Estacionamento'),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Flexible(flex: 8, child: ImagesForm(parkingModel)),
              Flexible(flex: 1, child: createNameField()),
              Flexible(flex: 1, child: createPhoneField()),
              Flexible(flex: 1, child: createSpacesField()),
              Flexible(flex: 1, child: createPriceField()),
              Flexible(flex: 2, child: createLocationField()),
              Flexible(flex: 1, child: createButton(context)),
            ],
          ),
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
    final applicationBloc = Provider.of<ApplicationBloc>(context);

    return new MiniMap(parkingModel);
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
              var provider = context.read<ParkingProvider>();
              provider.create(parking: parkingModel).then((value) async {
                await getImagesUrls(value);
                provider.updateImages(parkingModel, value);
              });

              Navigator.pop(context);
            }
          },
          child: const Text(
            'CADASTRAR',
            style: TextStyle(fontSize: 18),
          )),
    );
  }

  Future<void> getImagesUrls(String parkingId) async {
    var counter = 1;
    List<String> paths = <String>[];
    for (var image in parkingModel.images) {
      if (image.isEmpty) continue;

      var storageRef = FirebaseStorage.instance.ref();
      var imageRef = storageRef.child("images/$parkingId/image$counter.jpg");
      var file = File(image);
      var upload = imageRef.putFile(file);
      var path = "";

      // ignore: unnecessary_statements
      await upload.then((snapshot) =>
          snapshot.ref.getDownloadURL().then((value) => path = value));
      paths.add(path);
      //upload.snapshot.ref.getDownloadURL().then((value) => path = value);

      counter++;
    }

    parkingModel.images = paths;
  }
}
