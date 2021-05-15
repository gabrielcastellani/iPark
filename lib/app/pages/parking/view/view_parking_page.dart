import 'package:app_estacionamento/app/models/parking_model.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class ViewParkingPage extends StatelessWidget {
  const ViewParkingPage(this._parkingModel);

  final ParkingModel _parkingModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1,
            child: Carousel(
              images: _parkingModel.images.map((e) => NetworkImage(e)).toList(),
              dotSize: 4,
              dotSpacing: 15,
              dotBgColor: Colors.transparent,
              dotColor: Theme.of(context).primaryColor,
              autoplay: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                createNameParking(),
                createLocalizationParking(),
                createPriceParking(context),
                createPhoneParking(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget createNameParking() {
    return Text(
      _parkingModel.name,
      style: TextStyle(
        fontSize: 20,
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
        _parkingModel.phone,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
