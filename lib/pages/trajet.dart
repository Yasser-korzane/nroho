import 'package:appcouvoiturage/Shared/location.dart';
import 'package:appcouvoiturage/pages/home.dart';
import 'package:appcouvoiturage/pages/map.dart';
import 'package:dio/dio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places_service/places_service.dart';
import 'package:geocoding/geocoding.dart';
import '../AppClasses/Trajet.dart';
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
  List<String> Places = ['Oued smar', 'Barougia', 'El Azizia', 'Bougaa', 'Maouklane','Oued smar', 'Barougia', 'El Azizia', 'Bougaa', 'Maouklane'];
  
  final TextEditingController _departController = TextEditingController();
  final TextEditingController _arriveController = TextEditingController();
  final BaseDeDonnee _baseDeDonnee = BaseDeDonnee();
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
  DateTime monDateEtTime = DateTime.now();
  DateTime monDateEtTime2 = DateTime.now();
  Trajet _trajet = BaseDeDonnee().creerTrajetVide();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2023, 4),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        monDateEtTime = DateTime(
            picked.year, picked.month, picked.day,
            _selectedTime!.hour, _selectedTime!.minute
        );
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        monDateEtTime2 = DateTime(
            _selectedDate!.year, _selectedDate!.month, _selectedDate!.day,
            picked.hour, picked.minute
        );
      });
    }
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
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
  }
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    // pour tester
    PlacesAutoCompleteResult lieuArrive = PlacesAutoCompleteResult(
      placeId: 'idPlace',
      description: 'une place',
      secondaryText: 'Algerie',
      mainText: 'Esi',
    );
    PlacesAutoCompleteResult lieuDepart = PlacesAutoCompleteResult(
      placeId: 'idPlace',
      description: 'une place',
      secondaryText: 'Algerie',
      mainText: 'Bouraoui',
    );
    _trajet = _baseDeDonnee.creerTrajetVide();
    _trajet.villeArrivee = 'Esi';
    _trajet.villeDepart = 'Bouraoui';
    _trajet.lieuDepart = lieuDepart;
    _trajet.lieuArrivee = lieuArrive;
    _trajet.villeIntermediaires = ['BeauLieu','Itemm'];
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
            title: const Text(
              'Où allez-vous ?',
              style: TextStyle(fontFamily: 'Poppins'),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const home()));
              },
              icon: const Icon(Icons.arrow_back),
            ),
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
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
                              style: const TextStyle(fontFamily: 'Poppins'),
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
                              style: const TextStyle(fontFamily: 'Poppins'),
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
                              ),
                            ),
                          ),
                        ]),
                      ]),
                  SizedBox(height: size.height * 0.01),
                  //DateTimePickerRow(monDateEtTime),
              Padding(
                padding: EdgeInsets.fromLTRB(screenWidth*0.07, 0, screenWidth*0.075, 0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: _selectDate,
                        icon: Icon(Icons.calendar_today),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: TextField(
                        readOnly: true,
                        onTap: _selectDate,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: screenHeight*0.00001,left: screenWidth*0.04),
                          hintText: _selectedDate == null
                              ? 'Select a date'
                              : '${_selectedDate!.toString().split(" ")[0]}',
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: _selectTime,
                        icon: Icon(Icons.access_time),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        readOnly: true,
                        onTap: _selectTime,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: screenHeight*0.0001,left: screenWidth*0.04),
                          hintText: _selectedTime == null
                              ? 'Select a time'
                              : '${_selectedTime!.format(context)}',
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
                ],
              ),
            ),
            expandedHeight: size.height * 0.265,
            // your app bar properties here
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
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
                          )
                          );
                        });
                      },
                      leading: const Icon(
                        Icons.location_on,
                        color: Colors.black,
                      ),
                      title: Text(
                        'choisir sur la map',
                        style: TextStyle(
                            fontSize: size.width * 0.04, fontFamily: 'Poppins'),
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
                            fontSize: size.width * 0.04, fontFamily: 'Poppins'),
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
                              style: TextStyle(fontFamily: 'Poppins'),
                            );
                          }
                        }),
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.045,
                          child: ListTile(
                            onTap: () {},
                            tileColor: const Color(0XFFD3D3D3),
                            title: Text(
                              'Historique des recherches',
                              style: TextStyle(
                                  fontSize: size.width * 0.04,
                                  fontFamily: 'Poppins'),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                      // Expanded(
                      //   child: ListView.separated(
                      //     // separatorBuilder: (context, index) => Divider(
                      //     //   thickness: 1.0,
                      //     //   color: Colors.grey[300],
                      //     // ),
                      //     itemCount: Places.length,
                      //     itemBuilder: (context, index) {
                      //       return Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: ListTile(
                      //           onTap: () {},
                      //           leading: const Icon(
                      //             Icons.location_on,
                      //             color: Colors.black,
                      //           ),
                      //           title: Text(
                      //             Places[index],
                      //             style: TextStyle(
                      //                 fontSize: size.width * 0.04,
                      //                 fontFamily: 'Poppins'),
                      //           ),
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // )
                      ],
                    ),
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
            onPressed: () async{
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
                        Text("Please fill all the informations",                                style: TextStyle(fontFamily: 'Poppins'),
                        )));
              }*/
              _trajet.dateDepart = DateTime(monDateEtTime.year,monDateEtTime.month,monDateEtTime.day,monDateEtTime2.hour,monDateEtTime2.minute);
              _trajet.afficher();
              if (statut == false) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>  options(_trajet)));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  optionconduc(_trajet)));
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
            ),
            child: const Text(
              'Valider',
              style: TextStyle(
                  color: Colors.white, fontSize: 16, fontFamily: 'Poppins'),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
