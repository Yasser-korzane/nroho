import 'package:nroho/Shared/permission.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationManager {
  LocationManager._constuctor();

  static final LocationManager _instance = LocationManager._constuctor();

  factory LocationManager() {
    return _instance;
  }
  Position? _currentLocation;
  Future<void> initialize(BuildContext context) async {
    if (_currentLocation == null) {
      await handleLocationPermission(context).then((value) async {
        await Geolocator.getCurrentPosition().then((value2) {
          _currentLocation = value2;
        });
      });
    }
  }

  Position get getCurrentPos => _currentLocation!;
}
