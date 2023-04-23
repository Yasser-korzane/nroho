import 'package:appcouvoiturage/Shared/location.dart';
import 'package:appcouvoiturage/pages/home.dart';
import 'package:appcouvoiturage/pages/map.dart';
import 'package:dio/dio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:appcouvoiturage/widgets/date_time.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places_service/places_service.dart';
import 'package:geocoding/geocoding.dart';
import '../Services/base de donnee.dart';
import 'optionsconducteur.dart';
import 'optionspassager.dart';

enum Selected { depart, arrivee, none }

class OuAllezVous extends StatefulWidget {
  const OuAllezVous({super.key});

  @override
  State<OuAllezVous> createState() => _OuAllezVousState();
}

class _OuAllezVousState extends State<OuAllezVous> {
  final TextEditingController _departController = TextEditingController();
  final TextEditingController _arriveController = TextEditingController();
  BaseDeDonnee _baseDeDonnee = BaseDeDonnee();
  bool statut = false;

  String querry = "";
  bool fromMap = false;
  String? arrive, depart;
  LatLng? departCoord, arriveCoord;
  bool showSuggestion = true;
  PlacesAutoCompleteResult? departData, ArriveData;
  Selected caseSelected = Selected.none;
  Position? current_location;
  final LocationManager _location = LocationManager();
  final _placesService = PlacesService();
  BitmapDescriptor customMarker = BitmapDescriptor.defaultMarker;

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

  Future<dynamic> getPlaceFromId(String placeID) async {
    var response = await Dio().get(
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeID&key=AIzaSyC9sGlH43GL0Jer73n9ETKsxNpZqvrWn-k");
    return response.data;
  }

  Future<dynamic> getPredictions(String querry) async {
    List<PlacesAutoCompleteResult>? response;
    if (querry != "") {
      response = await _placesService.getAutoComplete(querry);
    }
    return response;
  }

  void setCustomMarker() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/images/marker.png")
        .then((icon) => customMarker = icon);
  }

  @override
  void initState() {
    super.initState();
    getStatut();
    _location.initialize(context);
    setCustomMarker();
    _placesService.initialize(
        apiKey: "AIzaSyC9sGlH43GL0Jer73n9ETKsxNpZqvrWn-k");
  }

