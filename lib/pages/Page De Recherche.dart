import 'package:appcouvoiturage/AppClasses/Trajet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Services/base de donnee.dart';
import 'choisirchauffeur.dart';

class PageDeRecherche extends StatefulWidget {
  Trajet trajetReserve;

  PageDeRecherche(this.trajetReserve);

  @override
  State<PageDeRecherche> createState() => _PageDeRechercheState();
}

class _PageDeRechercheState extends State<PageDeRecherche> {
  BaseDeDonnee _baseDeDonnee = BaseDeDonnee();
  List<ConducteurTrajet> monListe = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
              child : ElevatedButton(
                  onPressed: () async{
                monListe = await _baseDeDonnee.chercherConductuersPossibles(FirebaseAuth.instance.currentUser!.uid, widget.trajetReserve);
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => DriverListPage(monListe)));

              },
                  child: Text('Commencer la recherche')
              )
      ),
    );
  }
}
