import 'package:app_estacionamento/app/models/parking_model.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import '../../../providers/parking_provider.dart';
import 'package:provider/provider.dart';
import '../Utils/Map.dart';

class ViewParkingPage extends StatelessWidget {
  const ViewParkingPage(this._parkingModel);

  final ParkingModel _parkingModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Flexible(
              flex: 4,
              child: AspectRatio(
                aspectRatio: 1,
                child: Carousel(
                  images:
                      _parkingModel.images.map((e) => NetworkImage(e)).toList(),
                  dotSize: 4,
                  dotSpacing: 15,
                  dotBgColor: Colors.transparent,
                  dotColor: Theme.of(context).primaryColor,
                  autoplay: false,
                ),
              ),
            ),
            Flexible(flex: 1, child: createNameParking()),
            Flexible(flex: 1, child: createLocalizationParking()),
            Flexible(flex: 3, child: new MiniMap(_parkingModel)),
            Flexible(flex: 1, child: createPriceParking(context)),
            Flexible(flex: 1, child: createPhoneParking()),
            Flexible(flex: 1, child: createParkingSpaceCount()),
            Flexible(flex: 1, child: createLeaseButton(context)),
          ],
        ),
      ),
    );
  }

  Widget createNameParking() {
    return Text(
      _parkingModel.name,
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget createPriceParking(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            'Valor por vaga',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 13,
            ),
          ),
        ),
        Text(
          'R\$' + _parkingModel.parkingSpaceValue.toString(),
          style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor),
        )
      ],
    );
  }

  Widget createLocalizationParking() {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.location_on,
            size: 16,
          ),
          Text(
            _parkingModel.localization.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget createPhoneParking() {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Text(
        'Telefone: ' + _parkingModel.phone,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget createParkingSpaceCount() {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Text(
        'Quantidade de vagas disponíveis: ' + _parkingModel.numberParkingSpace.toString(),
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget createLeaseButton(BuildContext context) {
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
            _showAlertDialog(context);
            _parkingModel.numberParkingSpace--;

            var provider = context.read<ParkingProvider>();
            provider.updateAmountOfFreeParkingSpaces(_parkingModel.id, _parkingModel.numberParkingSpace);

            Navigator.pop(context);
          },
          child: const Text(
            'ALUGAR VAGA',
            style: TextStyle(fontSize: 18),
          )),
    );
  }

  _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: Text("Vaga locada com sucesso!"),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}
