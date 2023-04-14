<<<<<<< Updated upstream
=======
import 'dart:async';
import 'dart:collection';
import 'package:appcouvoiturage/Shared/location.dart';
import 'package:appcouvoiturage/pages/tragetLancer.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
>>>>>>> Stashed changes
import 'package:appcouvoiturage/pages/assistance.dart';
import 'package:appcouvoiturage/pages/details.dart';
import 'package:appcouvoiturage/pages/options.dart';
import 'package:appcouvoiturage/pages/profilepage.dart';
import 'package:appcouvoiturage/pages/trajet.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
   int get(){
    return _homeState().selectedIndex;
  }
}

class _homeState extends State<home> {
  int index = 0;
<<<<<<< Updated upstream
  int selectedIndex = RideTypeSelector().getSelectedIndex();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery
        .of(context)
        .size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final double defaultPadding = 10;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image(
              image: NetworkImage(
                  'https://assets.website-files.com/5e832e12eb7ca02ee9064d42/5f7db426b676b95755fb2844_Group%20805.jpg'),
              fit: BoxFit.cover, // Cover the whole stack with the image
              height: double.infinity,
              width: double.infinity,
            ),
            // Your main page content goes here
            Container(
              child: Column(
                children: [
                  Expanded(flex: 60,child: Container()),
                  Expanded(flex: 40 ,child: Container(
=======
  Position? current_location;
  BitmapDescriptor locationMarker = BitmapDescriptor.defaultMarker;
  bool loading = true;
  final Set<Polyline> _polylineSet = <Polyline>{};
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
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
    int index = 0;
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
    return Scaffold(
      body: current_location == null
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
>>>>>>> Stashed changes
                    padding: EdgeInsets.all(screenWidth * 0.1),
                    // use 10% of screen width as padding
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
<<<<<<< Updated upstream
                            borderRadius: BorderRadius.circular(screenWidth *
                                0.05), // use 5% of screen width as border radius
                          ),
                          child: TextField(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Trajet(),));
                            },
                            decoration: InputDecoration(
                              labelText: 'Entrer la place de depart',
                              floatingLabelBehavior:
                              FloatingLabelBehavior.auto,
                              border: InputBorder.none,
                              // remove the border of the TextField
                              prefixIcon: Icon(Icons.my_location,
                                  color: Colors.blue),
=======
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
                                labelText: 'Choisir un point de depart',
                                floatingLabelBehavior:
                                FloatingLabelBehavior.auto,
                                border: InputBorder.none,
                                // remove the border of the TextField
                                prefixIcon: Icon(
                                    isUsingCurrentLocation
                                        ? Icons.gps_fixed
                                        : Icons.gps_not_fixed,
                                    color: Colors.blue),
                              ),
>>>>>>> Stashed changes
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        // use 3% of screen height as space between text fields
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
<<<<<<< Updated upstream
                            borderRadius: BorderRadius.circular(screenWidth *
                                0.05), // use 5% of screen width as border radius
                          ),
                          child: TextField(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Trajet(),));
                            },
                            decoration: InputDecoration(
                              labelText: 'Entrer la place d arivee',
                              floatingLabelBehavior:
                              FloatingLabelBehavior.auto,
                              border: InputBorder.none,
                              // remove the border of the TextField
                              prefixIcon: Icon(Icons.location_on_outlined,
                                  color: Colors.blue),
=======
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
                                labelText: 'Choisir une destination',
                                floatingLabelBehavior:
                                FloatingLabelBehavior.auto,
                                border: InputBorder.none,
                                // remove the border of the TextField
                                prefixIcon: Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.blue),
                              ),
>>>>>>> Stashed changes
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.025),
                        // use 4% of screen height as space between text fields and row
                        Row(
<<<<<<< Updated upstream
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
=======
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          children: const [
>>>>>>> Stashed changes
                            RideTypeSelector(),
                          ],
                        ),
                      ],
                    ),
                  ),
