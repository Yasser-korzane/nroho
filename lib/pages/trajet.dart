import 'package:appcouvoiturage/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:appcouvoiturage/widgets/date_time.dart';
import 'package:location/location.dart';
import 'package:places_service/places_service.dart';

enum Selected { depart, arrivee, none }

class OuAllezVous extends StatefulWidget {
  const OuAllezVous({super.key});

  @override
  State<OuAllezVous> createState() => _OuAllezVousState();
}

class _OuAllezVousState extends State<OuAllezVous> {
  String querry = "";
  String? arrive, depart;
  Selected caseSelected = Selected.none;
  LocationData? current_location;
  final _placesService = PlacesService();

  void getLocation() {
    Location location = Location();
    location.getLocation().then((value) => current_location = value);
  }

  Future<dynamic> getPredictions(String querry) async {
    List<PlacesAutoCompleteResult>? response;
    if (querry != "") {
      response = await _placesService.getAutoComplete(querry);
    }
    return response;
  }

  @override
  void initState() {
    super.initState();
    _placesService.initialize(
        apiKey: "AIzaSyC9sGlH43GL0Jer73n9ETKsxNpZqvrWn-k");
    //getLocation();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xff344D59),
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const home();
              },
            ));
          },
        ),
        title: const Text(
          'Où allez-vous ?',
          style: TextStyle(color: Color(0xff344D59), fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              // Zone de recherche pour le départ
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
                ),
                Column(children: [
                  SizedBox(
                    width: 285,
                    height: 42,
                    child: TextFormField(
                      controller: TextEditingController(text: depart),
                      onChanged: (value) {
                        querry = value;
                        caseSelected = Selected.depart;
                      },
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0x000000ff)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        fillColor: Colors.grey,
                        filled: true,
                        hintText: 'Départ',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 285,
                    height: 42,
                    child: TextField(
                      controller: TextEditingController(text: arrive),
                      onChanged: (value) {
                        querry = value;
                        caseSelected = Selected.arrivee;
                      },
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0x000000ff)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        fillColor: Colors.grey,
                        filled: true,
                        hintText: 'Arrivée',
                      ),
                    ),
                  ),
                ]),
              ]),

              const SizedBox(height: 10),
              const DateTimePickerRow(),
              const SizedBox(height: 10),
              const Divider(
                color: Colors.blueGrey,
                thickness: 2,
              ),
              ListTile(
                onTap: () {
                  setState(() {});
                },
                leading: const Icon(
                  Icons.location_on,
                  color: Colors.black,
                ),
                title: const Text(
                  'choisir sur la map',
                  style: TextStyle(color: Color(0xff344D59), fontSize: 20),
                ),
              ),
              const Divider(
                color: Colors.blueGrey,
                thickness: 1,
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(
                  Icons.gps_fixed,
                  color: Colors.black,
                ),
                title: const Text(
                  'Utiliser ma position',
                  style: TextStyle(color: Color(0xff344D59), fontSize: 20),
                ),
              ),
              const Divider(
                color: Colors.blueGrey,
                thickness: 1,
              ),
              FutureBuilder(
                  future: getPredictions(querry),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                          separatorBuilder: (context, index) {
                            return const Divider(
                              color: Colors.blueGrey,
                              thickness: 1,
                            );
                          },
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            var prediction = snapshot.data[index].description;
                            return ListTile(
                              onTap: () {
                                setState(() {
                                  switch (caseSelected) {
                                    case Selected.depart:
                                      depart = prediction;
                                      break;
                                    case Selected.arrivee:
                                      arrive = prediction;
                                      break;
                                    default:
                                  }
                                });
                              },
                              title: Text('$index : $prediction'),
                            );
                          },
                        );
                      } else {
                        return const Center();
                      }
                    } else {
                      return const Text("searching...");
                    }
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Container(
                  color: Colors.grey,
                  child: const Text(
                    'Historique des recherches                                    ',
                    style: TextStyle(
                        color: Color(0xff344D59),
                        fontSize: 23,
                        backgroundColor: Colors.grey),
                  ),
                ),
              ),

              const Divider(
                color: Colors.blueGrey,
                thickness: 1,
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.location_on,
                    ),
                    onPressed: () {},
                  ),
                  const Text(
                    'Maoklane - Setif',
                    style: TextStyle(color: Color(0xff344D59), fontSize: 20),
                  ),
                ],
              ),
              const Divider(
                color: Colors.blueGrey,
                thickness: 1,
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.location_on,
                    ),
                    onPressed: () {},
                  ),
                  const Text(
                    'Oued Smar - Alger',
                    style: TextStyle(color: Color(0xff344D59), fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(
                height: 150,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: 210,
                    height: 43,
                    child: ElevatedButton(
                      onPressed: () {
                        if (depart != null && arrive != null) {
                          Navigator.pushNamed(context, "home",
                              arguments: [depart, arrive]);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Please fill all the information")));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        'Valider',
                        style: TextStyle(fontSize: 20),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// Ajout SingleChildScrollView