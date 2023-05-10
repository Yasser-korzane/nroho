import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places_service/places_service.dart';
import 'PlusInformations.dart';
class Trajet {
  String id ;
  DateTime dateDepart ;
  DateTime tempsDePause;
  double coutTrajet;
  String villeDepart;
  String villeArrivee;
  PlacesAutoCompleteResult? lieuDepart;
  PlacesAutoCompleteResult? lieuArrivee;
  List<String> villeIntermediaires;
  PlusInformations plusInformations;
  bool trajetEstValide;
  String confort ;
  String avis;
  bool probleme; // si false alors il n'as pas de probleme, si true alors il ya un probleme
  LatLng latLngDepart ;
  LatLng latLngArrivee ;
  String idConductuer ;
  List<String> idPassagers ;
  Trajet(
      this.id,
      this.dateDepart,
      this.tempsDePause,
      this.coutTrajet,
      this.villeDepart,
      this.villeArrivee,
      this.lieuDepart,
      this.lieuArrivee,
      this.villeIntermediaires,
      this.plusInformations,
      this.trajetEstValide,
      this.confort,
      this.avis,
      this.probleme,
      this.latLngDepart,
      this.latLngArrivee,
      this.idConductuer,
      this.idPassagers);
  void afficher() {
    print('id : $id');
    print('dateDepart: $dateDepart');
    print('tempsDePause: $tempsDePause');
    print('coutTrajet: $coutTrajet');
    print('villeDepart: $villeDepart');
    print('villeArrivee: $villeArrivee');
    print(lieuDepart);
    print(lieuArrivee);
    print('villeIntermediaires: $villeIntermediaires');
    print('plusInformations: fumeur:${plusInformations.fumeur} , bagage:${plusInformations.bagage} , animeaux:${plusInformations.animaux} , nbPlaces:${plusInformations.nbPlaces}');
    print('trajetEstValide: $trajetEstValide');
    print('confort: $confort');
    print('avis: $avis');
    print('probleme: $probleme');
    print('LatLng Depart :  $latLngDepart');
    print('LatLng Arrivee :  $latLngArrivee');
    print('idConducteur : $idConductuer');
    print('idPassagers : $idPassagers');
  }
  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'dateDepart' : dateDepart,
      'tempsDePause': tempsDePause,
      'coutTrajet': coutTrajet,
      'villeDepart': villeDepart,
      'villeArrivee': villeArrivee,
      'lieuDepart': lieuDepart != null ? _convertPlaceResultToMap(lieuDepart!) : null,
      'lieuArrivee': lieuArrivee != null ? _convertPlaceResultToMap(lieuArrivee!) : null,
      'villeIntermediaires': villeIntermediaires,
      'plusInformations': {
        'fumeur': plusInformations.fumeur,
        'bagage': plusInformations.bagage,
        'animaux': plusInformations.animaux,
        'nbPlaces': plusInformations.nbPlaces,
      },
      'trajetEstValide': trajetEstValide,
      'confort': confort,
      'avis': avis,
      'probleme': probleme,
      'latLngDepart': GeoPoint(latLngDepart.latitude, latLngDepart.longitude),
      'latLngArrivee': GeoPoint(latLngArrivee.latitude, latLngArrivee.longitude),
      'idConductuer': idConductuer,
      'idPassagers': idPassagers,
    };
  }
  Map<String, dynamic> _convertPlaceResultToMap(PlacesAutoCompleteResult place) {
    return {
      'placeId': place.placeId,
      'description': place.description,
      'secondaryText': place.secondaryText,
      'mainText': place.mainText,
      // Include other properties as needed
    };
  }
}