import 'package:appcouvoiturage/AppClasses/Vehicule.dart';
import 'package:cloud_firestore/cloud_firestore.dart' ;
import 'package:firebase_auth/firebase_auth.dart';
import '../AppClasses/Evaluation.dart';
import '../AppClasses/PlusInformations.dart';
import '../AppClasses/Trajet.dart';
import '../AppClasses/Utilisateur.dart';

class BaseDeDonnee{
  final CollectionReference utilisateurCollection = FirebaseFirestore.instance.collection('Utilisateur');
  /** *********************************** Seters (ajout et modifications) *********************************** **////
  Future<void> creerUtilisateur(Utilisateur utilisateur) async {
    await utilisateurCollection.doc(utilisateur.identifiant).set({
      'identifiant': utilisateur.identifiant,
      'nom': utilisateur.nom,
      'prenom': utilisateur.prenom,
      'email': utilisateur.email,
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
        'confort': trajet.confort,
        'avis': trajet.avis,
        'probleme': trajet.probleme,
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
        'confort': trajet.confort,
        'avis': trajet.avis,
        'probleme': trajet.probleme,
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
        'confort': trajet.confort,
        'avis': trajet.avis,
        'probleme': trajet.probleme,
      }).toList(),
    });
  } // Fin creerUtilisateur
  Future<void> modifierUtilisateur(String uid,Utilisateur utilisateur) async {
    await utilisateurCollection.doc(uid).set({
      'identifiant': uid,
      'nom': utilisateur.nom,
      'prenom': utilisateur.prenom,
      'email': utilisateur.email,
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
        'confort': trajet.confort,
        'avis': trajet.avis,
        'probleme': trajet.probleme,
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
        'confort': trajet.confort,
        'avis': trajet.avis,
        'probleme': trajet.probleme,
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
        'confort': trajet.confort,
        'avis': trajet.avis,
        'probleme': trajet.probleme,
      }).toList(),
    });
  } // Fin creerUtilisateur
  //------------------------------------------------------------------------------------------
  Utilisateur creerUtilisateurVide() {
    return Utilisateur("", "", "", "", "", "", Evaluation([], 5, 0),
        Vehicule("", "", "", "", "", 0), false, [],[],[]
    );
  }
  //------------------------------------------------------------------------------------------
  /** ************************************** Geters ****************************************** **////
  Future getDataFromDataBase(Utilisateur utilisateur)async {
    utilisateur = BaseDeDonnee().creerUtilisateurVide();
    try {
      await FirebaseFirestore.instance.collection('Utilisateur')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((snapshot) async {
        if (snapshot.exists) {
            utilisateur.identifiant = snapshot.data()!['identifiant'];
            utilisateur.nom = snapshot.data()!['nom'];
            utilisateur.prenom = snapshot.data()!['prenom'];
            utilisateur.email = snapshot.data()!['email'];
            utilisateur.numeroTelephone = snapshot.data()!['numeroTelephone'];
            utilisateur.evaluation = Evaluation(
              List<String>.from(snapshot.data()!['evaluation']['feedback']),
              snapshot.data()!['evaluation']['etoiles'],
              snapshot.data()!['evaluation']['nbSignalement'],
            );
            utilisateur.vehicule = Vehicule(
              snapshot.data()!['vehicule']['marque'],
              snapshot.data()!['vehicule']['typevehicule'],
              snapshot.data()!['vehicule']['matricule'],
              snapshot.data()!['vehicule']['modele'],
              snapshot.data()!['vehicule']['policeAssurance'],
              snapshot.data()!['vehicule']['nbPlaces'],
            );
            utilisateur.statut = snapshot.data()!['statut'];
            utilisateur.trajetsLances =
            snapshot.data()!['trajetsLances'] != null
                ? List<Trajet>.from(snapshot.data()!['trajetsLances'].map(
                  (trajet) =>
                  Trajet(
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
                    trajet['confort'],
                    trajet['avis'],
                    trajet['probleme'],
                  ),
            ))
                : [];
            utilisateur.trajetsReserves =
            snapshot.data()!['trajetsReserves'] != null
                ? List<Trajet>.from(snapshot.data()!['trajetsReserves'].map(
                  (trajet) =>
                  Trajet(
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
                      trajet['confort'],
                      trajet['avis'],
                      trajet['probleme'],
                  ),
            ))
                : [];
            utilisateur.Historique = snapshot.data()!['Historique'] != null
                ? List<Trajet>.from(snapshot.data()!['Historique'].map(
                  (trajet) =>
                  Trajet(
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
                      trajet['confort'],
                      trajet['avis'],
                      trajet['probleme'],
                  ),
            ))
                : [];
            //tests by printing
        } else { // end snapshot exist
          throw Exception("Utilisateur does not exist.");
        }
      });
    } catch (e) {
      throw Exception("Failed to get utilisateur.");
    }
  } /// end getdata

  Future<void> updateUtilisateurStatut(String uid, bool newStatut) async {
    DocumentReference utilisateurDocRef = utilisateurCollection.doc(uid);
    await utilisateurDocRef.update({'statut': newStatut});
  }
  bool validerNomEtPrenom(String value) {
    String chaineTest = value;
    String pattern = r'^[a-zA-Z\u0600-\u06FF ]+$';
    RegExp regExp = new RegExp(pattern);
    chaineTest = value.replaceAll(' ', '');
    return!(
        value.length > 20 || chaineTest.isEmpty
        || !regExp.hasMatch(chaineTest)
        || value.startsWith(' ') || value.endsWith(' ')
    );
  }
  bool validerMotDePasse(String motDePasse){
    return (motDePasse.length >= 8 && motDePasse.isNotEmpty);
    /** Si on veut tester un mot de passe tres fort on va la faire autrement**/
  }

  bool validerEmail(String email){
    final regex = RegExp(r'[0-9]');
    return (email.endsWith('@esi.dz') && !regex.hasMatch(email) && email.isNotEmpty);
  }

  bool validatePhoneNumber(String phoneNumber) {
    phoneNumber = phoneNumber.replaceAll(RegExp(r'\s|-'), '');
    return (
        phoneNumber.length == 10
            && (   phoneNumber.startsWith('05')
            || phoneNumber.startsWith('06')
            || phoneNumber.startsWith('07')
        )
            && isNumeric(phoneNumber)
    );
  }
  bool isNumeric(String str) {
    if (str == null || str.isEmpty) {
      return false;
    }
    return double.tryParse(str) != null;
  }
} // end Bdd class