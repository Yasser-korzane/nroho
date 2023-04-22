//import 'package:geoflutterfire/geoflutterfire.dart';
import 'PlusInformations.dart';
class Trajet {
  String horaire;
  String tempsDePause;
  String lieuDepart;
  String lieuArrivee;
  double coutTrajet;
  String villeDepart;
  String villeArrivee;
  List<String> villeIntermediaires;
  /*GeoFirePoint cordonneesDepart;
  GeoFirePoint cordonneesArrivee;
  List<GeoPoint> chemin;*/
  PlusInformations plusInformations;
  bool trajetEstValide;
  String confort ;
  String avis;
  bool probleme; // si false alors il n'as pas de probleme, si true alors il ya un probleme

  Trajet(
      this.horaire,
      this.tempsDePause,
      this.lieuDepart,
      this.lieuArrivee,
      this.coutTrajet,
      this.villeDepart,
      this.villeArrivee,
      this.villeIntermediaires,
      /*this.cordonneesDepart,
      this.cordonneesArrivee,
      this.chemin,*/
      this.plusInformations,
      this.trajetEstValide,
      this.confort,
      this.avis,
      this.probleme);
}