import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            child: new GoogleMapScreen(),
          ),
        ),
      ),
    );
  }
}

class GoogleMapScreen extends StatefulWidget {
  GoogleMapScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GoogleMapScreenState createState() => new _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target:  LatLng(-26.836574837915883, -49.26282056768223),
          zoom: 15,
        ),
      ),
    );
  }
}