import 'package:appcouvoiturage/AppClasses/Vehicule.dart';
import 'package:cloud_firestore/cloud_firestore.dart' ;
import 'package:places_service/places_service.dart';
import '../AppClasses/Evaluation.dart';
import '../AppClasses/PlusInformations.dart';
import '../AppClasses/Trajet.dart';
import '../AppClasses/Utilisateur.dart';
import '../AppClasses/Notifications.dart';

class ConducteurTrajet {
  Utilisateur utilisateur;
  Trajet trajetLance;
  ConducteurTrajet(this.utilisateur, this.trajetLance);
}

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
      },
      'statut': utilisateur.statut,
      'notifications': utilisateur.notifications.map((notif) => {
        'id_conducteur': notif.id_conducteur,
        'id_pasagers': notif.id_pasagers,
        'id_trajet': notif.id_trajet,
        'nom': notif.nom ,
        'prenom': notif.prenom,
        'villeDepart': notif.villeDepart,
        'villeArrive': notif.villeArrive,
        'accepte_refuse': notif.accepte_refuse,
      }).toList(),
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
      },
      'statut': utilisateur.statut,
      'notifications': utilisateur.notifications.map((notif) => {
        'id_conducteur': notif.id_conducteur,
        'id_pasagers': notif.id_pasagers,
        'id_trajet': notif.id_trajet,
        'nom': notif.nom ,
        'prenom': notif.prenom,
        'villeDepart': notif.villeDepart,
        'villeArrive': notif.villeArrive,
        'accepte_refuse': notif.accepte_refuse,
      }).toList(),
    });
  } // Fin creerUtilisateur
  //------------------------------------------------------------------------------------------
  Utilisateur creerUtilisateurVide() {
    return Utilisateur("", "", "", "", "", "", Evaluation([], 5, 0),
        Vehicule("", "", "", "", ""), false, [],[],[],[]
    );
  }
  Trajet creerTrajetVide(){
    PlacesAutoCompleteResult lieuArrive = PlacesAutoCompleteResult(
      placeId: '',
      description: '',
      secondaryText: '',
      mainText: '',
    );
    PlacesAutoCompleteResult lieuDepart = lieuArrive;
    DateTime date = DateTime.now();DateTime time = DateTime.now();
    return Trajet('' , date, time, 0, '', '', lieuDepart, lieuArrive, [], PlusInformations(false, false,false,1), false, '', '', false);
  }
  //------------------------------------------------------------------------------------------
  Future<void> updateUtilisateurStatut(String uid, bool newStatut) async {
    DocumentReference utilisateurDocRef = utilisateurCollection.doc(uid);
    await utilisateurDocRef.update({'statut': newStatut});
  }
  Future<void> ajouterNotification(String uidRecepteur, Notifications not) async {
    DocumentReference utilisateurDocRef = utilisateurCollection.doc(uidRecepteur);
    Map<String, dynamic> notMap = not.toMap();
    await utilisateurDocRef.update({
      'notifications': FieldValue.arrayUnion([notMap]),
    });
  }
    //------------------------------------------------------------------------------------------
  Future<void> saveTrajetLanceAsSubcollection(String uid, Trajet trajetLance) async {
    Map<String, dynamic> trajetLanceData = trajetLance.toMap();
    DocumentReference docRef = await FirebaseFirestore.instance
        .collection('Utilisateur')
        .doc(uid)
        .collection('trajetsLances')
        .add(trajetLanceData);
    trajetLance.id = docRef.id;
    trajetLanceData = trajetLance.toMap();
    await FirebaseFirestore.instance
        .collection('Utilisateur')
        .doc(uid)
        .collection('trajetsLances')
        .doc(docRef.id)
        .set(trajetLanceData);
  }
  //------------------------------------------------------------------------------------------
  Future<void> saveTrajetReserveAsSubcollection(String uid, Trajet trajetReserve) async {
    Map<String, dynamic> trajetReserveData = trajetReserve.toMap();
    DocumentReference docRef = await FirebaseFirestore.instance
        .collection('Utilisateur')
        .doc(uid)
        .collection('trajetsReserves')
        .add(trajetReserveData);
    trajetReserve.id = docRef.id;
    trajetReserveData = trajetReserve.toMap();
    await FirebaseFirestore.instance
        .collection('Utilisateur')
        .doc(uid)
        .collection('trajetsReserves')
        .doc(docRef.id)
        .set(trajetReserveData);
  }
  //------------------------------------------------------------------------------------------
  Future<void> saveHistoriqueAsSubcollection(String uid, Trajet historique)async{
    Map<String, dynamic> historiqueData = historique.toMap();
    DocumentReference docRef = await FirebaseFirestore.instance
        .collection('Utilisateur')
        .doc(uid)
        .collection('Historique')
        .add(historiqueData);
    historique.id = docRef.id;
    historiqueData = historique.toMap();
    await FirebaseFirestore.instance
        .collection('Utilisateur')
        .doc(uid)
        .collection('Historique')
        .doc(docRef.id)
        .set(historiqueData);
  }
  //------------------------------------------------------------------------------------------
  Future<void> sauvegarderVillesIntermediaires(String uid, List<String> villes)async{
  }
  //------------------------------------------------------------------------------------------
  /** ************************************** Geters ****************************************** **////
  Future<Utilisateur> getDataFromDataBase(String uid)async {
    Utilisateur? utilisateur = creerUtilisateurVide();
    try {
      await FirebaseFirestore.instance.collection('Utilisateur')
          .doc(uid)
          .get()
          .then((snapshot) async {
        if (snapshot.exists) {
            print('Oui utilisateur ${snapshot.data()!['nom']} existe');
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
            );
            utilisateur.statut = snapshot.data()!['statut'];
            utilisateur.notifications = [];
            List<dynamic> notificationsData = snapshot.data()!['notifications'];
            if (notificationsData.isNotEmpty){
              for (var notificationData in notificationsData) {
                Notifications notification = Notifications(
                  notificationData['id_conducteur'],
                  notificationData['id_pasagers'],
                  notificationData['id_trajet'],
                  notificationData['nom'],
                  notificationData['prenom'],
                  notificationData['villeDepart'],
                  notificationData['villeArrive'],
                  notificationData['accepte_refuse'],
                );
                utilisateur.notifications.add(notification);
              }
            }
            utilisateur.afficher();
            return utilisateur;
            //tests by printing
        } else { // end snapshot exist
          throw Exception("Utilisateur does not exist.");
        }
      });
    } catch (e) {
      throw Exception("Failed to get utilisateur.");
    }
    return BaseDeDonnee().creerUtilisateurVide();
  } /// end getdata
  // Future<dynamic> getStatut(String uid) async {
  //   bool statut = false;
  //   await FirebaseFirestore.instance
  //       .collection('Utilisateur')
  //       .doc(uid)
  //       .get()
  //       .then((snapshot) async {
  //     if (snapshot.exists) {
  //       statut = snapshot.data()!['statut'];
  //       return statut;
  //     }else {
  //       return null;
  //     }
  //   });
  // }
  Future<bool?> getStatut(String uid) async {
    bool? statut;
    await FirebaseFirestore.instance
        .collection('Utilisateur')
        .doc(uid)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        statut = snapshot.data()!['statut'] as bool?;
      } else {
        statut = null;
      }
    });
    return statut;
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
    );
  }
  bool validerMotDePasse(String motDePasse){
    return (motDePasse.length >= 8 && motDePasse.isNotEmpty);
    /** Si on veut tester un mot de passe tres fort on va la faire autrement**/
  }
  bool validerEmail(String email){
    final regex = RegExp(r'[0-9]');
    return (email.endsWith('@esi.dz') && !regex.hasMatch(email) && email.isNotEmpty && !email.contains(' '));
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
  /// *********************************************************************************************************

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
        );
        utilisateur.statut = data['statut'];
        List<dynamic> notificationsData = data['notifications'];
        for (var notificationData in notificationsData) {
          Notifications notification = Notifications(
            notificationData['id_conducteur'],
            notificationData['id_pasagers'],
            notificationData['id_trajet'],
            notificationData['nom'],
            notificationData['prenom'],
            notificationData['villeDepart'],
            notificationData['villeArrive'],
            notificationData['accepte_refuse'],
          );
          utilisateur.notifications.add(notification);
        }
        utilisateurs.add(utilisateur);
      }
      return utilisateurs;
    } catch (e) {
      throw Exception("Failed to get utilisateurs by name: $e");
    }
  }

  Future<List<ConducteurTrajet>> chercherConductuersPossibles(String uid , Trajet trajetReserve) async {
    /// 1) recuperer le trajet reserve par le passager --------------------
    /*Trajet trajetReserve = creerTrajetVide();
    await FirebaseFirestore.instance
        .collection('Utilisateur')
        .doc(uid)
        .collection('trajetsReserves')
        .doc(idTrajetReserve)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        trajetReserve.dateDepart = snapshot.data()!['dateDepart'].toDate().add(Duration(hours: 1));
        trajetReserve.tempsDePause = snapshot.data()!['tempsDePause'].toDate().add(Duration(hours: 1));
        trajetReserve.coutTrajet = snapshot.data()!['coutTrajet'] as double;
        trajetReserve.villeDepart = snapshot.data()!['villeDepart'];
        trajetReserve.villeArrivee = snapshot.data()!['villeArrivee'];
        /*trajetReserve.lieuDepart = PlacesAutoCompleteResult(
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
        );*/
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
      }else print('ce trajetReserve n\'exist pas');
    }); // fin recuperation du trajetReserve
    */
    DateTime TempsPmoins15 = trajetReserve.dateDepart.subtract(Duration(minutes: 15));
    DateTime TempsPplus4h = trajetReserve.dateDepart.add(Duration(hours: 4));
    trajetReserve.afficher();
    /// 2) rechercher les utilisateurs (le conducteurs) qui ont un trajetLance similaire au trajetReserve -------
    try {
      List<ConducteurTrajet> listConducteurTrajet = [];
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
            .get();
        if (trajetsSnapshot.docs.isNotEmpty) {
          print("Le trajet Existe");
          for (QueryDocumentSnapshot trajetLanceDoc in trajetsSnapshot.docs) {
            Map<String, dynamic> data = trajetLanceDoc.data() as Map<String, dynamic>;
            DateTime t1 = data['dateDepart'].toDate();
            t1 = t1.add(Duration(hours: 1));
            if (
            (trajetReserve.villeDepart == data['villeDepart']
                || List<String>.from(data['villeIntermediaires']).contains(trajetReserve.villeDepart))
                && (trajetReserve.villeArrivee == data['villeArrivee']
                    || List<String>.from(data['villeIntermediaires']).contains(trajetReserve.villeArrivee))
                && data['plusInformations']['nbPlaces'] >= trajetReserve.plusInformations.nbPlaces
                 && ( t1.isAfter(TempsPmoins15) || t1.isAtSameMomentAs(TempsPmoins15) )
                 && ( t1.isBefore(TempsPplus4h) || t1.isAtSameMomentAs(TempsPplus4h) )
            ) {
                print('Les conditions sont verifier pour ${dataUtilisateur['nom']}');
                Utilisateur utilisateur = creerUtilisateurVide();
                Trajet trajetLance = creerTrajetVide();
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
                );
                utilisateur.statut = dataUtilisateur['statut'];
                List<dynamic> notificationsData = dataUtilisateur['notifications'];
                for (var notificationData in notificationsData) {
                  Notifications notification = Notifications(
                    notificationData['id_conducteur'],
                    notificationData['id_pasagers'],
                    notificationData['id_trajet'],
                    notificationData['nom'],
                    notificationData['prenom'],
                    notificationData['villeDepart'],
                    notificationData['villeArrive'],
                    notificationData['accepte_refuse'],
                  );
                  utilisateur.notifications.add(notification);
                }
                utilisateur.afficher();
                trajetLance.dateDepart = data['dateDepart'].toDate().add(Duration(hours: 1));
                trajetLance.tempsDePause = data['tempsDePause'].toDate().add(Duration(hours: 1));
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
                trajetLance.afficher();
                ConducteurTrajet conducteurTrajet = ConducteurTrajet(utilisateur, trajetLance);
                listConducteurTrajet.add(conducteurTrajet);
              }else { print('Les conditions ne sont pas verifier pour ${dataUtilisateur['nom']} ');
            }// end if conditions de recherche
          } // end for trajetLanceDoc
        }else { print("Le trajet n\'existe pas!");} // end if trajetsLances exist dans le conducteur
      } // end for utilisateurDoc
      print('Resultat de recherche : ');
      for(ConducteurTrajet c in listConducteurTrajet) c.utilisateur.afficher();
      return listConducteurTrajet;
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