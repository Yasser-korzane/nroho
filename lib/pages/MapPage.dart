import 'dart:async';
import 'dart:collection';
import 'package:nroho/Shared/location.dart';
import 'package:nroho/pages/AccepterPassager.dart';
import 'package:nroho/pages/notificationPassager.dart';
import 'package:nroho/pages/trajet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
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
  BaseDeDonnee baseDeDonnee = BaseDeDonnee();
  late HashSet<Marker> markers;
  Position? current_location;
  BitmapDescriptor locationMarker = BitmapDescriptor.defaultMarker;
  bool loading = true;
  final Set<Polyline> _polylineSet = <Polyline>{};
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  bool statut = false;
  bool ilYaUneNotification = false ;

  @override
  void initState() {
    super.initState();
    getilYaUneNotification();
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

  Future getStatut() async {
    await FirebaseFirestore.instance
        .collection('Utilisateur')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        statut = snapshot.data()!['statut'];
      } else {
        throw Exception('Failed to get statut');
      }
    });
  }
  Future getilYaUneNotification() async {
    await FirebaseFirestore.instance
        .collection('Utilisateur')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        ilYaUneNotification = snapshot.data()!['ilYaUneNotification'];
      } else {
        throw Exception('Failed to get ilYaUneNotification');
      }
    });
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
    await getBytesFromAsset("assets/images/current_location.png", 120).then((value) {
      if (mounted) {
        setState(() {
          markers.add(Marker(
            markerId: const MarkerId("cuurent_pos"),
            position: LatLng(current_location!.latitude, current_location!.longitude),
            icon: BitmapDescriptor.fromBytes(value),
          ));
        });
      }
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
          color: Colors.blue));
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
    return current_location == null
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
                    Expanded(flex: 51, child: Container()),
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
                                borderRadius: BorderRadius.circular(screenWidth *
                                    0.05), // use 5% of screen width as border radius
                              ),
                              child: TextField(
                                controller:
                                    TextEditingController(text: depart ?? ""),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      transitionDuration: Duration(milliseconds: 600),
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          const OuAllezVous(),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        var begin = const Offset(0.0, 1.0);
                                        var end = Offset.zero;
                                        var curve = Curves.ease;

                                        var tween = Tween(
                                                begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));

                                        return SlideTransition(
                                          position: animation.drive(tween),
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                },
                                readOnly: true,
                                decoration: const InputDecoration(
                                  hintText: 'Choisir un point de depart',
                                  hintStyle: TextStyle(fontFamily: 'Poppins'),
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
                            SizedBox(height: screenHeight * 0.013),
                            // use 3% of screen height as space between text fields
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(screenWidth *
                                    0.05), // use 5% of screen width as border radius
                              ),
                              child: TextField(
                                controller:
                                    TextEditingController(text: arrive ?? ""),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      transitionDuration: Duration(milliseconds: 600),
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          const OuAllezVous(),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        var begin = const Offset(0.0, 1.0);
                                        var end = Offset.zero;
                                        var curve = Curves.ease;

                                        var tween = Tween(
                                                begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));

                                        return SlideTransition(
                                          position: animation.drive(tween),
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                },
                                readOnly: true,
                                decoration: const InputDecoration(
                                  hintText: 'Choisir une destination',
                                  hintStyle: TextStyle(fontFamily: 'Poppins'),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                  // remove the border of the TextField
                                  prefixIcon: Icon(Icons.location_on_outlined,
                                      color: Colors.blue),
                                  border: InputBorder.none,
                                  // fillColor: Colors.white,
                                  // filled: true,
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            // use 4% of screen height as space between text fields and row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
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
                    onTap: () async {
                      await getStatut();
                      if (!statut) { // si mode passager
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 600),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    DemandesPassagerResultat(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              var begin = const Offset(0.0, -1.0);
                              var end = Offset.zero;
                              var curve = Curves.ease;
                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));
                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                          ),
                        );
                        await baseDeDonnee.updateUtilisateurilYaUneNotification(FirebaseAuth.instance.currentUser!.uid, false);
                        setState(() {
                          ilYaUneNotification = false ;
                        });
                      } else { // si mode conducteur
                          Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 600),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                     ListDemandePassager(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              var begin = const Offset(0.0, 1.0);
                              var end = Offset.zero;
                              var curve = Curves.ease;

                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));
                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                          ),
                        );
                      }
                      await baseDeDonnee.updateUtilisateurilYaUneNotification(FirebaseAuth.instance.currentUser!.uid, false);
                      setState(() {
                        ilYaUneNotification = false ;
                      });
                    },
                    child: ilYaUneNotification
                        ? const Icon(
                            Icons.notifications_active,
                            color: Colors.red,
                            size: 50,
                          )
                        : const Icon(
                            Icons.notifications_none_outlined,
                            color: Colors.blue,
                            size: 50,
                          )),
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
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      child: ToggleButtons(
        isSelected: _isSelected,
        onPressed: (int index) async {
          bool statut = false; // passager
          if (index == 0 && _isSelected[index] == false) {
            statut = false;
          } else if (index == 1 && _isSelected[index] == false) {
            statut = true;
          } else if (index == 1 && _isSelected[index] == true) {
            statut = false;
          } else if (index == 0 && _isSelected[index] == true) {
            statut = true;
          }
          setState(() {
            _isSelected[index] = !_isSelected[index];
            _isSelected[1 - index] = !_isSelected[1 - index];
          });
          await BaseDeDonnee().updateUtilisateurStatut(
              FirebaseAuth.instance.currentUser!.uid, statut);
        },
        selectedColor: Colors.white,
        disabledBorderColor: Colors.blue,
        fillColor: Colors.blue,
        borderRadius: BorderRadius.circular(20.0),
        disabledColor: Colors.white,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.06,
                vertical: screenSize.height * 0.015),
            child: Text(
              'Passager',
              style: TextStyle(fontFamily: 'Poppins'),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.06,
                vertical: screenSize.height * 0.015),
            child: Text(
              'Conducteur',
              style: TextStyle(fontFamily: 'Poppins'),
            ),
          ),
        ],
      ),
    );
  }
}
