import 'package:nroho/AppClasses/Trajet.dart';
import 'package:nroho/pages/rating.dart';
import 'package:nroho/pages/trajetsLances.dart';
import 'package:nroho/pages/trajetsReserves.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places_service/places_service.dart';
import '../AppClasses/PlusInformations.dart';
import '../Services/base de donnee.dart';
class Trajets extends StatefulWidget {
  const Trajets({Key? key}) : super(key: key);
  @override
  State<Trajets> createState() => _TrajetsState();
}

class _TrajetsState extends State<Trajets> {
  List<Trajet> trajetsLances = [];
  List<Trajet> trajetsReserves = [];
  BaseDeDonnee _baseDeDonnee = BaseDeDonnee();
  Future _getTrajetsLances() async {
    QuerySnapshot trajetsSnapshot = await FirebaseFirestore.instance
        .collection('Utilisateur')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('trajetsLances')
        .get();
    if (trajetsSnapshot.docs.isNotEmpty) {
      print("Le trajet Existe");
      for (QueryDocumentSnapshot trajetDoc in trajetsSnapshot.docs) {
        Map<String, dynamic> data = trajetDoc.data() as Map<String, dynamic>;
        Trajet trajetLance = BaseDeDonnee().creerTrajetVide();
        trajetLance.id = data['id'] ;
        trajetLance.dateDepart = data['dateDepart'].toDate();
        trajetLance.tempsDePause = data['tempsDePause'].toDate();//.add(Duration(hours: 1))
        trajetLance.coutTrajet = data['coutTrajet'] as double;
        trajetLance.villeDepart = data['villeDepart'];
        trajetLance.villeArrivee = data['villeArrivee'];
        trajetLance.lieuDepart = PlacesAutoCompleteResult(
          placeId: data['lieuDepart']['placeId'],
          description: data['lieuDepart']['description'],
          secondaryText: data['lieuDepart']['secondaryText'],
          mainText: data['lieuDepart']['mainText'],
        );
        trajetLance.lieuArrivee = PlacesAutoCompleteResult(
          placeId: data['lieuArrivee']['placeId'],
          description: data['lieuArrivee']['description'],
          secondaryText: data['lieuArrivee']['secondaryText'],
          mainText: data['lieuArrivee']['mainText'],
        );
        trajetLance.villeIntermediaires = List<String>.from(data['villeIntermediaires']);
        trajetLance.plusInformations = PlusInformations(
            data['plusInformations']['fumeur'],
            data['plusInformations']['bagage'],
            data['plusInformations']['animaux'],
            data['plusInformations']['nbPlaces']);
        trajetLance.trajetEstValide = data['trajetEstValide'];
        trajetLance.confort = data['confort'];
        trajetLance.avis = data['avis'];
        trajetLance.probleme = data['probleme'];
        /// ---------------------
        GeoPoint geoPointDepart = data['latLngDepart'];
        GeoPoint geoPointArrivee = data['latLngArrivee'];
        LatLng latLngDepart = LatLng(geoPointDepart.latitude, geoPointDepart.longitude);
        LatLng latLngArrivee = LatLng(geoPointArrivee.latitude, geoPointArrivee.longitude);
        trajetLance.latLngDepart = latLngDepart;
        trajetLance.latLngArrivee = latLngArrivee;
        trajetLance.idConductuer = data['idConductuer'];
        trajetLance.idPassagers = List<String>.from(data['idPassagers']);
        if(DateTime.now().isAfter( (trajetLance.tempsDePause).add(Duration(minutes: 50)) )){ // si le trajet est finie
          if(trajetLance.trajetEstValide) showDialog(context: context, builder: (context) => Rating(trajetLance),);
          _baseDeDonnee.annulerTrajetLance(FirebaseAuth.instance.currentUser!.uid, trajetLance.id);
        }else {
          setState(() {
            trajetsLances.add(trajetLance);
          });
        }
      }
    }
  }
  Future _getTrajetsReserves() async {
    QuerySnapshot trajetsSnapshot = await FirebaseFirestore.instance
        .collection('Utilisateur')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('trajetsReserves')
        .get();
    if (trajetsSnapshot.docs.isNotEmpty) {
      print("Le trajet Existe");
      for (QueryDocumentSnapshot trajetDoc in trajetsSnapshot.docs) {
        Map<String, dynamic> data = trajetDoc.data() as Map<String, dynamic>;
        Trajet trajetReserve = BaseDeDonnee().creerTrajetVide();
        trajetReserve.id = data['id'] ;
        trajetReserve.dateDepart = data['dateDepart'].toDate();
        trajetReserve.tempsDePause = data['tempsDePause'].toDate() ;
        trajetReserve.coutTrajet = data['coutTrajet'] as double;
        trajetReserve.villeDepart = data['villeDepart'];
        trajetReserve.villeArrivee = data['villeArrivee'];
        trajetReserve.lieuDepart = PlacesAutoCompleteResult(
          placeId: data['lieuDepart']['placeId'],
          description: data['lieuDepart']['description'],
          secondaryText: data['lieuDepart']['secondaryText'],
          mainText: data['lieuDepart']['mainText'],
        );
        trajetReserve.lieuArrivee = PlacesAutoCompleteResult(
          placeId: data['lieuArrivee']['placeId'],
          description: data['lieuArrivee']['description'],
          secondaryText: data['lieuArrivee']['secondaryText'],
          mainText: data['lieuArrivee']['mainText'],
        );
        trajetReserve.villeIntermediaires = List<String>.from(data['villeIntermediaires']);
        trajetReserve.plusInformations = PlusInformations(
            data['plusInformations']['fumeur'],
            data['plusInformations']['bagage'],
            data['plusInformations']['animaux'],
            data['plusInformations']['nbPlaces']);
        trajetReserve.trajetEstValide = data['trajetEstValide'];
        trajetReserve.confort = data['confort'];
        trajetReserve.avis = data['avis'];
        trajetReserve.probleme = data['probleme'];
        /// ---------------------
        GeoPoint geoPointDepart = data['latLngDepart'];
        GeoPoint geoPointArrivee = data['latLngArrivee'];
        LatLng latLngDepart = LatLng(geoPointDepart.latitude, geoPointDepart.longitude);
        LatLng latLngArrivee = LatLng(geoPointArrivee.latitude, geoPointArrivee.longitude);
        trajetReserve.latLngDepart = latLngDepart;
        trajetReserve.latLngArrivee = latLngArrivee;
        trajetReserve.idConductuer = data['idConductuer'];
        trajetReserve.idPassagers = List<String>.from(data['idPassagers']);
        if(DateTime.now().isAfter(trajetReserve.tempsDePause)){
          if(trajetReserve.trajetEstValide) showDialog(context: context, builder: (context) => Rating(trajetReserve),);
          _baseDeDonnee.annulerTrajetReserve(FirebaseAuth.instance.currentUser!.uid, trajetReserve.id);
        }else {
          setState(() {
            trajetsReserves.add(trajetReserve);
          });
        }
      }
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTrajetsLances();
    _getTrajetsReserves();
  }
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Mes Trajets',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontFamily: 'Poppins',
              ),),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          bottom: TabBar(
            labelStyle: TextStyle(fontFamily: 'Poppins'),
            indicatorColor: Colors.blue,
            labelColor: Colors.blue.shade700,
            unselectedLabelColor: Colors.blueGrey[900],
              tabs: [
                Tab(text: 'Trajet lancer',
                ),
                Tab(text: 'Trajet reserver'),
              ],
          ),
        ),
        body: TabBarView(
          children: [
            cardLancerList(trajetsLances),
            cardReserverList(trajetsReserves),
          ],
        ),
      ),
    );
  }
}
