import 'dart:collection';
import 'dart:developer';

import 'package:appcouvoiturage/Shared/location.dart';
import 'package:appcouvoiturage/pages/assistance.dart';
import 'package:appcouvoiturage/pages/details.dart';
import 'package:appcouvoiturage/pages/options.dart';
import 'package:appcouvoiturage/pages/profilepage.dart';
import 'package:appcouvoiturage/pages/trajet.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'Poppins'),
    home: const home(),
  ));
}

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int index = 0;
  late Position current_location;
  bool loading = true;
  @override
  void initState() {
    super.initState();
    LocationManager locationManager = LocationManager();
    locationManager.initialize(context).then((value) {
      loading = false;
      log(loading.toString());
    });
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  static const CameraPosition _pos = CameraPosition(
      target: LatLng(36.79302464414026, 2.918638530284433), zoom: 16);

  @override
  Widget build(BuildContext context) {
    late HashSet<Marker> markers = HashSet();
    final arg = ModalRoute.of(context)!.settings.arguments;
    List? args;
    if (arg != null) {
      args = arg as List;
    }
    dynamic arg1, arg2;
    // ignore: unnecessary_null_comparison
    if (args != null) {
      arg1 = args[0];
      arg2 = args[1];
      markers.add(args[2]);
    }
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    const double defaultPadding = 10;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _pos,
              onMapCreated: (controller) {
                _controller.complete(controller);
              },
              markers: markers,
              compassEnabled: true,
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
                              borderRadius: BorderRadius.circular(screenWidth *
                                  0.05), // use 5% of screen width as border radius
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => const OuAllezVous(),
                                    transition: Transition.fade);
                              },
                              child: TextField(
                                controller:
                                    TextEditingController(text: arg1 ?? ""),
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
                                  labelText: 'Choisir un point de depart',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                  border: InputBorder.none,
                                  // remove the border of the TextField
                                  prefixIcon: Icon(Icons.my_location,
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
                              borderRadius: BorderRadius.circular(screenWidth *
                                  0.05), // use 5% of screen width as border radius
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => const OuAllezVous(),
                                    transition: Transition.fade);
                              },
                              child: TextField(
                                controller:
                                    TextEditingController(text: arg2 ?? ""),
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
                                  labelText: 'Choisir une destination',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                  border: InputBorder.none,
                                  // remove the border of the TextField
                                  prefixIcon: Icon(Icons.location_on_outlined,
                                      color: Colors.blue),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.025),
                          // use 4% of screen height as space between text fields and row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const details()));
                },
                child: const Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.blue,
                  size: 50,
                ),
              ),
            ),
          ],
        ),

        bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() => this.index = index),
          height: screenHeight * 0.06,
          destinations: [
            const NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Actuel',
            ),
            NavigationDestination(
              icon: GestureDetector(
                child: const Icon(Icons.directions_car_filled_outlined),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const options()));
                  Get.to(() => const options(), transition: Transition.fade);
                },
              ),
              selectedIcon: const Icon(Icons.directions_car_filled),
              label: 'Trajets',
            ),
            NavigationDestination(
              icon: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Assistance()));
                    Get.to(() => const Assistance(),
                        transition: Transition.fade);
                  },
                  child: const Icon(Icons.question_answer_outlined)),
              selectedIcon: const Icon(Icons.question_answer),
              label: 'Assistane',
            ),
            NavigationDestination(
              icon: GestureDetector(
                child: const Icon(Icons.account_circle_outlined),
                onTap: () {
                  // Navigate to profile page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Profilepage()),
                  );
                  Get.to(() => const Profilepage(),
                      transition: Transition.leftToRightWithFade);
                },
              ),
              selectedIcon: const Icon(
                Icons.account_circle,
              ),
              label: 'Profile',
            ),
          ],
        ),

        // body: FlutterMap(
        //   options:  new MapOptions(
        //     center: new LatLng(36.7167, 3.13333),
        //       minZoom: 17.0
        //   ),
        //     layers : [
        //       new tilLayersOptions
        //     ]
        //   ),
      ),
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
        onPressed: (int index) {
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
        children: const [
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
