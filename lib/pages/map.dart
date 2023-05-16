import 'dart:async';

import 'package:nroho/Shared/location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Position? current_location = LocationManager().getCurrentPos;
  late CameraPosition pos;
  double _latitude = 0;
  double _longitude = 0;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    pos = CameraPosition(
        target:
            LatLng(current_location!.latitude, current_location!.longitude));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _latitude = current_location!.latitude;
    _longitude = current_location!.longitude;
    return Scaffold(
      body: Stack(children: [
        GoogleMap(
            onCameraMove: (position) {
              pos = position;
              _latitude = position.target.latitude;
              _longitude = position.target.longitude;
            },
            initialCameraPosition: CameraPosition(
                target: LatLng(
                    current_location!.latitude, current_location!.longitude),
                zoom: 13.5),
            onMapCreated: (controller) {
              _controller.complete(controller);
            }),
        const Center(
          child: Image(
            image: AssetImage("assets/images/marker.png"),
            width: 60,
          ),
        ),
        Positioned(
          bottom: 30,
          right: size.width / 4,
          width: 200,
          child: ElevatedButton(
              onPressed: () {
                if (_latitude != null && _longitude != null) {
                  final latlng = LatLng(_latitude, _longitude);
                Navigator.pop(context, latlng);}},
              child: const Text("Valider",style: TextStyle(fontFamily: 'Poppins'),)),
        )
      ]),
    );
  }
}
