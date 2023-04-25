import 'package:appcouvoiturage/AppClasses/Evaluation.dart';
import 'package:appcouvoiturage/AppClasses/Trajet.dart';
import 'package:appcouvoiturage/AppClasses/Utilisateur.dart';
import 'package:appcouvoiturage/AppClasses/Vehicule.dart';
import 'package:appcouvoiturage/Services/base%20de%20donnee.dart';
import 'package:appcouvoiturage/pages/choisirchauffeur.dart';
import 'package:appcouvoiturage/widgets/selectabletext.dart';
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
  late ConducteurTrajet c ;
  late List<ConducteurTrajet> monListe = [] ;
  List<String> nbPlaces = ['1','2','3','4'];
  String ?selectedNb = '1';
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery
        .of(context)
        .size;
    // to get acces to variable do : widget.variable
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final Size size = MediaQuery.of(context).size;
    BaseDeDonnee baseDeDonnee = BaseDeDonnee();
    Utilisateur utilisateur = BaseDeDonnee().creerUtilisateurVide();
    utilisateur.nom = "Grine";
    utilisateur.prenom = "Mohammed";
    utilisateur.email = "lm_grine@esi.dz";
    utilisateur.numeroTelephone = "0776418929";
    PlusInformations plusInformations = PlusInformations(false, false, false, 1);
    Trajet trajetLance = BaseDeDonnee().creerTrajetVide();
    print('monListe.length = ${monListe.length}');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
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
              SelectableTextWidget(text: 'Acceptez-vous un conducteur qui fume ?'),
              SizedBox(height: screenHeight * 0.03),
              SelectableTextWidget(text: 'Avez vous un bagage volumineux ?'),
              SizedBox(height: screenHeight * 0.03),
              SelectableTextWidget(text: 'Avez vous  des animaux ?'),
              SizedBox(height : screenHeight * 0.03),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                    //margin: EdgeInsets.fromLTRB(screenHeight * 0.01, 0, screenHeight * 0.01, 0),
                    //child: CustomDropdown(options: [1, 2, 3, 4])),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(

                      enabledBorder: OutlineInputBorder(
                        //borderSide: BorderSide(color: Colors.black),
                      )
                    ),
                    value: selectedNb,
                    items: nbPlaces
                        .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(item,style: TextStyle(fontFamily: 'Poppins'),),))
                        .toList(),
                    onChanged: (item) {
                      setState(() => selectedNb = item);
                      plusInformations.nbPlaces = int.parse(item!);
                    }
                  ),
                  ),
              ),
              SizedBox(height: 10.0),
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
                    trajetLance.avis = value ;
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
              //monListe = await baseDeDonnee.chercherConductuersPossibles('', widget.trajetReserve);
              c = ConducteurTrajet(utilisateur, trajetLance);
              monListe.add(c);
              print('nbPlaces = ${plusInformations.nbPlaces}');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DriverListPage(monListe)));
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