  @override
  Widget build(BuildContext context) {
    final position =
        ModalRoute.of(context)!.settings.arguments as CameraPosition?;
    if (position != null) {
      GeocodingPlatform.instance
          .placemarkFromCoordinates(
              position.target.latitude, position.target.longitude)
          .then((value) {
        fromMap = true;
        arrive = value[0].locality!;
        _arriveController.text = arrive!;
      });
    }
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: false,
            pinned: true,
            title: Text(
              'Où allez-vous ?',
              style: TextStyle(fontFamily: 'Popping'),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => home()));
              },
              icon: Icon(Icons.arrow_back),
            ),
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.1),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              const Icon(Icons.gps_fixed),
                              // SizedBox(height: screenHeight * 0.03),
                              Container(
                                height: 32,
                                width: 1,
                                color: Colors.grey,
                              ),
                              // SizedBox(height: screenHeight * 0.03),
                              const Icon(
                                Icons.location_on,
                              ),
                            ],
                          ), //icons
                          Column(children: [
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            SizedBox(
                              width: size.width * 0.7,
                              height: size.height * 0.05,
                              child: TextField(
                                style: TextStyle(fontFamily: 'Popping'),
                                controller: _departController,
                                onChanged: (value) {
                                  setState(() {
                                    showSuggestion = true;
                                    querry = value;
                                    caseSelected = Selected.depart;
                                  });
                                },
                                decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Départ',
                                  labelText: 'Départ',
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            SizedBox(
                              width: size.width * 0.7,
                              height: size.height * 0.05,
                              child: TextField(
                                style: TextStyle(fontFamily: 'Popping'),
                                controller: _arriveController,
                                onChanged: (value) {
                                  setState(() {
                                    showSuggestion = true;
                                    querry = value;
                                    caseSelected = Selected.arrivee;
                                  });
                                },
                                decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Arrivée',
                                  labelText: 'Arrivée',
                                ),
                              ),
                            ),
                          ]),
                        ]),
                    SizedBox(height: size.height * 0.01),
                    DateTimePickerRow(),
                  ],
                ),
              ),
            ),
            expandedHeight: size.height * 0.265,
            // your app bar properties here
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  const Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const MapPage();
                            },
                          ));
                        });
                      },
                      leading: const Icon(
                        Icons.location_on,
                        color: Colors.black,
                      ),
                      title: Text(
                        'choisir sur la map',
                        style: TextStyle(
                            fontSize: size.width * 0.04, fontFamily: 'Popping'),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          depart = "Current Position";
                          _departController.value = TextEditingValue(
                            text: "Current Position",
                            selection: TextSelection.fromPosition(
                              const TextPosition(
                                  offset: "Current Position".length),
                            ),
                          );
                        });
                      },
                      leading: const Icon(
                        Icons.gps_fixed,
                        color: Colors.black,
                      ),
                      title: Text(
                        'Utiliser ma position',
                        style: TextStyle(
                            fontSize: size.width * 0.04, fontFamily: 'Popping'),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  Visibility(
                    visible: (_arriveController.text.isEmpty ||
                            _arriveController.text
                                .contains('Current Position')) &&
                        (_departController.text.isEmpty ||
                            _departController.text
                                .contains('Current Position')),
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.045,
                          child: ListTile(
                            onTap: () {},
                            tileColor: Color(0XFFD3D3D3),
                            title: Text(
                              'Historique des recherches',
                              style: TextStyle(
                                  fontSize: size.width * 0.04,
                                  fontFamily: 'Popping'),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                          child: ListTile(
                            onTap: () {},
                            leading: const Icon(
                              Icons.location_on,
                              color: Colors.black,
                            ),
                            title: Text(
                              'Maoklane-Setif',
                              style: TextStyle(
                                  fontSize: size.width * 0.04,
                                  fontFamily: 'Popping'),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                          child: ListTile(
                            onTap: () {},
                            leading: const Icon(
                              Icons.location_on,
                              color: Colors.black,
                            ),
                            title: Text(
                              'Oued Smar-Alger',
                              style: TextStyle(
                                  fontSize: size.width * 0.04,
                                  fontFamily: 'Popping'),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                          child: ListTile(
                            onTap: () {},
                            leading: const Icon(
                              Icons.location_on,
                              color: Colors.black,
                            ),
                            title: Text(
                              'Oued Smar-Alger',
                              style: TextStyle(fontSize: size.width * 0.04),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                          child: ListTile(
                            onTap: () {},
                            leading: const Icon(
                              Icons.location_on,
                              color: Colors.black,
                            ),
                            title: Text(
                              'Oued Smar-Alger',
                              style: TextStyle(fontSize: size.width * 0.04),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                          child: ListTile(
                            onTap: () {},
                            leading: const Icon(
                              Icons.location_on,
                              color: Colors.black,
                            ),
                            title: Text(
                              'Oued Smar-Alger',
                              style: TextStyle(fontSize: size.width * 0.04),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                          child: ListTile(
                            onTap: () {},
                            leading: const Icon(
                              Icons.location_on,
                              color: Colors.black,
                            ),
                            title: Text(
                              'Oued Smar-Alger',
                              style: TextStyle(fontSize: size.width * 0.04),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                          child: ListTile(
                            onTap: () {},
                            leading: const Icon(
                              Icons.location_on,
                              color: Colors.black,
                            ),
                            title: Text(
                              'Oued Smar-Alger',
                              style: TextStyle(fontSize: size.width * 0.04),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                          child: ListTile(
                            onTap: () {},
                            leading: const Icon(
                              Icons.location_on,
                              color: Colors.black,
                            ),
                            title: Text(
                              'Oued Smar-Alger',
                              style: TextStyle(fontSize: size.width * 0.04),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                          child: ListTile(
                            onTap: () {},
                            leading: const Icon(
                              Icons.location_on,
                              color: Colors.black,
                            ),
                            title: Text(
                              'Oued Smar-Alger',
                              style: TextStyle(fontSize: size.width * 0.04),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                          child: ListTile(
                            onTap: () {},
                            leading: const Icon(
                              Icons.location_on,
                              color: Colors.black,
                            ),
                            title: Text(
                              'Oued Smar-Alger',
                              style: TextStyle(fontSize: size.width * 0.04),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                          child: ListTile(
                            onTap: () {},
                            leading: const Icon(
                              Icons.location_on,
                              color: Colors.black,
                            ),
                            title: Text(
                              'Oued Smar-Alger',
                              style: TextStyle(fontSize: size.width * 0.04),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                          child: ListTile(
                            onTap: () {},
                            leading: const Icon(
                              Icons.location_on,
                              color: Colors.black,
                            ),
                            title: Text(
                              'Oued Smar-Alger',
                              style: TextStyle(fontSize: size.width * 0.04),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                          child: ListTile(
                            onTap: () {},
                            leading: const Icon(
                              Icons.location_on,
                              color: Colors.black,
                            ),
                            title: Text(
                              'Oued Smar-Alger',
                              style: TextStyle(fontSize: size.width * 0.04),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                          child: ListTile(
                            onTap: () {},
                            leading: const Icon(
                              Icons.location_on,
                              color: Colors.black,
                            ),
                            title: Text(
                              'Oued Smar-Alger',
                              style: TextStyle(fontSize: size.width * 0.04),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                          child: ListTile(
                            onTap: () {},
                            leading: const Icon(
                              Icons.location_on,
                              color: Colors.black,
                            ),
                            title: Text(
                              'Oued Smar-Alger',
                              style: TextStyle(fontSize: size.width * 0.04),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                          child: ListTile(
                            onTap: () {},
                            leading: const Icon(
                              Icons.location_on,
                              color: Colors.black,
                            ),
                            title: Text(
                              'Oued Smar-Alger',
                              style: TextStyle(fontSize: size.width * 0.04),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                          child: ListTile(
                            onTap: () {},
                            leading: const Icon(
                              Icons.location_on,
                              color: Colors.black,
                            ),
                            title: Text(
                              'Oued Smar-Alger',
                              style: TextStyle(fontSize: size.width * 0.04),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                          child: ListTile(
                            onTap: () {},
                            leading: const Icon(
                              Icons.location_on,
                              color: Colors.black,
                            ),
                            title: Text(
                              'Oued Smar-Alger',
                              style: TextStyle(fontSize: size.width * 0.04),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                          child: ListTile(
                            onTap: () {},
                            leading: const Icon(
                              Icons.location_on,
                              color: Colors.black,
                            ),
                            title: Text(
                              'Oued Smar-Alger',
                              style: TextStyle(fontSize: size.width * 0.04),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                          child: ListTile(
                            onTap: () {},
                            leading: const Icon(
                              Icons.location_on,
                              color: Colors.black,
                            ),
                            title: Text(
                              'Oued Smar-Alger',
                              style: TextStyle(fontSize: size.width * 0.04),
                            ),
                          ),
                        ),
                      ],
                    ),
                    replacement: FutureBuilder(
                        future: getPredictions(querry),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasData && showSuggestion) {
                              return ListView.separated(
                                separatorBuilder: (context, index) {
                                  return const Divider(
                                    thickness: 1,
                                  );
                                },
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  var data = snapshot.data[index];
                                  var prediction = data.description;
                                  return ListTile(
                                    onTap: () {
                                      setState(() {
                                        showSuggestion = false;
                                        switch (caseSelected) {
                                          case Selected.depart:
                                            departData = data;
                                            depart = prediction;
                                            _departController.value =
                                                TextEditingValue(
                                              text: depart!,
                                              selection:
                                                  TextSelection.fromPosition(
                                                TextPosition(
                                                    offset: depart!.length),
                                              ),
                                            );
                                            break;
                                          case Selected.arrivee:
                                            ArriveData = data;
                                            arrive = prediction;
                                            _arriveController.value =
                                                TextEditingValue(
                                              text: arrive!,
                                              selection:
                                                  TextSelection.fromPosition(
                                                TextPosition(
                                                    offset: arrive!.length),
                                              ),
                                            );
                                            break;
                                          default:
                                        }
                                      });
                                    },
                                    title: Text(prediction),
                                  );
                                },
                              );
                            } else {
                              return const Center();
                            }
                          } else {
                            return const Text(
                              "Recherche...",
                              style: TextStyle(fontFamily: 'Popping'),
                            );
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: size.width * 0.51,
          height: size.height * 0.048,
          child: ElevatedButton(
            onPressed: () {
              /*if (depart != null && arrive != null) {
                if (departData != null) {
                  getPlaceFromId(departData!.placeId!).then((value) {
                    var lat =
                    value["result"]["geometry"]["location"]["lat"];
                    var lng =
                    value["result"]["geometry"]["location"]["lng"];
                    departCoord = LatLng(lat, lng);
                    Marker departMarker = Marker(
                      markerId: MarkerId(depart.toString()),
                      position: departCoord!,
                    );
                    getPlaceFromId(ArriveData!.placeId!).then((value) {
                      var lat = value["result"]["geometry"]["location"]
                      ["lat"];
                      var lng = value["result"]["geometry"]["location"]
                      ["lng"];
                      arriveCoord = LatLng(lat, lng);
                      Marker arriveMarker = Marker(
                        markerId: MarkerId(arrive.toString()),
                        position: arriveCoord!,
                      );

                      Navigator.pushNamed(context, "home", arguments: [
                        depart,
                        arrive,
                        departMarker,
                        arriveMarker,
                        departCoord,
                        arriveCoord,
                        false
                      ]);
                    });
                  });
                } else {
                  if (!fromMap) {
                    getPlaceFromId(ArriveData!.placeId!).then((value) {
                      var lat = value["result"]["geometry"]["location"]
                      ["lat"];
                      var lng = value["result"]["geometry"]["location"]
                      ["lng"];
                      arriveCoord = LatLng(lat, lng);
                      Marker arriveMarker = Marker(
                        markerId: MarkerId(arrive.toString()),
                        position: arriveCoord!,
                      );
                      Marker currentPosMarker = Marker(
                          markerId: MarkerId(depart.toString()),
                          position: LatLng(
                              _location.getCurrentPos.latitude,
                              _location.getCurrentPos.longitude));

                      Navigator.pushNamed(context, "home", arguments: [
                        depart,
                        arrive,
                        currentPosMarker,
                        arriveMarker,
                        LatLng(_location.getCurrentPos.latitude,
                            _location.getCurrentPos.longitude),
                        arriveCoord,
                        true
                      ]);
                    });
                  } else {
                    Marker arriveMarker = Marker(
                        position: LatLng(position!.target.latitude,
                            position.target.longitude),
                        markerId: MarkerId(depart.toString()));
                    Marker currentPosMarker = Marker(
                        markerId: MarkerId(depart.toString()),
                        position: LatLng(
                            _location.getCurrentPos.latitude,
                            _location.getCurrentPos.longitude));
                    arriveCoord = LatLng(position.target.latitude,
                        position.target.longitude);
                    Navigator.pushNamed(context, "home", arguments: [
                      depart,
                      arrive,
                      currentPosMarker,
                      arriveMarker,
                      LatLng(_location.getCurrentPos.latitude,
                          _location.getCurrentPos.longitude),
                      arriveCoord,
                      true
                    ]);
                  }
                }
              }*/

              /*else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                        Text("Please fill all the informations",                                style: TextStyle(fontFamily: 'Popping'),
                        )));
              }*/
              if (statut == false) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const options()));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const optionconduc()));
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
            ),
            child: const Text(
              'Valider',
              style: TextStyle(
                  color: Colors.white, fontSize: 16, fontFamily: 'Popping'),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
