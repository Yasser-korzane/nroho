import 'package:appcouvoiturage/AppClasses/Trajet.dart';
import 'package:appcouvoiturage/AppClasses/Utilisateur.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:appcouvoiturage/pages/HistoriqueLancer.dart';
import 'package:appcouvoiturage/pages/HistoriqueReserver.dart';

class Historique extends StatelessWidget {
  Utilisateur _utilisateur;
  Historique(this._utilisateur);
  @override
  Widget build(BuildContext context) {
    List<Trajet> listTrajetReserve = [];
    List<Trajet> listTrajetLance = [];
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    for (Trajet trajet in _utilisateur.Historique){
      if (trajet.idConductuer == uid) listTrajetLance.add(trajet);
      else listTrajetReserve.add(trajet);
    }
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.black)),
          title: Text('Historique',
              style: TextStyle(fontFamily: 'Poppins')),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          bottom: TabBar(
            labelStyle: TextStyle(fontFamily: 'Poppins'),
            indicatorColor: Colors.blue,
            labelColor: Colors.blue.shade700,
            unselectedLabelColor: Colors.blueGrey[900],
            tabs: [
              Tab(text: 'Trajet lancé',),
              Tab(text: 'Trajet reservé'),
            ],
          ),
        ),
        body:TabBarView(
          children: [
            cardLancerListH(listTrajetLance),
            cardReserverListH(listTrajetReserve),
          ],
        ),
      ),
    );
  }
}
