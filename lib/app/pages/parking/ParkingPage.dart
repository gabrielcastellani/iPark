import 'package:app_estacionamento/app/common/custom_card/custom_card.dart';
import 'package:app_estacionamento/app/pages/parking/newParking_page.dart';
import 'package:flutter/material.dart';

class ParkingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: <Widget>[
        CustomCard(),
        CustomCard(),
        CustomCard(),
        CustomCard(),
        CustomCard(),
        CustomCard(),
        CustomCard(),
        CustomCard(),
        CustomCard(),
      ]),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: new FloatingActionButton(
          backgroundColor: const Color(0xff03dac6),
          foregroundColor: Colors.black,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => NewParkingPage()));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
