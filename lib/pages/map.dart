import 'dart:async';

import 'package:appcouvoiturage/Shared/location.dart';
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
    return Scaffold(
      body: Stack(children: [
        GoogleMap(
            onCameraMove: (position) {
              pos = position;
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
                Navigator.pushNamed(context, "trajet", arguments: pos);
              },
              child: const Text("Valider")),
        )
      ]),
    );
  }
}
