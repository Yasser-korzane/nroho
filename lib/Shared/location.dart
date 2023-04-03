import 'dart:developer';

import 'package:appcouvoiturage/Shared/permission.dart';
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
    handleLocationPermission(context).then((value) {
      Geolocator.getCurrentPosition().then((value2) {
        _currentLocation = value2;
        log(_currentLocation.toString());
        return;
      });
    });
  }

  Position get getCurrentPos => _currentLocation!;
}
