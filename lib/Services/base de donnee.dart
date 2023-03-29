import 'package:appcouvoiturage/AppClasses/Vehicule.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show CollectionReference, FirebaseFirestore;
import '../AppClasses/Evaluation.dart';
import '../AppClasses/Trajet.dart';
import '../AppClasses/Utilisateur.dart';
class BaseDeDonnee{
  final CollectionReference utilisateurCollection = FirebaseFirestore.instance.collection('Utilisateur');
  final CollectionReference nombreUsers = FirebaseFirestore.instance.collection('NombreUtilisateurs');
  final CollectionReference mesTrajets = FirebaseFirestore.instance.collection('MesTrajets');
  
  Future<void> creerUtilisateur(Utilisateur utilisateur) async {
    await utilisateurCollection.doc(utilisateur.identifiant.toString()).set({
      'nom': utilisateur.nom,
      'prenom': utilisateur.prenom,
      'email': utilisateur.email,
      'motDePasse': utilisateur.motDePasse,
      'numeroTelephone': utilisateur.numeroTelephone,
      'evaluation': {
        'feedback': utilisateur.evaluation.feedback,
        'etoiles': utilisateur.evaluation.etoiles,
        'nbSignalement': utilisateur.evaluation.nbSignalement,
      },
      'vehicule': {
        'marque': utilisateur.vehicule.marque,
        'typevehicule': utilisateur.vehicule.typevehicule,
        'matricule': utilisateur.vehicule.matricule,
        'modele': utilisateur.vehicule.modele,
        'policeAssurance': utilisateur.vehicule.policeAssurance,
        'nbPlaces': utilisateur.vehicule.nbPlaces,
      },
      'statut': utilisateur.statut,
      'trajets': utilisateur.trajets.map((trajet) => {
        'horaire': trajet.horaire,
        'tempsDePause': trajet.tempsDePause,
        'lieuDepart': trajet.lieuDepart,
        'lieuArrivee': trajet.lieuArrivee,
        'coutTrajet': trajet.coutTrajet,
        'villeDepart': trajet.villeDepart,
        'villeArrivee': trajet.villeArrivee,
        'villeIntermediaires': trajet.villeIntermediaires,
        'plusInformations': {
          'fumeur': trajet.plusInformations.fumeur,
          'bagage': trajet.plusInformations.bagage,
          'animaux': trajet.plusInformations.animaux,
          'nbPlaces': trajet.plusInformations.nbPlaces,
        },
        'trajetEstValide': trajet.trajetEstValide,
      }).toList(),
    });
  } // Fin creerUtilisateur
  Future<void> ajouterHistorique(Utilisateur utilisateur , Trajet trajet) async {
    utilisateur.ajouterHistorique(trajet);
    await utilisateurCollection.doc(utilisateur.identifiant.toString()).set({
      'trajets': utilisateur.trajets.map((trajet) => {
        'horaire': trajet.horaire,
        'tempsDePause': trajet.tempsDePause,
        'lieuDepart': trajet.lieuDepart,
        'lieuArrivee': trajet.lieuArrivee,
        'coutTrajet': trajet.coutTrajet,
        'villeDepart': trajet.villeDepart,
        'villeArrivee': trajet.villeArrivee,
        'villeIntermediaires': trajet.villeIntermediaires,
        'plusInformations': {
          'fumeur': trajet.plusInformations.fumeur,
          'bagage': trajet.plusInformations.bagage,
          'animaux': trajet.plusInformations.animaux,
          'nbPlaces': trajet.plusInformations.nbPlaces,
        },
        'trajetEstValide': trajet.trajetEstValide,
      }).toList(),
    });
  } // Fin creerUtilisateur
  Future<void> ajouterVehicule(Utilisateur utilisateur , Vehicule vehicule) async {
    utilisateur.vehicule = vehicule;
    await utilisateurCollection.doc(utilisateur.identifiant.toString()).set({
      'vehicule': {
        'marque': utilisateur.vehicule.marque,
        'typevehicule': utilisateur.vehicule.typevehicule,
        'matricule': utilisateur.vehicule.matricule,
        'modele': utilisateur.vehicule.modele,
        'policeAssurance': utilisateur.vehicule.policeAssurance,
        'nbPlaces': utilisateur.vehicule.nbPlaces,
      },
    });
  } // Fin ajouterVehicule
  Future<void> ajouterEvaluation(Utilisateur utilisateur ,Evaluation evaluation) async {
    utilisateur.evaluation = evaluation ;
    await utilisateurCollection.doc(utilisateur.identifiant.toString()).set({
      'evaluation': {
        'feedback': utilisateur.evaluation.feedback,
        'etoiles': utilisateur.evaluation.etoiles,
        'nbSignalement': utilisateur.evaluation.nbSignalement,
      },
    });
  } // Fin ajouterEvaluation
  Future<void> modifierStatut(Utilisateur utilisateur ,bool statut) async {
    utilisateur.statut = statut ;
    await utilisateurCollection.doc(utilisateur.identifiant.toString()).set({
      'statut': utilisateur.statut,
    });
  } // Fin modifierStatut
  Future<void> modifierNom(Utilisateur utilisateur ,String nom) async {
    utilisateur.nom = nom ;
    await utilisateurCollection.doc(utilisateur.identifiant.toString()).set({
      'nom': utilisateur.nom,
    });
  } // Fin modifierNom
  Future<void> modifierPrenom(Utilisateur utilisateur ,String prenom) async {
    utilisateur.prenom = prenom ;
    await utilisateurCollection.doc(utilisateur.identifiant.toString()).set({
      'prenom': utilisateur.prenom,
    });

  } // Fin modifierPrenom
  Future<void> modifierMotDePasse(Utilisateur utilisateur ,String motDePasse) async {
    utilisateur.motDePasse = motDePasse ;
    await utilisateurCollection.doc(utilisateur.identifiant.toString()).set({
      'motDePasse': utilisateur.motDePasse,
    });
  } // Fin modifierMotDePasse
  Future<void> incrementerNbUsers() async{
    await nombreUsers.doc('NombreUtilisateurs').set({
      'NombreUtilisateurs': (nombreUsers.doc('NombreUtilisateurs').get()),
    });
  }
}
      // possible de faire une seul fonction qui modifier a la fois tout les donnee du profile
      // est ce que on sauvegarde toujours les reservations, si oui alors on fait un champ dans
      // user "TrajetsReserve" et si non on doit aussi la faire pour les stocker temporairement
      // use sharedPreferences to save the id of uder loged in or how to do it ?