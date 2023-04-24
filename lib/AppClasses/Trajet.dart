//import 'package:geoflutterfire/geoflutterfire.dart';
import 'PlusInformations.dart';
class Trajet {
  String dateDepart;
  String heureDepart;
  String tempsDePause;
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
      this.dateDepart,
      this.heureDepart,
      this.tempsDePause,
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

  Map<String, dynamic> toMap() {
    return {
      'dateDepart' : dateDepart,
      'heureDepart': heureDepart,
      'tempsDePause': tempsDePause,
      'coutTrajet': coutTrajet,
      'villeDepart': villeDepart,
      'villeArrivee': villeArrivee,
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
    };
  }
}