import 'package:appcouvoiturage/pages/home.dart';
import 'package:appcouvoiturage/pages/options.dart';
import 'package:appcouvoiturage/pages/optionsconducteur.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Trajet extends StatefulWidget {
  const Trajet({super.key});

  @override
  State<Trajet> createState() => _TrajetState();
}

class _TrajetState extends State<Trajet> {
  String querry = "";
  int selected = home().get();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:   InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => home(),));
            },
            child: Icon(
          Icons.arrow_circle_left_outlined,
          color: Colors.black,
          size: 35,
        )),
        centerTitle: true,
        title: const Text(
          "Ou allez-vous ?",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Column(
        children: [
          departDestination(),
          autoComplete(),
          RechercheRecente(),
          validerButton(),
        ],
      ),
    );
  }

  Widget departDestination() {
    return Row(
      children: [
        const Icon(Icons.location_on),
        Column(
          children: [
            TextFormField(
              onChanged: (value) {
                setState(() {
                  querry = value;
                });
              },
              decoration: InputDecoration(
                  hintText: "Point de Depart",
                  constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width) /
                      1.5),
            ),
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Destination",
                  constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width) /
                      1.5),
            )
          ],
        ),
      ],
    );
  }

  Widget autoComplete() {
    return Expanded(
        child: FutureBuilder(
            future: getPredictions(querry),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: snapshot.data["predictions"].length,
                  itemBuilder: (context, index) {
                    var prediction =
                        snapshot.data["predictions"][index]["description"];
                    return ListTile(
                      title: Text(prediction),
                    );
                  },
                );
              } else {
                return const Text("Waiting");
              }
            }));
  }

  Widget RechercheRecente() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {},
      ),
    );
  }

  Widget validerButton() {
    return ElevatedButton(
      onPressed: ()
      {
        if (selected == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => options()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => optionconduc()),
          );
        }
      },

    child: const Text("Valider"));
  }

  Future<dynamic> getPredictions(String querry) async {
    var response = await Dio().get(
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$querry&key=AIzaSyA7YbcfZHHiA80T-wbB656ql4r6lC3cJRE");
    return response.data;
  }
}

