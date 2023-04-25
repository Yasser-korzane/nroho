import 'dart:ffi';

import 'package:appcouvoiturage/AppClasses/Vehicule.dart';
import 'package:cloud_firestore/cloud_firestore.dart' ;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:places_service/places_service.dart';
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
  Future<void> saveHistoriqueAsSubcollection(String uid, Trajet historique)async{
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
  Future<dynamic> getStatut(String uid) async {
    bool statut = false;
    await FirebaseFirestore.instance
        .collection('Utilisateur')
        .doc(uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        statut = snapshot.data()!['statut'];
        return statut;
      }else {
        return null;
      }
    });
  }

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
  Future<List<Utilisateur>> getUtilisateursByName(String name) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Utilisateur')
          .where('nom', isEqualTo: name)
          .get();
      List<Utilisateur> utilisateurs = [];
      for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        Utilisateur utilisateur = creerUtilisateurVide();
        utilisateur.identifiant = data['identifiant'];
        utilisateur.nom = data['nom'];
        utilisateur.prenom = data['prenom'];
        utilisateur.email = data['email'];
        utilisateur.numeroTelephone = data['numeroTelephone'];
        utilisateur.evaluation = Evaluation(
          List<String>.from(data['evaluation']['feedback']),
          data['evaluation']['etoiles'],
          data['evaluation']['nbSignalement'],
        );
        utilisateur.vehicule = Vehicule(
          data['vehicule']['marque'],
          data['vehicule']['typevehicule'],
          data['vehicule']['matricule'],
          data['vehicule']['modele'],
          data['vehicule']['policeAssurance'],
          data['vehicule']['nbPlaces'],
        );
        utilisateur.statut = data['statut'];
        utilisateurs.add(utilisateur);
      }
      return utilisateurs;
    } catch (e) {
      throw Exception("Failed to get utilisateurs by name: $e");
    }
  }

  Future chercherConductuersPossibles(String uid , String idTrajetReserve) async {
    /// 1) recuperer le trajet reserve par le passager --------------------
    DateTime date = DateTime.now();DateTime time = DateTime.now();
    PlacesAutoCompleteResult lieuDepart = PlacesAutoCompleteResult(
      placeId: '',
      description: '',
      secondaryText: '',
      mainText: '',
    );
    PlacesAutoCompleteResult lieuArrive = PlacesAutoCompleteResult(
      placeId: '',
      description: '',
      secondaryText: '',
      mainText: '',
    );
    Trajet trajetReserve = Trajet(date, time, 0, '', '',lieuDepart,lieuArrive, [], PlusInformations(false, false, false, 1), false, '', '', false);
    await FirebaseFirestore.instance
        .collection('Utilisateur')
        .doc(uid)
        .collection('trajetsReserves')
        .doc(idTrajetReserve)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        trajetReserve.dateDepart = snapshot.data()!['dateDepart'].toDate();
        trajetReserve.tempsDePause = snapshot.data()!['tempsDePause'].toDate();
        trajetReserve.coutTrajet = snapshot.data()!['coutTrajet'] as double;
        trajetReserve.villeDepart = snapshot.data()!['villeDepart'];
        trajetReserve.villeArrivee = snapshot.data()!['villeArrivee'];
        trajetReserve.lieuDepart = PlacesAutoCompleteResult(
            placeId: snapshot.data()!['lieuDepart']['placeId'],
            description: snapshot.data()!['lieuDepart']['description'],
            secondaryText: snapshot.data()!['lieuDepart']['secondaryText'],
            mainText: snapshot.data()!['lieuDepart']['mainText'],
        );
        trajetReserve.lieuArrivee = PlacesAutoCompleteResult(
            placeId: snapshot.data()!['lieuArrivee']['placeId'],
            description: snapshot.data()!['lieuArrivee']['description'],
            secondaryText: snapshot.data()!['lieuArrivee']['secondaryText'],
            mainText: snapshot.data()!['lieuArrivee']['mainText'],
        );
        trajetReserve.villeIntermediaires = List<String>.from(snapshot.data()!['villeIntermediaires']);
        trajetReserve.plusInformations = PlusInformations(
            snapshot.data()!['plusInformations']['fumeur'],
            snapshot.data()!['plusInformations']['bagage'],
            snapshot.data()!['plusInformations']['animaux'],
            snapshot.data()!['plusInformations']['nbPlaces']);
        trajetReserve.trajetEstValide = snapshot.data()!['trajetEstValide'];
        trajetReserve.confort = snapshot.data()!['confort'];
        trajetReserve.avis = snapshot.data()!['avis'];
        trajetReserve.probleme = snapshot.data()!['probleme'];
      }
    }); // fin recuperation du trajetReserve
    DateTime TempsPmoins10 = trajetReserve.dateDepart.subtract(Duration(minutes: 10));
    DateTime TempsPplus20 = trajetReserve.dateDepart.add(Duration(minutes: 20));
    trajetReserve.afficher();
    print("TempsPmoins10 : ${TempsPmoins10.year}/${TempsPmoins10.month}/${TempsPmoins10.day}/${TempsPmoins10.hour}/${TempsPmoins10.minute}");
    print("TempsPplus20 : ${TempsPplus20.year}/${TempsPplus20.month}/${TempsPplus20.day}/${TempsPplus20.hour}/${TempsPplus20.minute}");
    /// 2) rechercher les utilisateurs (le conducteurs) qui ont un trajetLance similaire au trajetReserve -------
    try {
      List<Utilisateur> utilisateurs = [];
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Utilisateur')
          .where('identifiant',isNotEqualTo: uid)
          .get();
      for (QueryDocumentSnapshot utilisateurDoc in querySnapshot.docs) {
        Map<String, dynamic> dataUtilisateur = utilisateurDoc.data() as Map<String, dynamic>;
        print(utilisateurDoc.get('nom'));
        QuerySnapshot trajetsSnapshot = await FirebaseFirestore.instance
            .collection('Utilisateur')
            .doc(utilisateurDoc.id)
            .collection('trajetsLances')
            .where('dateDepart', isLessThanOrEqualTo: Timestamp.fromDate(TempsPplus20))
            .where('dateDepart', isGreaterThanOrEqualTo: Timestamp.fromDate(TempsPmoins10))
            .get();
        if (trajetsSnapshot.docs.isNotEmpty) {
          print("Le trajet Existe");
          for (QueryDocumentSnapshot trajetLanceDoc in trajetsSnapshot.docs) {
            Map<String, dynamic> data = trajetLanceDoc.data() as Map<String, dynamic>;
            if ((trajetReserve.villeDepart == data['villeDepart']
                || List<String>.from(data['villeIntermediaires']).contains(trajetReserve.villeDepart))
                && (trajetReserve.villeArrivee == data['villeArrivee']
                    || List<String>.from(data['villeIntermediaires']).contains(trajetReserve.villeArrivee))
            ) {
                print('Les conditions sont verifier pour ${dataUtilisateur['nom']}');
                Utilisateur utilisateur = creerUtilisateurVide();
                utilisateur.identifiant = dataUtilisateur['identifiant'];
                utilisateur.nom = dataUtilisateur['nom'];
                utilisateur.prenom = dataUtilisateur['prenom'];
                utilisateur.email = dataUtilisateur['email'];
                utilisateur.numeroTelephone = dataUtilisateur['numeroTelephone'];
                utilisateur.evaluation = Evaluation(
                  List<String>.from(dataUtilisateur['evaluation']['feedback']),
                  dataUtilisateur['evaluation']['etoiles'],
                  dataUtilisateur['evaluation']['nbSignalement'],
                );
                utilisateur.vehicule = Vehicule(
                  dataUtilisateur['vehicule']['marque'],
                  dataUtilisateur['vehicule']['typevehicule'],
                  dataUtilisateur['vehicule']['matricule'],
                  dataUtilisateur['vehicule']['modele'],
                  dataUtilisateur['vehicule']['policeAssurance'],
                  dataUtilisateur['vehicule']['nbPlaces'],
                );
                utilisateur.statut = dataUtilisateur['statut'];
                utilisateurs.add(utilisateur);
                print("hello");
                utilisateur.afficher();
              }else { print('Les conditions ne sont pas verifier pour ${data['villeDepart']} ${data['villeArrivee']}');
            }// end if conditions de recherche
          } // end for trajetLanceDoc
        }else { print("Le trajet n\'existe pas!");} // end if trajetsLances exist dans le conducteur
      } // end for utilisateurDoc
      print('Resultat de recherche : ');
      for (Utilisateur u in utilisateurs) u.afficher();
      return utilisateurs;
    } catch (e) {
      throw Exception("Failed to get utilisateurs : $e");
    }
  }
