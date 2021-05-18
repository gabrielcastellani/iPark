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

// ignore: must_be_immutable
class GoogleMapScreen extends StatefulWidget {
  String title;
  bool createCurrentLocationMarker;
  bool getParkingMarkers;
  bool changeMarkerLocation;
  Set<Marker> markers;

  GoogleMapScreen({
    this.getParkingMarkers,
    Key key,
    this.title,
    this.createCurrentLocationMarker,
    this.markers,
    this.changeMarkerLocation,
  }) : super(key: key){
    this.createCurrentLocationMarker = createCurrentLocationMarker ?? false;
    this.getParkingMarkers = getParkingMarkers ?? true;
    this.markers = markers ?? new Set<Marker>();
  }

  @override
  _GoogleMapScreenState createState() => new _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  GoogleMapController mapController;
  LatLng startingPosition;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.getParkingMarkers) {
      for (ParkingModel model in context.read<ParkingProvider>().allParking) {
        widget.markers.add(
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
        return widget.getParkingMarkers || !widget.changeMarkerLocation;
      },
      child: (applicationBloc.currentLocation == null)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _buildMapScaffold(applicationBloc),
    );
  }

  Widget _buildMapScaffold(ApplicationBloc applicationBloc) {
    if (widget.getParkingMarkers || !widget.changeMarkerLocation) {
      return Scaffold(
        body: _buildMap(applicationBloc),
      );
    } else {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.keyboard_return),
          onPressed: () {
            Marker _marker = widget.markers.last;
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
    if (widget.markers.isNotEmpty && !widget.getParkingMarkers)
      startingPosition = widget.markers.first.position;
    else
      startingPosition = new LatLng(applicationBloc.currentLocation.latitude,
          applicationBloc.currentLocation.longitude);

    String markerId =
      widget.markers.isEmpty ? "parkingLocation" : widget.markers.first.markerId.value;

    if (widget.createCurrentLocationMarker) {
      widget.markers.add(
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
      markers: widget.markers,
      onTap: _changeMarker,
      myLocationEnabled: widget.getParkingMarkers,
      myLocationButtonEnabled: false,
    );
  }

  void _changeMarker(LatLng position) {
    if (!widget.changeMarkerLocation) return;

    Marker _marker = new Marker(
      markerId: widget.markers.first.markerId,
      position: position,
      infoWindow: new InfoWindow(
        title: "Estacionamento",
      ),
    );

    if (this.mounted) {
      setState(() {
        widget.markers.add(_marker);
      });
    }
  }
}
