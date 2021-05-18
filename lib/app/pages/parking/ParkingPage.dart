import 'package:app_estacionamento/app/common/custom_card/custom_card.dart';
import 'package:app_estacionamento/app/models/parking_model.dart';
import 'package:app_estacionamento/app/pages/parking/edit/edit_parking_page.dart';
import 'package:app_estacionamento/app/providers/parking_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ParkingPage extends StatefulWidget {
  const ParkingPage({Key key}) : super(key: key);

  @override
  _ParkingPageState createState() => _ParkingPageState();
}

class _ParkingPageState extends State<ParkingPage> {
  bool isSearching = false;
  String valor = "";

  int setaTamanho(parkingProvider) {
    if (valor != "" && valor != null) {
      var parking = parkingProvider.allParking
          .where((element) => element.name == valor)
          .length;

      return parking;
    } else {
      return parkingProvider.allParking.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: !isSearching
              ? Text('iPark')
              : TextField(
                  decoration: InputDecoration(
                      hintText: "Localizar Estacionamento",
                      hintStyle: TextStyle(color: Colors.white)),
                  onChanged: (text) {
                    valor = text;
                  }),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                setState(() {
                  this.isSearching = !this.isSearching;
                });
              },
            )
          ]),
      body: Consumer<ParkingProvider>(
        builder: (_, parkingProvider, __) {
          return ListView.builder(
              itemCount: setaTamanho(parkingProvider),
              itemBuilder: (_, index) {
                if (valor != "" && valor != null) {
                  var parking = parkingProvider.allParking
                      .where((element) => element.name == valor)
                      .first;
                  valor = "";
                  return CustomCard(parking);
                } else {
                  var parking = parkingProvider.allParking[index];
                  return CustomCard(parking);
                }
              });
        },
      ),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => EditParkingPage(ParkingModel(
                      name: '',
                      phone: '',
                      localization: null,
                      images: [''],
                      isRentable: false,
                      isClosed: false))));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
