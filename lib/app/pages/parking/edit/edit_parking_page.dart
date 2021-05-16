import 'package:app_estacionamento/app/models/parking_model.dart';
import 'package:app_estacionamento/app/pages/parking/edit/components/image_source_sheet.dart';
import 'package:app_estacionamento/app/providers/parking_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../../models/parking_model.dart';
import '../../map/map_page.dart';
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
              ImagesForm(parkingModel),
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

    return new Map(parkingModel);
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

class Map extends StatefulWidget {
  LatLng location;
  ParkingModel model;

  Map(this.model);

  @override
  _MapState createState() {
    var map = new _MapState();
    location = map.location;
    return map;
  }
}

class _MapState extends State<Map> {
  Set<Marker> markers = new Set<Marker>();
  LatLng location = new LatLng(-14.2400732, -53.1805017); // Coordenadas Brazil
  GoogleMapController _mapController;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: new CameraPosition(
        target: location,
      ),
      onTap: (t) => _getLocation(),
      myLocationButtonEnabled: false,
      markers: markers,
    );
  }

  void _getLocation() async {
    markers = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => GoogleMapScreen(
                getParkingMarkers: false,
                createCurrentLocationMarker: markers.isEmpty,
                markers: markers,
              )),
    );

    if (this.mounted) {
      setState(() {
        location = markers.first.position;
        _mapController.moveCamera(
          CameraUpdate.newCameraPosition(
            new CameraPosition(target: location, zoom: 16),
          ),
        );
      }); //Apenas pra atualizar o Widget

      widget.model.localization =
          new GeoPoint(location.latitude, location.longitude);
    }
  }
}
