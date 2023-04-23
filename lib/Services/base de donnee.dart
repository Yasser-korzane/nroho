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
      //'motDePasse': utilisateur.motDePasse,
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
    });
  } // Fin creerUtilisateur
  //------------------------------------------------------------------------------------------
  Future<void> modifierUtilisateur(String uid,Utilisateur utilisateur) async {
    await utilisateurCollection.doc(uid).set({
      'identifiant': uid,
      'nom': utilisateur.nom,
      'prenom': utilisateur.prenom,
      'email': utilisateur.email,
      'numeroTelephone': utilisateur.numeroTelephone,
      //'motDePasse': utilisateur.motDePasse,
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
    });
  } // Fin creerUtilisateur
  //------------------------------------------------------------------------------------------
  Utilisateur creerUtilisateurVide() {
    return Utilisateur("", "", "", "", "", "", Evaluation([], 5, 0),
        Vehicule("", "", "", "", "", 0), false, [],[],[]
    );
  }
  //------------------------------------------------------------------------------------------
  Future<void> updateUtilisateurStatut(String uid, bool newStatut) async {
    DocumentReference utilisateurDocRef = utilisateurCollection.doc(uid);
    await utilisateurDocRef.update({'statut': newStatut});
  }
  //------------------------------------------------------------------------------------------
  Future<void> saveTrajetLanceAsSubcollection(String uid, Trajet trajetLance) async {
    Map<String, dynamic> trajetLanceData = trajetLance.toMap();
    await FirebaseFirestore.instance
        .collection('Utilisateur')
        .doc(uid)
        .collection('trajetsLances')
        .add(trajetLanceData);
  }
  //------------------------------------------------------------------------------------------
  Future<void> saveTrajetReserveAsSubcollection(String uid, Trajet trajetReserve) async {
    Map<String, dynamic> trajetReserveData = trajetReserve.toMap();
    await FirebaseFirestore.instance
        .collection('Utilisateur')
        .doc(uid)
        .collection('trajetsReserves')
        .add(trajetReserveData);
  }
  //------------------------------------------------------------------------------------------
  Future<void> sauvegarderHistoriqueAsSubcollection(String uid, Trajet historique)async{
    Map<String, dynamic> historiqueData = historique.toMap();
    await FirebaseFirestore.instance
        .collection('Utilisateur')
        .doc(uid)
        .collection('Historique')
        .add(historiqueData);
  }
  //------------------------------------------------------------------------------------------
  Future<void> sauvegarderVillesIntermediaires(String uid, List<String> villes)async{

  }
  //------------------------------------------------------------------------------------------
  /** ************************************** Geters ****************************************** **////
  Future getDataFromDataBase(Utilisateur utilisateur)async {
    utilisateur = creerUtilisateurVide();
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
            //utilisateur.motDePasse = snapshot.data()!['motDePasse'];
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
            //tests by printing
        } else { // end snapshot exist
          throw Exception("Utilisateur does not exist.");
        }
      });
    } catch (e) {
      throw Exception("Failed to get utilisateur.");
    }
  } /// end getdata
  /// ************************************ Fonctions de validation **************************************
  bool validerNomEtPrenom(String value) {
    String chaineTest = value;
    String pattern = r'^[a-zA-Z\u0600-\u06FF ]+$';
    RegExp regExp = RegExp(pattern);
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
    if (str.isEmpty) {
      return false;
    }
    return double.tryParse(str) != null;
  }
} // end Bdd class