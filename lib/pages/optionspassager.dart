import 'package:appcouvoiturage/AppClasses/Evaluation.dart';
import 'package:appcouvoiturage/AppClasses/Trajet.dart';
import 'package:appcouvoiturage/AppClasses/Utilisateur.dart';
import 'package:appcouvoiturage/AppClasses/Vehicule.dart';
import 'package:appcouvoiturage/Services/base%20de%20donnee.dart';
import 'package:appcouvoiturage/pages/Page%20De%20Recherche.dart';
import 'package:appcouvoiturage/pages/choisirchauffeur.dart';
import 'package:appcouvoiturage/widgets/selectabletext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:places_service/places_service.dart';

import '../AppClasses/PlusInformations.dart';

class options extends StatefulWidget {
  Trajet trajetReserve ;
  options(this.trajetReserve);

  @override
  State<options> createState() => _optionsState();
}

class _optionsState extends State<options> {

  List<String> nbPlaces = ['1','2','3','4'];
  String ?selectedNb = '1';
  BaseDeDonnee _baseDeDonnee = BaseDeDonnee();
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery
        .of(context)
        .size;
    // to get acces to trajetReserve do : widget.trajetReserve
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final Size size = MediaQuery.of(context).size;
    Utilisateur utilisateur = BaseDeDonnee().creerUtilisateurVide();
    utilisateur.nom = "Grine";
    utilisateur.prenom = "Mohammed";
    utilisateur.email = "lm_grine@esi.dz";
    utilisateur.numeroTelephone = "0776418929";
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: Color(0xff344D59))
        ),
        title: Text('Plus d’informations',
            style: TextStyle(color: Color(0xff344D59),fontFamily: 'Poppins')),        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(screenWidth*0.03, 0, 10, screenWidth*0.03),
        child: ListView(
          children:[ Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.1),
              //SelectableTextWidget(text: 'Etes-vous fumeur ?'),
              Card(color: Colors.white60,margin: EdgeInsets.all(16),
                shape:   RoundedRectangleBorder(
                  side:  BorderSide(color: Colors.grey,width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(15)
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Acceptez-vous un conducteur qui fume ?',
                        style: TextStyle(
                          fontSize: screenHeight*0.0158,
                          fontFamily: 'Poppins',
                        ),),
                      //SizedBox(width: screenWidth*0.35,),
                      Checkbox(
                        value: widget.trajetReserve.plusInformations.fumeur,
                        onChanged: (value) {
                          setState(() {
                            widget.trajetReserve.plusInformations.fumeur = value ?? false; // Update 'yes' with the selected value or false if value is null
                          });
                        },
                        activeColor: Colors.blue, // Optional: change the color of the checkbox when selected
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.002),
              Card(color: Colors.white60,margin: EdgeInsets.all(16),
                shape:   RoundedRectangleBorder(
                  side:  BorderSide(color: Colors.grey,width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(15)
                  ),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Avez vous un bagage volumineux ?',
                        style: TextStyle(
                          fontSize: screenHeight*0.016,
                          fontFamily: 'Poppins',
                        ),),
                      Checkbox(
                        value: widget.trajetReserve.plusInformations.bagage,
                        onChanged: (value) {
                          setState(() {
                            widget.trajetReserve.plusInformations.bagage = value ?? false; // Update 'yes' with the selected value or false if value is null
                          });
                        },
                        activeColor: Colors.blue, // Optional: change the color of the checkbox when selected
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.002),
              Card(color: Colors.white60,margin: EdgeInsets.all(16),
                shape:   RoundedRectangleBorder(
                  side:  BorderSide(color: Colors.grey,width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(15)
                  ),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Avez vous  des animaux ?',
                        style: TextStyle(
                          fontSize: screenHeight*0.017,
                          fontFamily: 'Poppins',
                        ),),
                      Checkbox(
                        value: widget.trajetReserve.plusInformations.animaux,
                        onChanged: (value) {
                          setState(() {
                            widget.trajetReserve.plusInformations.animaux = value ?? false; // Update 'yes' with the selected value or false if value is null
                          });
                        },
                        activeColor: Colors.blue, // Optional: change the color of the checkbox when selected
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.002),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  //margin: EdgeInsets.fromLTRB(screenHeight * 0.01, 0, screenHeight * 0.01, 0),
                  //child: CustomDropdown(options: [1, 2, 3, 4])),
                  child:
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                    ),
                    value: selectedNb,
                    items: nbPlaces
                        .map(
                          (item) => DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                      ),
                    )
                        .toList(),
                    onChanged: (item) {
                      setState(() {
                        selectedNb = item;
                        widget.trajetReserve.plusInformations.nbPlaces = int.parse(item!);
                      });
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(screenHeight * 0.01, 0, screenHeight * 0.01, 0),
                padding: EdgeInsets.fromLTRB(screenHeight * 0.015, 0, screenHeight * 0.01, 0),
                child: TextField(
                     style: TextStyle(
                       fontWeight: FontWeight.normal,
                       fontSize: screenHeight*0.02,
                       fontFamily: 'Poppins',
                     ),
                      decoration: InputDecoration(
                      fillColor: Colors.grey.shade300,
                      labelText: 'Laisser un commentaire',
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      // i can you only a icon (not prefixeIcon) to show the icons out of the Textfield
                      suffixIcon: Icon(Icons.insert_comment_rounded,
                          color: Colors.black)
                      ),
                  onChanged: (value) {
                    widget.trajetReserve.avis = value ;
                  },
                ),
              ),
              SizedBox(height: screenHeight * 0.094),

            ],
          ),
      ]
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: size.width * 0.51,
          height: size.height * 0.048,
          child: ElevatedButton(
            onPressed: () async{
              //widget.trajetReserve.afficher();
              //await _baseDeDonnee.saveTrajetReserveAsSubcollection(FirebaseAuth.instance.currentUser!.uid, widget.trajetReserve);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PageDeRecherche(widget.trajetReserve)));
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
