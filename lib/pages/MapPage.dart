import 'dart:async';
import 'dart:collection';
import 'package:appcouvoiturage/Shared/location.dart';
import 'package:appcouvoiturage/pages/details.dart';
import 'package:appcouvoiturage/pages/trajet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;

import '../Services/base de donnee.dart';


class Mywid extends StatefulWidget {
  const Mywid({Key? key}) : super(key: key);

  @override
  State<Mywid> createState() => _MywidState();
}

class _MywidState extends State<Mywid> {
  late HashSet<Marker> markers;
  int _selectedIndex = 0;
  Position? current_location;
  BitmapDescriptor locationMarker = BitmapDescriptor.defaultMarker;
  bool loading = true;
  final Set<Polyline> _polylineSet = <Polyline>{};
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  @override
  void initState() {
    super.initState();
    polylinePoints = PolylinePoints();
    markers = HashSet();
    setCustomMarker();
    LocationManager locationManager = LocationManager();
    locationManager.initialize(context).then(
          (value) {
        current_location = locationManager.getCurrentPos;
        addMarker();
      },
    );
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> setCustomMarker() async {
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, "assets/images/current_location.png")
        .then((icon) => locationMarker = icon);
  }

  Future<void> addMarker() async {
    await getBytesFromAsset("assets/images/current_location.png", 120)
        .then((value) {
      setState(() {
        markers.add(Marker(
          markerId: const MarkerId("cuurent_pos"),
          position:
          LatLng(current_location!.latitude, current_location!.longitude),
          icon: BitmapDescriptor.fromBytes(value),
        ));
      });
    });
  }

  void setPolylines(LatLng depart, LatLng arrive) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyC9sGlH43GL0Jer73n9ETKsxNpZqvrWn-k",
        PointLatLng(depart.latitude, depart.longitude),
        PointLatLng(arrive.latitude, arrive.longitude));
    for (var element in result.points) {
      polylineCoordinates.add(LatLng(element.latitude, element.longitude));
    }
    setState(() {
      _polylineSet.add(Polyline(
          polylineId: const PolylineId("Route"),
          points: polylineCoordinates,
          color: Colors.yellow));
    });
  }

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments;
    List? args;
    bool noMarkersAdded = arg == null;
    if (!noMarkersAdded) {
      args = arg as List;
    }
    String? depart, arrive;
    LatLng? departCoord, arriveCoord;
    bool isUsingCurrentLocation = false;
    if (args != null) {
      depart = args[0];
      arrive = args[1];
      markers.add(args[2]);
      markers.add(args[3]);
      departCoord = args[4];
      arriveCoord = args[5];
      isUsingCurrentLocation = args[6];
    }
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    const double defaultPadding = 10;
    return  current_location == null
        ? const Center(
      child: CircularProgressIndicator(
        color: Colors.blue,
      ),

    )
        : Stack(
      children: [
        GoogleMap(
          polylines: _polylineSet,
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
              target: LatLng(current_location!.latitude,
                  current_location!.longitude),
              zoom: 13.5),
          onMapCreated: (controller) {
            _controller.complete(controller);
            if (!noMarkersAdded) {
              setPolylines(departCoord!, arriveCoord!);
            }
          },
          markers: markers,
        ),
        // Your main page content goes here
        Container(
          child: Column(
            children: [
              Expanded(flex: 60, child: Container()),
              Expanded(
                flex: 40,
                child: Container(
                  padding: EdgeInsets.all(screenWidth * 0.1),
                  // use 10% of screen width as padding
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              screenWidth *
                                  0.05), // use 5% of screen width as border radius
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => const OuAllezVous(),
                                transition: Transition.fade);
                          },
                          child: TextField(
                            controller: TextEditingController(
                                text: depart ?? ""),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                    const OuAllezVous(),
                                  ));
                            },
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: 'Choisir un point de depart',
                              floatingLabelBehavior:
                              FloatingLabelBehavior.auto,
                              border: InputBorder.none,
                              // fillColor: Colors.white,
                              // filled: true,
                              // remove the border of the TextField
                              prefixIcon: Icon(
                                  // isUsingCurrentLocation
                                  //     ? Icons.gps_fixed
                                  //     : Icons.gps_not_fixed,
                                Icons.gps_fixed_outlined,
                                  color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      // use 3% of screen height as space between text fields
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              screenWidth *
                                  0.05), // use 5% of screen width as border radius
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => const OuAllezVous(),
                                transition: Transition.fade);
                          },
                          child: TextField(
                            controller: TextEditingController(
                                text: arrive ?? ""),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                    const OuAllezVous(),
                                  ));
                            },
                            readOnly: true,
                            decoration: const InputDecoration(
                              hintText: 'Choisir une destination',
                              floatingLabelBehavior:
                              FloatingLabelBehavior.auto,
                              // remove the border of the TextField
                              prefixIcon: Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.blue),
                              border: InputBorder.none,
                              // fillColor: Colors.white,
                              // filled: true,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.025),
                      // use 4% of screen height as space between text fields and row
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                        children: const [
                          RideTypeSelector(),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: screenHeight * 0.03,
          right: screenWidth * 0.04,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const details()));
            },
            child: const Icon(
              Icons.notifications_none_outlined,
              color: Colors.blue,
              size: 50,
            ),
          ),
        ),
      ],
    );
  }
}




class RideTypeSelector extends StatefulWidget {
  const RideTypeSelector({super.key});

  @override
  _RideTypeSelectorState createState() => _RideTypeSelectorState();
}

class _RideTypeSelectorState extends State<RideTypeSelector> {
  final List<bool> _isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      child: ToggleButtons(
        isSelected: _isSelected,
        onPressed: (int index) async{
          bool statut = false; // passager
          if (index == 0 && _isSelected[index] == false) statut = false ;
          else if (index == 1 && _isSelected[index] == false) statut = true ;
          else if (index == 1 && _isSelected[index] == true) statut = false ;
          else if (index == 0 && _isSelected[index] == true) statut = true ;
          await BaseDeDonnee().updateUtilisateurStatut(FirebaseAuth.instance.currentUser!.uid, statut);
          setState(() {
            _isSelected[index] = !_isSelected[index];
            _isSelected[1 - index] = !_isSelected[1 - index];
          });
        },
        selectedColor: Colors.white,
        disabledBorderColor: Colors.blue,
        fillColor: Colors.blue,
        borderRadius: BorderRadius.circular(20.0),
        disabledColor: Colors.white,
        children:  [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
            child: Text('Passager'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
            child: Text('Conducteur'),
          ),
        ],
      ),
    );
  }
}