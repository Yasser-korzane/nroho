import 'dart:convert';

import 'package:nroho/Shared/location.dart';
import 'package:nroho/pages/AjouterVillesIntermedieres.dart';
import 'package:nroho/pages/map.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:places_service/places_service.dart';

import '../AppClasses/Trajet.dart';
import '../Services/base de donnee.dart';
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
  final BaseDeDonnee _baseDeDonnee = BaseDeDonnee();
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
  PlacesAutoCompleteResult placeD = PlacesAutoCompleteResult(
      placeId: '', description: '', mainText: '', secondaryText: '');
  PlacesAutoCompleteResult placeA = PlacesAutoCompleteResult(
      placeId: '', description: '', mainText: '', secondaryText: '');
  BitmapDescriptor customMarker = BitmapDescriptor.defaultMarker;
  String? idD;
  String? descriptionD;
  String? mainTextD;
  String? secondaryTextD;
  String? idA;
  String? descriptionA;
  String? mainTextA;
  String? secondaryTextA;
  LatLng latLngD = LatLng(0, 0);
  LatLng latLngA = LatLng(0, 0);
  bool statut = false;
  DateTime monDateEtTime = DateTime.now();
  DateTime monDateEtTime2 = DateTime.now();
  Trajet _trajet = BaseDeDonnee().creerTrajetVide();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool isLoading = false;
  bool _isLoadingC = false;

  /// -------------------------------------------------------------------------------------------------
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        monDateEtTime = DateTime(picked.year, picked.month, picked.day,
            _selectedTime!.hour, _selectedTime!.minute);
      });
    }
  }

  /// -------------------------------------------------------------------------------------------------

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        monDateEtTime2 = DateTime(_selectedDate!.year, _selectedDate!.month,
            _selectedDate!.day, picked.hour, picked.minute);
      });
    }
  }

  /// -------------------------------------------------------------------------------------------------
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

  /// -------------------------------------------------------------------------------------------------
  Future<dynamic> getPlaceFromId(String placeID) async {
    var response = await Dio().get(
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeID&key=AIzaSyC9sGlH43GL0Jer73n9ETKsxNpZqvrWn-k");
    return response.data;
  }

  /// -------------------------------------------------------------------------------------------------
  Future<dynamic> getPredictions(String querry) async {
    List<PlacesAutoCompleteResult>? response;
    if (querry != "") {
      response = await _placesService.getAutoComplete(querry);
    }
    return response;
  }

  /// -------------------------------------------------------------------------------------------------
  void setCustomMarker() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/images/marker.png")
        .then((icon) => customMarker = icon);
  }
  /// -------------------------------------------------------------------------------------------------
  Future<PlacesAutoCompleteResult> getPlaceFromLatLng(
      double lat, double lng) async {
    final String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyC9sGlH43GL0Jer73n9ETKsxNpZqvrWn-k';
    final http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final decodedJson = jsonDecode(response.body);
      final formattedAddress = decodedJson['results'][0]['formatted_address'];
      final placeId = decodedJson['results'][0]['place_id'];
      final mainText =
          decodedJson['results'][0]['address_components'][0]['long_name'];
      final secondaryText =
          decodedJson['results'][0]['address_components'][1]['long_name'];
      return PlacesAutoCompleteResult(
          placeId: placeId,
          description: formattedAddress,
          mainText: mainText,
          secondaryText: secondaryText);
    } else {
      throw Exception('Failed to load place from API');
    }
  }

  /// -------------------------------------------------------------------------------------------------
  Future<LatLng> getPlaceLatLng(String placeId) async {
    String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=AIzaSyC9sGlH43GL0Jer73n9ETKsxNpZqvrWn-k';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      double lat = result['result']['geometry']['location']['lat'];
      double lng = result['result']['geometry']['location']['lng'];
      return LatLng(lat, lng);
    } else {
      throw Exception('Failed to load place');
    }
  }

  /// -------------------------------------------------------------------------------------------------
  Future<DateTime> calculateArrivalTime(DateTime dateDebut,double latD, double lngD, double latA, double lngA) async {
    const apiKey = 'AIzaSyC9sGlH43GL0Jer73n9ETKsxNpZqvrWn-k';
    final url = Uri.parse('https://maps.googleapis.com/maps/api/directions/json?origin=$latD,$lngD&destination=$latA,$lngA&key=$apiKey');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      final durationText = decodedResponse['routes'][0]['legs'][0]['duration']['text'];
      final estimatedDuration = parseDuration(durationText);
      final currentTime = dateDebut;
      final arrivalTime = currentTime.add(estimatedDuration);
      return arrivalTime;
    } else {
      throw Exception('Error: ${response.statusCode}');
    }
  }
  Duration parseDuration(String durationText) {
    int totalDuration = 0;
    durationText = durationText.replaceAll(' ', '');
    String d1 = durationText ;
    if (durationText.contains('day') || durationText.contains('days')) {
      int indexOfDays = 0 ;
      if (durationText.contains('day') && !durationText.contains('days')){
        indexOfDays = durationText.indexOf('day');
        d1 = durationText.replaceAll(RegExp(r'.*day'), '');
      }
      else if (durationText.contains('days')){
        indexOfDays = durationText.indexOf('days');
        d1 = durationText.replaceAll(RegExp(r'.*days'), '');
      }
      String value = durationText.substring(0, indexOfDays).trim();
      totalDuration += int.parse(value) * 24 * 60 * 60;
      int indexOfHours = d1.indexOf('hour');
      value = d1.substring(0, indexOfHours).trim();
      totalDuration += int.parse(value) * 60 * 60 ;
    } else if (durationText.contains('hour') || durationText.contains('hours')) {
      int indexOfHours = 0 ;
      if (durationText.contains('hour') && !durationText.contains('hours')){
        indexOfHours = durationText.indexOf('hour');
        d1 = durationText.replaceAll(RegExp(r'.*hour'), '');
      }
      else if (durationText.contains('hours')){
        indexOfHours = durationText.indexOf('hours');
        d1 = durationText.replaceAll(RegExp(r'.*hours'), '');
      }
      String value = durationText.substring(0, indexOfHours).trim();
      totalDuration += int.parse(value) * 60 * 60;
      int indexOfMinutes = d1.indexOf('min');
      value = d1.substring(0, indexOfMinutes).trim();
      totalDuration += int.parse(value) * 60 ;
    } else if (durationText.contains('mins') || durationText.contains('min')) {
      int indexOfMins = durationText.indexOf('min');
      String value = durationText.substring(0, indexOfMins).trim();
      totalDuration += int.parse(value) * 60 ;
    }
    return Duration(seconds: totalDuration);
  }

  Future<bool> isPlaceOnRoute(PlacesAutoCompleteResult place,
      LatLng latLngPlace, LatLng depart, LatLng arrive) async {
    // Get the route polyline between the two points
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyC9sGlH43GL0Jer73n9ETKsxNpZqvrWn-k",
        PointLatLng(depart.latitude, depart.longitude),
        PointLatLng(arrive.latitude, arrive.longitude));
    // Convert the polyline points to LatLng coordinates
    List<LatLng> polylineCoordinates = [];
    for (var element in result.points) {
      polylineCoordinates.add(LatLng(element.latitude, element.longitude));
    }
    // Check if the place is within a certain distance of any point on the polyline
    for (var coordinate in polylineCoordinates) {
      double distance = await Geolocator.distanceBetween(
        latLngPlace.latitude,
        latLngPlace.longitude,
        coordinate.latitude,
        coordinate.longitude,
      );
      if (distance <= 2000) {
        // adjust the distance threshold as needed
        return true;
      }
    }
    return false;
  }

  /// -------------------------------------------------------------------------------------------------

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
    _trajet = _baseDeDonnee.creerTrajetVide();
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
      appBar: AppBar(
        title: const Text(
          'Où allez-vous ?',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Card(
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              const Icon(Icons.gps_fixed),
                              Container(
                                height: size.height * 0.05,
                                width: 1,
                                color: Colors.grey,
                              ),
                              const Icon(
                                Icons.location_on,
                              ),
                            ],
                          ), //icons
                          Form(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  Container(
                                    width: size.width * 0.7,
                                    // height: size.height * 0.05,
                                    child: TextFormField(
                                      style: const TextStyle(
                                          fontFamily: 'Poppins', fontSize: 14),
                                      controller: _departController,
                                      onChanged: (value) {
                                        setState(() {
                                          showSuggestion = true;
                                          querry = value;
                                          caseSelected = Selected.depart;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
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
                                  Container(
                                    width: size.width * 0.7,
                                    // height: size.height * 0.05,
                                    child: TextFormField(
                                      keyboardType: TextInputType.streetAddress,
                                      style: const TextStyle(
                                          fontSize: 14, fontFamily: 'Poppins'),
                                      controller: _arriveController,
                                      onChanged: (value) {
                                        setState(() {
                                          showSuggestion = true;
                                          querry = value;
                                          caseSelected = Selected.arrivee;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                        ),
                                        fillColor: Colors.white,
                                        filled: true,
                                        hintText: 'Arrivée',
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ]),
                    SizedBox(height: size.height * 0.01),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          screenWidth * 0.07, 0, screenWidth * 0.075, 0),
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
                                contentPadding: EdgeInsets.only(
                                    top: screenHeight * 0.00001,
                                    left: screenWidth * 0.04),
                                hintText: _selectedDate == null
                                    ? 'choisir la date de départ'
                                    : '${_selectedDate!.toString().split(" ")[0]}',
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
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
                                contentPadding: EdgeInsets.only(
                                    top: screenHeight * 0.0001,
                                    left: screenWidth * 0.04),
                                hintText: _selectedTime == null
                                    ? 'choisir le temps de départ'
                                    : '${_selectedTime!.format(context)}',
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                  ],
                ),
              ),
            ),
            Column(children: [
              Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Card(
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      child: ListTile(
                        onTap: () {
                          setState(() async {
                            if ((_departController.text.isEmpty) ||
                                (_departController.text.isNotEmpty &&
                                    _arriveController.text.isNotEmpty)) {
                              latLngD = await Navigator.push(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return const MapPage();
                                },
                              ));
                              placeD = await getPlaceFromLatLng(
                                  latLngD.latitude, latLngD.longitude);
                              _departController.text = placeD.description!;
                            } else {
                              latLngA = await Navigator.push(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return const MapPage();
                                },
                              ));
                              placeA = await getPlaceFromLatLng(
                                  latLngA.latitude, latLngA.longitude);
                              _arriveController.text = placeA.description!;
                            }
                          });
                        },
                        leading: const Icon(
                          Icons.location_on,
                          color: Colors.black,
                        ),
                        title: Text(
                          'choisir sur la map',
                          style: TextStyle(
                              fontSize: size.width * 0.04,
                              fontFamily: 'Poppins'),
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 0.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      child: ListTile(
                        onTap: () async {
                          setState(() {
                            _isLoadingC = true ;
                          });
                          Position currentPosition =
                              await Geolocator.getCurrentPosition();
                          latLngD = LatLng(currentPosition.latitude,
                              currentPosition.longitude);
                          placeD = await getPlaceFromLatLng(
                              latLngD.latitude, latLngD.longitude);
                          setState(() {
                            depart = placeD.description;
                            _departController.value = TextEditingValue(
                              text: depart!,
                            );
                            _isLoadingC = false ;
                          });
                        },
                        leading: const Icon(
                          Icons.gps_fixed,
                          color: Colors.black,
                        ),
                        title: Text(
                          'Utiliser ma position',
                          style: TextStyle(
                              fontSize: size.width * 0.04,
                              fontFamily: 'Poppins'),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              Visibility(
                visible: _isLoadingC,
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    Text('Veuillez patienter un instant...'),
                  ],
                ),
              ),
              Visibility(
                visible: (_arriveController.text.isEmpty) &&
                    (_departController.text.isEmpty),
                replacement: FutureBuilder(
                    future: getPredictions(querry),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
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
                                onTap: () async{
                                    showSuggestion = false;
                                    switch (caseSelected) {
                                      case Selected.depart:
                                        departData = data;
                                        idD = departData!.placeId;
                                        descriptionD = departData!.description;
                                        mainTextD = departData!.mainText;
                                        secondaryTextD =
                                            departData!.secondaryText;
                                        placeD = PlacesAutoCompleteResult(
                                            placeId: idD,
                                            description: descriptionD,
                                            mainText: mainTextD,
                                            secondaryText: secondaryTextD);
                                        latLngD = await getPlaceLatLng(idD!);
                                        depart = prediction;
                                        setState(() {
                                          _departController.value =
                                              TextEditingValue(
                                            text: depart!,
                                            selection: TextSelection.fromPosition(
                                              TextPosition(
                                                  offset: depart!.length),
                                            ),
                                          );
                                        });
                                        break;
                                      case Selected.arrivee:
                                        ArriveData = data;
                                        idA = ArriveData!.placeId;
                                        descriptionA = ArriveData!.description;
                                        mainTextA = ArriveData!.mainText;
                                        secondaryTextA =
                                            ArriveData!.secondaryText;
                                        placeA = PlacesAutoCompleteResult(
                                            placeId: idA,
                                            description: descriptionA,
                                            mainText: mainTextA,
                                            secondaryText: secondaryTextA);
                                        latLngA = await getPlaceLatLng(idA!);
                                        arrive = prediction;
                                        setState(() {
                                          _arriveController.value =
                                              TextEditingValue(
                                            text: arrive!,
                                            selection: TextSelection.fromPosition(
                                              TextPosition(
                                                  offset: arrive!.length),
                                            ),
                                          );
                                        });
                                        break;
                                      default:
                                    }
                                },
                                title: Text(prediction),
                              );
                            },
                          );
                        } else {
                          return Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'Pas de résultat, tapez clairment votre place',
                                style: TextStyle(fontFamily: 'poppins'),
                              ),
                            ),
                          ));
                        }
                      } else {
                        return const Text(
                          "Recherche...",
                          style: TextStyle(fontFamily: 'Poppins'),
                        );
                      }
                    }),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                ),
              ),
            ]),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: size.width * 0.51,
          height: size.height * 0.048,
          child: ElevatedButton(
            onPressed: () async {
              DateTime dateDebut = DateTime(
                  monDateEtTime.year,
                  monDateEtTime.month,
                  monDateEtTime.day,
                  monDateEtTime2.hour,
                  monDateEtTime2.minute);
              if (
                  dateDebut.isBefore(DateTime.now()) ||
                  placeD.placeId == null ||
                  placeA.placeId! == null ||
                  placeD.placeId!.isEmpty ||
                  placeA.placeId!.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 3),
                    content: AwesomeSnackbarContent(
                      title: 'Attention!',
                      message:
                          'Vous devez remplir tout les informations et entrer des informations correctes',
                      contentType: ContentType.warning,
                      inMaterialBanner: true,
                    ),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                );
              } else {
                /// si tout les informations sont valide
                setState(() {
                  isLoading = true;
                });
                DateTime dt = DateTime.now();
                dt = await calculateArrivalTime(dateDebut,latLngD.latitude,latLngD.longitude,latLngA.latitude,latLngA.longitude);
                 dt.add(Duration(minutes: 5));
                _trajet.tempsDePause = dt ;
                _trajet.dateDepart = dateDebut;
                _trajet.lieuDepart = placeD;
                _trajet.lieuArrivee = placeA;
                _trajet.latLngDepart = latLngD;
                _trajet.latLngArrivee = latLngA;
                _trajet.villeDepart = placeD.description!;
                _trajet.villeArrivee = placeA.description!;
                setState(() {
                  isLoading = false;
                });
                if (statut == false) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => options(_trajet)));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AjouterVillesIntermedieres(_trajet)));
                }
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
            ),
            child: isLoading
                ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                : const Text(
                    'Valider',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Poppins'),
                  ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
