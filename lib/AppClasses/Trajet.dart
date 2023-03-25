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
      this.trajetEstValide);
}