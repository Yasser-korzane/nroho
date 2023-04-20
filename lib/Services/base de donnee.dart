import 'package:appcouvoiturage/AppClasses/Vehicule.dart';
import 'package:cloud_firestore/cloud_firestore.dart' ;
import '../AppClasses/Evaluation.dart';
import '../AppClasses/PlusInformations.dart';
import '../AppClasses/Trajet.dart';
import '../AppClasses/Utilisateur.dart';

class BaseDeDonnee{
  final CollectionReference utilisateurCollection = FirebaseFirestore.instance.collection('Utilisateur');
  final CollectionReference nombreUsers = FirebaseFirestore.instance.collection('NombreUtilisateurs');

  /** *********************************** Seters (ajout et modifications) *********************************** **////
  Future<void> creerUtilisateur(Utilisateur utilisateur) async {
    await utilisateurCollection.doc(utilisateur.identifiant).set({
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
      'trajetsLances': utilisateur.trajetsLances.map((trajet) => {
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
      'trajetsReserves': utilisateur.trajetsReserves.map((trajet) => {
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
      'Historique': utilisateur.Historique.map((trajet) => {
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
    incrementerUtilisateurs();
  } // Fin creerUtilisateur
  //------------------------------------------------------------------------------------------
  Future<void> ajouterHistorique(Utilisateur utilisateur , Trajet trajet) async {
    utilisateur.ajouterHistorique(trajet);
    await utilisateurCollection.doc(utilisateur.identifiant).set({
      'Historique': utilisateur.Historique.map((trajet) => {
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
  } // Fin ajouterHistorique
  //------------------------------------------------------------------------------------------
  Future<void> ajouterTrajetLance(Utilisateur utilisateur , Trajet trajet) async {
    utilisateur.ajouterTrajetLance(trajet);
    await utilisateurCollection.doc(utilisateur.identifiant).set({
      'Historique': utilisateur.Historique.map((trajet) => {
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
  } // Fin ajouterTrajetLance
  //------------------------------------------------------------------------------------------
  Future<void> ajouterTrajetReserve(Utilisateur utilisateur , Trajet trajet) async {
    utilisateur.ajouterTrajetReserve(trajet);
    await utilisateurCollection.doc(utilisateur.identifiant).set({
      'Historique': utilisateur.Historique.map((trajet) => {
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
  } // Fin ajouterTrajetReserve
  //------------------------------------------------------------------------------------------
  Future<void> ajouterVehicule(Utilisateur utilisateur , Vehicule vehicule) async {
    utilisateur.vehicule = vehicule;
    await utilisateurCollection.doc(utilisateur.identifiant).set({
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
  //------------------------------------------------------------------------------------------
  Future<void> ajouterEvaluation(Utilisateur utilisateur ,Evaluation evaluation) async {
    utilisateur.evaluation = evaluation ;
    await utilisateurCollection.doc(utilisateur.identifiant).set({
      'evaluation': {
        'feedback': utilisateur.evaluation.feedback,
        'etoiles': utilisateur.evaluation.etoiles,
        'nbSignalement': utilisateur.evaluation.nbSignalement,
      },
    });
  } // Fin ajouterEvaluation
  //------------------------------------------------------------------------------------------
  Future<void> modifierStatut(Utilisateur utilisateur ,bool statut) async {
    utilisateur.statut = statut ;
    await utilisateurCollection.doc(utilisateur.identifiant).set({
      'statut': utilisateur.statut,
    });
  } // Fin modifierStatut
  //------------------------------------------------------------------------------------------
  Future<void> modifierNom(Utilisateur utilisateur ,String nom) async {
    utilisateur.nom = nom ;
    await utilisateurCollection.doc(utilisateur.identifiant).set({
      'nom': utilisateur.nom,
    });
  } // Fin modifierNom
  //------------------------------------------------------------------------------------------
  Future<void> modifierPrenom(Utilisateur utilisateur ,String prenom) async {
    utilisateur.prenom = prenom ;
    await utilisateurCollection.doc(utilisateur.identifiant).set({
      'prenom': utilisateur.prenom,
    });
  } // Fin modifierPrenom
  //------------------------------------------------------------------------------------------
  Future<void> modifierMotDePasse(Utilisateur utilisateur ,String motDePasse) async {
    utilisateur.motDePasse = motDePasse ;
    await utilisateurCollection.doc(utilisateur.identifiant).set({
      'motDePasse': utilisateur.motDePasse,
    });
  } // Fin modifierMotDePasse
  //------------------------------------------------------------------------------------------
  Future<String> getNbUtilisateurs() async {
    DocumentSnapshot snapshot = await nombreUsers.doc('NombreUtilisateurs').get();
    return snapshot.get('NombreUtilisateurs').toString();
  }
  //------------------------------------------------------------------------------------------
  Future<void> incrementerUtilisateurs() async{
    await nombreUsers.doc('NombreUtilisateurs').set({
      'NombreUtilisateurs': (int.parse(getNbUtilisateurs().toString())+1).toString(),
    });
  }
  //------------------------------------------------------------------------------------------
  /** ************************************** Geters ****************************************** **////
  Future<Utilisateur> getUtilisateur(String identifiant) async {
    try {
      DocumentSnapshot utilisateurSnapshot = await FirebaseFirestore.instance
          .collection('Utilisateur')
          .doc(identifiant)
          .get();
      if (utilisateurSnapshot.exists) {
        Map<String, dynamic> data = utilisateurSnapshot.data() as Map<String , dynamic>;
        Utilisateur utilisateur = Utilisateur(
          data['identifiant'],
          data['nom'],
          data['prenom'],
          data['email'],
          data['motDePasse'],
          data['numeroTelephone'],
          Evaluation(
            List<String>.from(data['evaluation']['feedback']),
            data['evaluation']['etoiles'],
            data['evaluation']['nbSignalement'],
          ),
          Vehicule(
            data['vehicule']['marque'],
            data['vehicule']['typevehicule'],
            data['vehicule']['matricule'],
            data['vehicule']['modele'],
            data['vehicule']['policeAssurance'],
            data['vehicule']['nbPlaces'],
          ),
          data['statut'],
          data['trajetsLances'] != null
              ? List<Trajet>.from(
              data['trajets'].map((trajet) => Trajet(
                trajet['horaire'],
                trajet['tempsDePause'],
                trajet['lieuDepart'],
                trajet['lieuArrivee'],
                trajet['coutTrajet'],
                trajet['villeDepart'],
                trajet['villeArrivee'],
                List<String>.from(trajet['villeIntermediaires']),
                PlusInformations(
                  trajet['plusInformations']['fumeur'],
                  trajet['plusInformations']['bagage'],
                  trajet['plusInformations']['animaux'],
                  trajet['plusInformations']['nbPlaces'],
                ),
                trajet['trajetEstValide'],
              )))
              : [],
          data['trajetsReserve'] != null
              ? List<Trajet>.from(
              data['trajets'].map((trajet) => Trajet(
                trajet['horaire'],
                trajet['tempsDePause'],
                trajet['lieuDepart'],
                trajet['lieuArrivee'],
                trajet['coutTrajet'],
                trajet['villeDepart'],
                trajet['villeArrivee'],
                List<String>.from(trajet['villeIntermediaires']),
                PlusInformations(
                  trajet['plusInformations']['fumeur'],
                  trajet['plusInformations']['bagage'],
                  trajet['plusInformations']['animaux'],
                  trajet['plusInformations']['nbPlaces'],
                ),
                trajet['trajetEstValide'],
              )))
              : [],
          data['Historique'] != null
              ? List<Trajet>.from(
              data['Historique'].map((trajet) => Trajet(
                trajet['horaire'],
                trajet['tempsDePause'],
                trajet['lieuDepart'],
                trajet['lieuArrivee'],
                trajet['coutTrajet'],
                trajet['villeDepart'],
                trajet['villeArrivee'],
                List<String>.from(trajet['villeIntermediaires']),
                PlusInformations(
                  trajet['plusInformations']['fumeur'],
                  trajet['plusInformations']['bagage'],
                  trajet['plusInformations']['animaux'],
                  trajet['plusInformations']['nbPlaces'],
                ),
                trajet['trajetEstValide'],
              )))
              : [],
        );
        return utilisateur;
      } else { // if user does not exist
        throw Exception("Utilisateur with id : $identifiant does not exist.");
      }
    } catch (e) {
      print(e);
      throw Exception("Failed to get utilisateur.");
    }
  }// end getuser
  //------------------------------------------------------------------------------------------

} // end Bdd class
      // use sharedPreferences to save the id of user loged in or how to do it ?
     // exemple de suvegarde user apres l'autentification  :
       /**
       auth();
       Utilisateur user = creerUtilisateurApresSignUp(controllerNom, controllerPrenom ...) ;
       BaseDeDonnee bdd = BaseDeDonnee().creerUtilisateur(user) ;
        **/