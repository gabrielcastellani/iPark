import 'package:app_estacionamento/app/common/custom_card/custom_card.dart';
import 'package:app_estacionamento/app/pages/parking/newParking_page.dart';
import 'package:app_estacionamento/app/providers/parking_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ParkingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ParkingProvider>(
        builder: (_, parkingProvider, __) {
          return ListView.builder(
              itemCount: parkingProvider.allParking.length,
              itemBuilder: (_, index) {
                var parking = parkingProvider.allParking[index];

                return CustomCard(
                    parking.name, '', '', parking.parkingSpaceValue);
              });
        },
      ),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: const Color(0xff03dac6),
        foregroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => NewParkingPage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
