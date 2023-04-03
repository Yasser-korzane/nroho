import 'package:appcouvoiturage/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

Future<bool> handleLocationPermission(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'Location services are disabled. Please enable the services')));
    await Future.delayed(const Duration(seconds: 5));
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return const home();
      },
    ));
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied')));
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'Location permissions are permanently denied, we cannot request permissions.')));
    return false;
  }
  return true;
}

Future<String> getUserLocation(Position myLocation) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        myLocation.latitude, myLocation.longitude);
    Placemark place = placemarks[0];
    return place.locality!;
  }