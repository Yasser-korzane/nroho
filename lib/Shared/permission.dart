import 'package:nroho/pages/home.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

Future<bool> handleLocationPermission(BuildContext context) async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: AwesomeSnackbarContent(
          title: 'Attention!',
          message: 'Les services de localisation sont désactivés. Veuillez activer les services',
          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          contentType: ContentType.help,
          // to configure for material banner
          inMaterialBanner: true,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
    await Future.delayed(const Duration(seconds: 5));
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return home();
      },
    ));
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          content: AwesomeSnackbarContent(
            title: 'Attention!',
            message: 'Les services de localisation sont désactivés. Veuillez activer les services',
            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
            contentType: ContentType.help,
            // to configure for material banner
            inMaterialBanner: true,
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: AwesomeSnackbarContent(
          title: 'Attention!!',
          message: 'Les autorisations de localisation sont définitivement refusées, nous ne pouvons pas demander d\'autorisations',

          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          contentType: ContentType.success,
          // to configure for material banner
          inMaterialBanner: true,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
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