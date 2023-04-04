import 'dart:async';
import 'dart:collection';
import 'package:appcouvoiturage/Shared/location.dart';
import 'package:appcouvoiturage/pages/assistance.dart';
import 'package:appcouvoiturage/pages/details.dart';
import 'package:appcouvoiturage/pages/options.dart';
import 'package:appcouvoiturage/pages/profilepage.dart';
import 'package:appcouvoiturage/pages/trajet.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;

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
  late HashSet<Marker> markers;
  int index = 0;
  Position? current_location;
  BitmapDescriptor locationMarker = BitmapDescriptor.defaultMarker;
  bool loading = true;

  @override
  void initState() {
    super.initState();
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

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
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
        body: current_location == null
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            : Stack(
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(current_location!.latitude,
                            current_location!.longitude),
                        zoom: 13.5),
                    onMapCreated: (controller) {
                      _controller.complete(controller);
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
                                          text: arg1 ?? ""),
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
                                          text: arg2 ?? ""),
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
                                        prefixIcon: Icon(
                                            Icons.location_on_outlined,
                                            color: Colors.blue),
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
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Profilepage()));
                    Get.to(() => const Profilepage(),
                        transition: Transition.leftToRightWithFade);
                  },
                  child: const Icon(Icons.account_circle_outlined)),
              selectedIcon: const Icon(Icons.account_circle),
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