<<<<<<< Updated upstream
                  )
                ],
              ),
            ),
            Positioned(
              top: screenHeight*0.03,
              right: screenWidth*0.04,
              child: InkWell(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => details()));
                },
                child: Icon(
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
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Actuel',
            ),

            NavigationDestination(
              icon: GestureDetector(
                child: Icon(Icons.directions_car_filled_outlined),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => options()));
                },
              ),
              selectedIcon: Icon(Icons.directions_car_filled),
              label: 'Trajets',
            ),
            NavigationDestination(
              icon: GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Assistance()));
                },
                  child: Icon(Icons.question_answer_outlined)),
              selectedIcon: Icon(Icons.question_answer),
              label: 'Assistane',
            ),
            NavigationDestination(
              icon: GestureDetector(
                child: Icon(Icons.account_circle_outlined),
                onTap: () {
                  // Navigate to profile page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profilepage()),
                  );
                },
              ),
              selectedIcon: Icon(
                Icons.account_circle,
              ),
              label: 'Profile',
=======
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
>>>>>>> Stashed changes
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: screenHeight * 0.075,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[700]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: Icons.home,
                  onPressed: (){

                  },
                  text: 'Actuel',
                ),
                GButton(
                  icon: Icons.directions_car_filled,
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => cardLancerList()));
                  },
                  text: 'Trajets',
                ),
                GButton(
                  icon: Icons.question_answer_outlined,
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  Assistance()));
                  },
                  text: 'Assistance',
                ),
                GButton(
                  icon: Icons.account_circle_outlined,
                  onPressed: (){
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) =>Profilepage()));
                  },
                  text: 'Profile',
                ),
              ],
              selectedIndex: index,
                 onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              }
            ),
          ),
        ),
      ),
    );

    // return SafeArea(
    //   child: Scaffold(
    //     body: current_location == null
    //         ? const Center(
    //         child: CircularProgressIndicator(
    //         color: Colors.blue,
    //       ),
    //     )
    //         : Stack(
    //             children: [
    //               GoogleMap(
    //                 polylines: _polylineSet,
    //                 mapType: MapType.normal,
    //                 initialCameraPosition: CameraPosition(
    //                     target: LatLng(current_location!.latitude,
    //                         current_location!.longitude),
    //                     zoom: 13.5),
    //                 onMapCreated: (controller) {
    //                   _controller.complete(controller);
    //                   if (!noMarkersAdded) {
    //                     setPolylines(departCoord!, arriveCoord!);
    //                   }
    //                 },
    //                 markers: markers,
    //               ),
    //               // Your main page content goes here
    //               Container(
    //                 child: Column(
    //                   children: [
    //                     Expanded(flex: 60, child: Container()),
    //                     Expanded(
    //                       flex: 40,
    //                       child: Container(
    //                         padding: EdgeInsets.all(screenWidth * 0.1),
    //                         // use 10% of screen width as padding
    //                         child: Column(
    //                           children: [
    //                             Container(
    //                               decoration: BoxDecoration(
    //                                 color: Colors.white,
    //                                 borderRadius: BorderRadius.circular(
    //                                     screenWidth *
    //                                         0.05), // use 5% of screen width as border radius
    //                               ),
    //                               child: GestureDetector(
    //                                 onTap: () {
    //                                   Get.to(() => const OuAllezVous(),
    //                                       transition: Transition.fade);
    //                                 },
    //                                 child: TextField(
    //                                   controller: TextEditingController(
    //                                       text: depart ?? ""),
    //                                   onTap: () {
    //                                     Navigator.push(
    //                                         context,
    //                                         MaterialPageRoute(
    //                                           builder: (context) =>
    //                                               const OuAllezVous(),
    //                                         ));
    //                                   },
    //                                   readOnly: true,
    //                                   decoration: InputDecoration(
    //                                     labelText: 'Choisir un point de depart',
    //                                     floatingLabelBehavior:
    //                                         FloatingLabelBehavior.auto,
    //                                     border: InputBorder.none,
    //                                     // remove the border of the TextField
    //                                     prefixIcon: Icon(
    //                                         isUsingCurrentLocation
    //                                             ? Icons.gps_fixed
    //                                             : Icons.gps_not_fixed,
    //                                         color: Colors.blue),
    //                                   ),
    //                                 ),
    //                               ),
    //                             ),
    //                             SizedBox(height: screenHeight * 0.015),
    //                             // use 3% of screen height as space between text fields
    //                             Container(
    //                               decoration: BoxDecoration(
    //                                 color: Colors.white,
    //                                 borderRadius: BorderRadius.circular(
    //                                     screenWidth *
    //                                         0.05), // use 5% of screen width as border radius
    //                               ),
    //                               child: GestureDetector(
    //                                 onTap: () {
    //                                   Get.to(() => const OuAllezVous(),
    //                                       transition: Transition.fade);
    //                                 },
    //                                 child: TextField(
    //                                   controller: TextEditingController(
    //                                       text: arrive ?? ""),
    //                                   onTap: () {
    //                                     Navigator.push(
    //                                         context,
    //                                         MaterialPageRoute(
    //                                           builder: (context) =>
    //                                               const OuAllezVous(),
    //                                         ));
    //                                   },
    //                                   readOnly: true,
    //                                   decoration: const InputDecoration(
    //                                     labelText: 'Choisir une destination',
    //                                     floatingLabelBehavior:
    //                                         FloatingLabelBehavior.auto,
    //                                     border: InputBorder.none,
    //                                     // remove the border of the TextField
    //                                     prefixIcon: Icon(
    //                                         Icons.location_on_outlined,
    //                                         color: Colors.blue),
    //                                   ),
    //                                 ),
    //                               ),
    //                             ),
    //                             SizedBox(height: screenHeight * 0.025),
    //                             // use 4% of screen height as space between text fields and row
    //                             Row(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.spaceEvenly,
    //                               children: const [
    //                                 RideTypeSelector(),
    //                               ],
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //               Positioned(
    //                 top: screenHeight * 0.03,
    //                 right: screenWidth * 0.04,
    //                 child: InkWell(
    //                   onTap: () {
    //                     Navigator.push(
    //                         context,
    //                         MaterialPageRoute(
    //                             builder: (context) => const details()));
    //                   },
    //                   child: const Icon(
    //                     Icons.notifications_none_outlined,
    //                     color: Colors.blue,
    //                     size: 50,
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //
    //     // bottomNavigationBar: NavigationBar(
    //     //   selectedIndex: index,
    //     //   onDestinationSelected: (index) => setState(() => this.index = index),
    //     //   height: screenHeight * 0.06,
    //     //   destinations: [
    //     //     const NavigationDestination(
    //     //       icon: Icon(Icons.home_outlined),
    //     //       selectedIcon: Icon(Icons.home),
    //     //       label: 'Actuel',
    //     //     ),
    //     //     NavigationDestination(
    //     //       icon: GestureDetector(
    //     //         child: const Icon(Icons.directions_car_filled_outlined),
    //     //         onTap: () {
    //     //           Navigator.push(context,
    //     //               MaterialPageRoute(builder: (context) => const options()));
    //     //           Get.to(() => const options(), transition: Transition.fade);
    //     //         },
    //     //       ),
    //     //       selectedIcon: const Icon(Icons.directions_car_filled),
    //     //       label: 'Trajets',
    //     //     ),
    //     //     NavigationDestination(
    //     //       icon: GestureDetector(
    //     //           onTap: () {
    //     //             Navigator.push(
    //     //                 context,
    //     //                 MaterialPageRoute(
    //     //                     builder: (context) => const Assistance()));
    //     //             Get.to(() => const Assistance(),
    //     //                 transition: Transition.fade);
    //     //           },
    //     //           child: const Icon(Icons.question_answer_outlined)),
    //     //       selectedIcon: const Icon(Icons.question_answer),
    //     //       label: 'Assistane',
    //     //     ),
    //     //     NavigationDestination(
    //     //       icon: GestureDetector(
    //     //           onTap: () {
    //     //             Navigator.push(
    //     //                 context,
    //     //                 MaterialPageRoute(
    //     //                     builder: (context) => const Profilepage()));
    //     //             Get.to(() => const Profilepage(),
    //     //                 transition: Transition.leftToRightWithFade);
    //     //           },
    //     //           child: const Icon(Icons.account_circle_outlined)),
    //     //       selectedIcon: const Icon(Icons.account_circle),
    //     //       label: 'Profile',
    //     //     ),
    //     //   ],
    //     // ),
    //
    //   ),
    // );
  }
}

class RideTypeSelector extends StatefulWidget {
  get _isSelected => RideTypeSelector()._isSelected;

  @override
  _RideTypeSelectorState createState() => _RideTypeSelectorState();
  int getSelectedIndex() {
    return _isSelected.indexOf(true);
  }
}

class _RideTypeSelectorState extends State<RideTypeSelector> {
  List<bool> _isSelected = [true, false];

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
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
            child: Text('Take a ride'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: Text('Announce a ride'),
          ),
        ],
        disabledColor: Colors.white,
      ),
    );
  }
}
