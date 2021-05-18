import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../models/parking_model.dart';
import '../../map/map_page.dart';

class MiniMap extends StatefulWidget {
  LatLng location;
  ParkingModel model;

  MiniMap(this.model);

  @override
  _MapState createState() {
    LatLng initialLocation = null;
    if (model.localization != null)
      initialLocation =
          new LatLng(model.localization.latitude, model.localization.longitude);
    var map = new _MapState(initialLocation);
    location = map.location;
    return map;
  }
}

class _MapState extends State<MiniMap> {
  Set<Marker> markers = new Set<Marker>();
  LatLng location;
  bool isOnlyForVisualization = false;
  GoogleMapController _mapController;

  _MapState(LatLng initialLocation) {
    location = initialLocation ??
        new LatLng(-14.2400732, -53.1805017); // Coordenadas Brazil
    isOnlyForVisualization = initialLocation != null;
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    var initialCamera;

    if (isOnlyForVisualization) {
      initialCamera = new CameraPosition(target: location, zoom: 16);

      markers.add(
        new Marker(
          markerId: new MarkerId('localization'),
          position: location,
        ),
      );
    } else
      initialCamera = new CameraPosition(target: location);

    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: initialCamera,
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
                changeMarkerLocation: !isOnlyForVisualization,
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