/// querySnapshot contient tout les references de toute les Utilisateurs
/// querySnapshot.docs contient les utilisateurs avec leurs documents
/// utilisateurDoc va pointe sur chaque utilisateur et ses informations
/// trajetsSnapshot contient tout les references de toute les trajetsLances de chaque utilisateur
/// trajetsSnapshot.docs contient les trajetsLancesavec leurs documents
/// utilisateurDoc va pointe sur chaque utilisateur et ses informations
/// trajetLanceDoc va pointe sur chaque trajetLance et ses informations
/// trajetDoc va pointe sur chaque trajetLance d'un utilisateur
    /**
        DONC ON VA PARCOURIR TOUT LES UTILISATEURS AVEC utilisateurDoc
        ET POUR CHAQUE UTILISATEUR ON VA PARCOURIR CA LIST DE trajetsLances
        AVEC trajetLanceDoc

        //.where('plusInformations.nbPlaces', isGreaterThanOrEqualTo: trajetReserve.plusInformations.nbPlaces)
        //.where('plusInformations.fumeur', isGreaterThanOrEqualTo: trajetReserve.plusInformations.fumeur)
        //.where('plusInformations.animaux', isGreaterThanOrEqualTo: trajetReserve.plusInformations.animaux)
        //.where('plusInformations.bagage', isGreaterThanOrEqualTo: trajetReserve.plusInformations.bagage)

     **/


/** Les criteres de recherche :
    on a donne pour le trajet :
    - 'ville departP' #
    - 'ville arriveP' #
    - 'date departP' #
    - 'heure departP' #
    les donnee qu'on va comparer :
    - 'ville departC' #
    - 'ville arriveC' #
    - 'date departC' #
    - 'heure departC' #
    resultat :
 * 'date departC' soit egale srictement :  'date departC' == 'date departP' ## OUI ##
 * 'heure departC' du conductuer soit compris entre: 'heure departP'-10<='heure departC'< 'heure departP'+20'  ## OUI ##
 * 'ville departP' soit egale a 'ville departC' ou appartient au villeIntermedieres entre 'ville departC' et 'ville arriveC'
 * 'ville arriveP' soit egale a 'ville arriveC' ou appartient au villeIntermedieres entre 'ville departC' et 'ville arriveC'

    exemple : ville departP = 'BeauLieu'
    ville arriveP = 'Esi'
    ville departC = 'Bouraoui'
    ville arriveC = 'Esi'
    villesIntermedieres('Bouraoui','Esi') = ['garnaison','BeauLieu','Itemm']

    DateTime dateTime = timestamp.toDate();
    Timestamp timestamp = Timestamp.fromDate(dateTime);
 **/


} // end Bdd class