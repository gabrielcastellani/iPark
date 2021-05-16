import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:app_estacionamento/app/models/parking_model.dart';
import 'package:app_estacionamento/app/providers/parking_provider.dart';
import 'package:provider/provider.dart';
import 'package:app_estacionamento/app/blocs/application_bloc.dart';

import '../../providers/parking_provider.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  new GoogleMapScreen();
  }
}

class GoogleMapScreen extends StatefulWidget {
  final String title;
  final bool createCurrentLocationMarker;
  final bool getParkingMarkers;
  final Set<Marker> markers;

  GoogleMapScreen({
    this.getParkingMarkers,
    Key key,
    this.title,
    this.createCurrentLocationMarker,
    this.markers,
  }) : super(key: key);

  @override
  _GoogleMapScreenState createState() => new _GoogleMapScreenState(createCurrentLocationMarker, getParkingMarkers, markers);
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  GoogleMapController mapController;
  Set<Marker> markers;
  bool getParkingMarkers = true;
  bool createCurrentLocationMarker = false;
  LatLng startingPosition;

  _GoogleMapScreenState(
      createCurrentLocationMarker, getParkingMarkers, markers) {
    this.createCurrentLocationMarker = createCurrentLocationMarker ?? false;
    this.getParkingMarkers = getParkingMarkers ?? true;
    this.markers = markers ?? new Set<Marker>();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    if (this.getParkingMarkers) {
      for (ParkingModel model in context.read<ParkingProvider>().allParking) {
        markers.add(
          new Marker(
            markerId: new MarkerId(model.id),
            position: new LatLng(model.localization.latitude, model.localization.longitude),
            infoWindow: new InfoWindow(title: model.name),
          ),
        );
      }
    }

    final applicationBloc = Provider.of<ApplicationBloc>(context);

    return new WillPopScope(
      onWillPop: () async {
        return getParkingMarkers;
      },
      child: (applicationBloc.currentLocation == null)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _buildMapScaffold(applicationBloc),
    );
  }

  Widget _buildMapScaffold(ApplicationBloc applicationBloc) {
    if (getParkingMarkers) {
      return Scaffold(
        body: _buildMap(applicationBloc),
      );
    } else {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.keyboard_return),
          onPressed: () {
            Marker _marker = markers.last;
            Set<Marker> returnMarkers = new Set<Marker>();
            returnMarkers.add(_marker);

            Navigator.pop(context, returnMarkers);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: _buildMap(applicationBloc),
      );
    }
  }

  Widget _buildMap(ApplicationBloc applicationBloc) {
    if (this.markers.isNotEmpty && !getParkingMarkers)
      startingPosition = this.markers.first.position;
    else
      startingPosition = new LatLng(applicationBloc.currentLocation.latitude,
          applicationBloc.currentLocation.longitude);

    String markerId =
        markers.isEmpty ? "parkingLocation" : markers.first.markerId.value;

    if (createCurrentLocationMarker) {
      markers.add(
        new Marker(
          markerId: new MarkerId(markerId),
          position: startingPosition,
        ),
      );
    }

    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: startingPosition,
        zoom: 16,
      ),
      markers: markers,
      onTap: _changeMarker,
      myLocationEnabled: getParkingMarkers,
      myLocationButtonEnabled: false,
    );
  }

  void _changeMarker(LatLng position) {
    if (getParkingMarkers) return;

    Marker _marker = new Marker(
      markerId: markers.first.markerId,
      position: position,
      infoWindow: new InfoWindow(
        title: "Estacionamento",
      ),
    );

    if (this.mounted) {
      setState(() {
        markers.add(_marker);
      });
    }
  }
}
