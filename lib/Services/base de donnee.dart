import 'package:appcouvoiturage/AppClasses/Vehicule.dart';
import 'package:cloud_firestore/cloud_firestore.dart' ;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places_service/places_service.dart';
import '../AppClasses/Evaluation.dart';
import '../AppClasses/PlusInformations.dart';
import '../AppClasses/Trajet.dart';
import '../AppClasses/Utilisateur.dart';
import '../AppClasses/Notifications.dart';
import 'package:geolocator/geolocator.dart';

class ConducteurTrajet {
  Utilisateur utilisateur;
  Trajet trajetLance;
  ConducteurTrajet(this.utilisateur, this.trajetLance);
}

class BaseDeDonnee{
  final CollectionReference utilisateurCollection = FirebaseFirestore.instance.collection('Utilisateur');
  final CollectionReference gestionConfilits = FirebaseFirestore.instance.collection('ConsultationDesConfilits');
  final CollectionReference mauvaisUtilisateurs = FirebaseFirestore.instance.collection('Mauvais_Utilisateurs');

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
        'id_trajetLance': notif.id_trajetLance,
        'id_trajetReserve': notif.id_trajetReserve,
        'nom': notif.nom ,
        'prenom': notif.prenom,
        'villeDepart': notif.villeDepart,
        'villeArrive': notif.villeArrive,
        'accepte_refuse': notif.accepte_refuse,
      }).toList(),
      'imageUrl': utilisateur.imageUrl,
      'fcmTocken': utilisateur.fcmTocken,
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
        'id_trajetLance': notif.id_trajetLance,
        'id_trajetReserve': notif.id_trajetReserve,
        'nom': notif.nom ,
        'prenom': notif.prenom,
        'villeDepart': notif.villeDepart,
        'villeArrive': notif.villeArrive,
        'accepte_refuse': notif.accepte_refuse,
      }).toList(),
      'imageUrl': utilisateur.imageUrl,
      'fcmTocken': utilisateur.fcmTocken,
    });
  } // Fin creerUtilisateur
  //------------------------------------------------------------------------------------------
  Utilisateur creerUtilisateurVide() {
    return Utilisateur("", "", "", "", "", "", Evaluation([], 5, 0),
        Vehicule("", "", "", "", ""), false, [],[],[],[],'https://www.pngkey.com/png/full/115-1150152_default-profile-picture-avatar-png-green.png',''
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
    return Trajet('' , date, time, 0, '', '', lieuDepart, lieuArrive, [], PlusInformations(false, false,false,1), false, '', '', false,LatLng(0.0, 0.0),LatLng(0.0, 0.0),'',[]);
  }
  //------------------------------------------------------------------------------------------
  Future<void> updateUtilisateurStatut(String uid, bool newStatut) async {
    DocumentReference utilisateurDocRef = utilisateurCollection.doc(uid);
    await utilisateurDocRef.update({'statut': newStatut});
  }
  Future<void> saveInfoUserAfterTrajet(String uid,int nbEtoiles,String avis,bool signale)async {
    /// si signal est true alors on va incrementer nbSignalement a l'utilisateur
    DocumentReference utilisateurDocRef = utilisateurCollection.doc(uid);
    Evaluation evaluation = Evaluation([], 0, 0);
    String email = '';
    await FirebaseFirestore.instance
        .collection('Utilisateur')
        .doc(uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        email = snapshot.data()!['email'];
        evaluation = Evaluation(
          List<String>.from(snapshot.data()!['evaluation']['feedback']),
          snapshot.data()!['evaluation']['etoiles'],
          snapshot.data()!['evaluation']['nbSignalement']);
        evaluation.etoiles = ((evaluation.etoiles+nbEtoiles) / 2).ceil() ;
        evaluation.feedback.add(avis);
        if (signale) evaluation.nbSignalement++;
        if (evaluation.nbSignalement >=3) await ajouterMauvaisUtilisateur(uid,email);
        await utilisateurDocRef.update({'evaluation': evaluation.toMap()});
      }else print('Ce utilisateur n\'exist pas');
    });
  }

  Future<void> updateUtilisateurfcmTocken(String uid, String fcmTocken) async {
    DocumentReference utilisateurDocRef = utilisateurCollection.doc(uid);
    await utilisateurDocRef.update({'fcmTocken': fcmTocken});
  }
  Future<void> updateUtilisateurImage(String uid, String imageUrl) async {
    DocumentReference utilisateurDocRef = utilisateurCollection.doc(uid);
    await utilisateurDocRef.update({'imageUrl': imageUrl});
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
  Future<void> modifierTrajetLance(String uidTrajetLance,String idConducteur,String idPassager)async{
    DocumentReference utilisateurDocRef = utilisateurCollection.doc(idConducteur).collection('trajetsLances').doc(uidTrajetLance);
    await utilisateurDocRef.update({'trajetEstValide': true});
    await utilisateurDocRef.update({'idConductuer':idConducteur});
    await utilisateurDocRef.update({'idPassagers': FieldValue.arrayUnion([idPassager]),});
  }
  //------------------------------------------------------------------------------------------
  Future<String> saveTrajetReserveAsSubcollection(String uid, Trajet trajetReserve) async {
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
    return docRef.id;
  }
  Future<void> modifierTrajetReserve(String uidTrajetReserve,String idConducteur,String idPassager)async{
    DocumentReference utilisateurDocRef = utilisateurCollection.doc(idPassager).collection('trajetsReserves').doc(uidTrajetReserve);
    await utilisateurDocRef.update({'trajetEstValide': true});
    await utilisateurDocRef.update({'idConductuer':idConducteur});
    await utilisateurDocRef.update({'idPassagers': FieldValue.arrayUnion([idPassager]),});
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
  Future<void> ajouterConflit(String idConducteur , String idPassager, String idTrajetConductuer ,String idTrajetPassager) async {
    String uid = alternerChaines(idConducteur, idPassager);
    await utilisateurCollection.doc(uid).set({
      'idConducteur': idConducteur,
      'idPassager': idPassager,
      'idTrajetConductuer': idTrajetConductuer,
      'idTrajetPassager': idTrajetPassager,
    });
  }
  Future<void> ajouterMauvaisUtilisateur(String uid, String email) async {
    await mauvaisUtilisateurs.doc(uid).set({
      'id': uid,
      'email': email,
    });
  }
  Future <void> incrementerNbPlacesConducteur(String uid, String idTrajet)async {
    PlusInformations plusInformations = PlusInformations(false, false, false, 1);
    await FirebaseFirestore.instance
        .collection('Utilisateur')
        .doc(uid)
        .collection('trajetsLances')
        .doc(idTrajet)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        plusInformations = PlusInformations(
            snapshot.data()!['plusInformations']['fumeur'],
            snapshot.data()!['plusInformations']['bagage'],
            snapshot.data()!['plusInformations']['animaux'],
            snapshot.data()!['plusInformations']['nbPlaces']);
      }else print('ce trajet n\'exist pas');
    });
    plusInformations.nbPlaces++;
    Map<String, dynamic> plusInformationsMap = plusInformations.toMap();
    DocumentReference utilisateurDocRef = utilisateurCollection.doc(uid).collection('trajetsLances').doc(idTrajet);
    await utilisateurDocRef.update({'plusInformations': plusInformationsMap});
  }
  Future <void> decrementerNbPlacesConducteur(String uid, String idTrajet)async {
    PlusInformations plusInformations = PlusInformations(false, false, false, 1);
    await FirebaseFirestore.instance
        .collection('Utilisateur')
        .doc(uid)
        .collection('trajetsLances')
        .doc(idTrajet)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        plusInformations = PlusInformations(
            snapshot.data()!['plusInformations']['fumeur'],
            snapshot.data()!['plusInformations']['bagage'],
            snapshot.data()!['plusInformations']['animaux'],
            snapshot.data()!['plusInformations']['nbPlaces']);
      }else print('ce trajet n\'exist pas');
    });
    plusInformations.nbPlaces--;
    if (plusInformations.nbPlaces >=0){
    Map<String, dynamic> plusInformationsMap = plusInformations.toMap();
    DocumentReference utilisateurDocRef = utilisateurCollection.doc(uid).collection('trajetsLances').doc(idTrajet);
    await utilisateurDocRef.update({'plusInformations': plusInformationsMap});
    }else throw Exception('nbPlaces est negative');
  }
  Future<void>annulerTrajetLance(String uid, String idTrajetLance) async{
    DocumentReference trajetRef = utilisateurCollection.doc(uid).collection('trajetsLances').doc(idTrajetLance);
    trajetRef.delete();
  }
  Future<void>annulerTrajetReserve(String uid, String idTrajetLance) async{
    DocumentReference trajetRef = utilisateurCollection.doc(uid).collection('trajetsReserves').doc(idTrajetLance);
    trajetRef.delete();
  }
  //------------------------------------------------------------------------------------------
  /** ************************************** Geters ****************************************** **////
  Future<List<String>> getNomPrenom(String uid)async {
    String nom = '' ;
    String prenom = '' ;
    List<String> listNomPrenom = [];
    try {
      await FirebaseFirestore.instance.collection('Utilisateur')
          .doc(uid)
          .get()
          .then((snapshot) async {
        if (snapshot.exists) {
          nom = snapshot.data()!['nom'];
          prenom = snapshot.data()!['prenom'];
          listNomPrenom.add(nom);
          listNomPrenom.add(prenom);
        } else { // end snapshot exist
          throw Exception("Utilisateur does not exist.");
        }
      });
    } catch (e) {
      throw Exception("Failed to get utilisateur.");
    }
    return listNomPrenom;
  }
  Future<String> getEmail(String uid)async {
    String email = '' ;
    try {
      await FirebaseFirestore.instance.collection('Utilisateur')
          .doc(uid)
          .get()
          .then((snapshot) async {
        if (snapshot.exists) {
          email = snapshot.data()!['email'];
        } else { // end snapshot exist
          throw Exception("Utilisateur does not exist.");
        }
      });
    } catch (e) {
      throw Exception("Failed to get utilisateur.");
    }
    return email;
  }
  /// *******************************************************************************************************
  Future <List<String>> getVilleDepartVilleArrive(String uid, String idTrajet)async {
    List<String> villeDepartArrive = [];
    String villeDepart = '';
    String villeArrive = '';
    await FirebaseFirestore.instance
        .collection('Utilisateur')
        .doc(uid)
        .collection('trajetsLances')
        .doc(idTrajet)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        villeDepart = snapshot.data()!['villeDepart'];
        villeArrive = snapshot.data()!['villeArrivee'];
        villeDepartArrive.add(villeDepart);
        villeDepartArrive.add(villeArrive);
      }else print('ce trajet n\'exist pas');
    });
    return villeDepartArrive;
  }

  Future<Utilisateur> getUser(String uid)async {
    Utilisateur utilisateur = creerUtilisateurVide();
    try {
      await FirebaseFirestore.instance.collection('Utilisateur')
          .doc(uid)
          .get()
          .then((snapshot) async {
        if (snapshot.exists) {
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
            utilisateur.imageUrl = snapshot.data()!['imageUrl'];
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

  Future<List<Notifications>> getNotifications(String uid) async {
    await FirebaseFirestore.instance
        .collection('Utilisateur')
        .doc(uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        List<Notifications> listeNotifications = [];
          List<dynamic> notificationsData = snapshot.data()!['notifications'];
          for (var notificationData in notificationsData) {
            Notifications notification = Notifications(
              notificationData['id_conducteur'],
              notificationData['id_pasagers'],
              notificationData['id_trajetLance'],
              notificationData['id_trajetReserve'],
              notificationData['nom'],
              notificationData['prenom'],
              notificationData['villeDepart'],
              notificationData['villeArrive'],
              notificationData['accepte_refuse'],
            );
            if(notification.id_conducteur!=uid){
              listeNotifications.add(notification);
            }
          }
          return listeNotifications;
      }
    });
    return [];
  }

  Future<Trajet> getTrajet(String id_conducteur, String id_trajetLance) async{
    Trajet trajetLance = creerTrajetVide();
    await FirebaseFirestore.instance
        .collection('Utilisateur')
        .doc(id_conducteur)
        .collection('trajetsLances')
        .doc(id_trajetLance)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        trajetLance.dateDepart = snapshot.data()!['dateDepart'].toDate();
        trajetLance.tempsDePause = snapshot.data()!['tempsDePause'].toDate();//.add(Duration(hours: 1))
        trajetLance.coutTrajet = snapshot.data()!['coutTrajet'] as double;
        trajetLance.villeDepart = snapshot.data()!['villeDepart'];
        trajetLance.villeArrivee = snapshot.data()!['villeArrivee'];
        trajetLance.villeIntermediaires = List<String>.from(snapshot.data()!['villeIntermediaires']);
        trajetLance.plusInformations = PlusInformations(
            snapshot.data()!['plusInformations']['fumeur'],
            snapshot.data()!['plusInformations']['bagage'],
            snapshot.data()!['plusInformations']['animaux'],
            snapshot.data()!['plusInformations']['nbPlaces']);
        /// ---------------------
        GeoPoint geoPointDepart = snapshot.data()!['latLngDepart'];
        GeoPoint geoPointArrivee = snapshot.data()!['latLngArrivee'];
        LatLng latLngDepart = LatLng(geoPointDepart.latitude, geoPointDepart.longitude);
        LatLng latLngArrivee = LatLng(geoPointArrivee.latitude, geoPointArrivee.longitude);
        trajetLance.latLngDepart = latLngDepart;
        trajetLance.latLngArrivee = latLngArrivee;
      }
    });
    return trajetLance;
  }

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

  Future<String> getFcmTocken(String uid) async{
    String fcmTocken = '' ;
    await FirebaseFirestore.instance
        .collection('Utilisateur')
        .doc(uid)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        fcmTocken = snapshot.data()!['fcmTocken'];
        return fcmTocken ;
      }
    });
    return fcmTocken ;
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
  bool validerInfoVehicule(String vehicule) {
    RegExp alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');
    return alphanumeric.hasMatch(vehicule);
  }

  /// *********************************************************************************************************

  Future<List<ConducteurTrajet>> chercherConductuersPossibles(String uid , Trajet trajetReserve) async {
    trajetReserve.afficher();
    DateTime TempsPmoins15 = trajetReserve.dateDepart.subtract(Duration(minutes: 30));
    DateTime TempsPplus4h = trajetReserve.dateDepart.add(Duration(hours: 4));
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
          for (QueryDocumentSnapshot trajetLanceDoc in trajetsSnapshot.docs) {
            Map<String, dynamic> data = trajetLanceDoc.data() as Map<String, dynamic>;
            DateTime t1 = data['dateDepart'].toDate();
            GeoPoint geoPointDepart = data['latLngDepart'];
            GeoPoint geoPointArrivee = data['latLngArrivee'];
            LatLng latLngDepartLance = LatLng(geoPointDepart.latitude, geoPointDepart.longitude);
            LatLng latLngArriveLance = LatLng(geoPointArrivee.latitude, geoPointArrivee.longitude);
            double distanceD = Geolocator.distanceBetween(latLngDepartLance.latitude, latLngDepartLance.longitude, trajetReserve.latLngDepart.latitude, trajetReserve.latLngDepart.longitude)/1000 ;
            double distanceA = Geolocator.distanceBetween(latLngArriveLance.latitude, latLngArriveLance.longitude, trajetReserve.latLngArrivee.latitude, trajetReserve.latLngArrivee.longitude)/1000 ;
            //t1 = t1.add(Duration(hours: 1));
            bool pD = await isPlaceOnRoute(trajetReserve.lieuDepart!, trajetReserve.latLngDepart, latLngDepartLance, latLngArriveLance);
            bool pA = await isPlaceOnRoute(trajetReserve.lieuArrivee!, trajetReserve.latLngDepart, latLngDepartLance, latLngArriveLance);
            print('**************************************************************************************');
            print('**************************************************************************************');
            print('t1 = $t1');
            print('TempsPmoins15 = $TempsPmoins15');
            print('TempsPplus4h = $TempsPplus4h');
            print( ( t1.isAfter(TempsPmoins15) || t1.isAtSameMomentAs(TempsPmoins15) ) && ( t1.isBefore(TempsPplus4h) || t1.isAtSameMomentAs(TempsPplus4h)));
            print('**************************************************************************************');
            print('**************************************************************************************');
            if (
            /* 1) nbPlaces */
            data['plusInformations']['nbPlaces'] >= trajetReserve.plusInformations.nbPlaces
            /* 2) temps de depart */
            && ( t1.isAfter(TempsPmoins15) || t1.isAtSameMomentAs(TempsPmoins15) )
            && ( t1.isBefore(TempsPplus4h) || t1.isAtSameMomentAs(TempsPplus4h) )
            /* 3) les villes **/
            &&
                (   (   /*a) si les villes ont le meme nom ou appartient au villes intermedieres (autoComplete) */
                     ( (trajetReserve.villeDepart == data['villeDepart'])
                      && (trajetReserve.villeArrivee == data['villeArrivee']) )

                     || /*b)  */
                      ( (trajetReserve.villeDepart == data['villeDepart'])
                        && (  distanceA <=2.1 )
                      )
                     || /*c)*/
                      distanceA <=2.1 && distanceD <=2.1
                     || /*d) */
                      distanceD <=2.1 && (trajetReserve.villeArrivee == data['villeArrivee'])
                     /* e) inclus dans d */

                  )
                    ||
                    List<String>.from(data['villeIntermediaires']).contains(trajetReserve.villeArrivee)
                    || List<String>.from(data['villeIntermediaires']).contains(trajetReserve.villeDepart)
                    || pD && distanceA <=2.1 /// ---1)
                    || pA && distanceD <=2.1 /// ---2)
                    || pD && pA /// ----------------3)
                    /** 1)  si place depart de passager appartient au rue du conductuer et ils ont le meme arrive
                        2)  si place arrivee de passager appartient au rue du conductuer et ils ont le meme depart
                        3)  si place depart et place arrivee appartient du passager au rue du conductuer **/
                )
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
                    notificationData['id_trajetLance'],
                    notificationData['id_trajetReserve'],
                    notificationData['nom'],
                    notificationData['prenom'],
                    notificationData['villeDepart'],
                    notificationData['villeArrive'],
                    notificationData['accepte_refuse'],
                  );
                  utilisateur.notifications.add(notification);
                }
                utilisateur.imageUrl = dataUtilisateur['imageUrl'];
                utilisateur.fcmTocken = dataUtilisateur['fcmTocken'];
                utilisateur.afficher();
                trajetLance.id = data['id'];
                trajetLance.dateDepart = data['dateDepart'].toDate(); //.add(Duration(hours: 1))
                trajetLance.tempsDePause = data['tempsDePause'].toDate();
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
                GeoPoint geoPointDepart = data['latLngDepart'];
                GeoPoint geoPointArrivee = data['latLngArrivee'];
                LatLng latLngDepart = LatLng(geoPointDepart.latitude, geoPointDepart.longitude);
                LatLng latLngArrivee = LatLng(geoPointArrivee.latitude, geoPointArrivee.longitude);
                trajetLance.latLngDepart = latLngDepart;
                trajetLance.latLngArrivee = latLngArrivee;
                trajetLance.idConductuer = data['idConductuer'];
                trajetLance.idPassagers = List<String>.from(data['idPassagers']);
                trajetLance.afficher();
                ConducteurTrajet conducteurTrajet = ConducteurTrajet(utilisateur, trajetLance);
                listConducteurTrajet.add(conducteurTrajet);
              }else { print('Les conditions ne sont pas verifier pour ${dataUtilisateur['nom']}');
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
  /// *********************************************** Autres **************************************************

  Future<bool> isPlaceOnRoute(PlacesAutoCompleteResult place,LatLng latLngPlace, LatLng depart, LatLng arrive) async {
    // Get the route polyline between the two points
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyC9sGlH43GL0Jer73n9ETKsxNpZqvrWn-k",
        PointLatLng(depart.latitude, depart.longitude),
        PointLatLng(arrive.latitude, arrive.longitude));
    // Convert the polyline points to LatLng coordinates
    List<LatLng> polylineCoordinates = [];
    for (var element in result.points) {
      polylineCoordinates.add(LatLng(element.latitude, element.longitude));
    }
    // Check if the place is within a certain distance of any point on the polyline
    for (var coordinate in polylineCoordinates) {
      double distance = await Geolocator.distanceBetween(
        latLngPlace.latitude,
        latLngPlace.longitude,
        coordinate.latitude,
        coordinate.longitude,
      );
      if (distance <= 2000) { // adjust the distance threshold as needed
        return true;
      }
    }
    return false;
  }
  /// --------------------------------------------------------------------------------------------------

  String alternerChaines(String chaine1, String chaine2) {
    StringBuffer resultat = StringBuffer();
    int longueurMin = chaine1.length < chaine2.length ? chaine1.length : chaine2.length;
    for (int i = 0; i < longueurMin; i+=2) {
      if (i+1>=chaine1.length || i+1>=chaine2.length) break;
      resultat.write(chaine1[i]);
      resultat.write(chaine2[i+1]);
    }
    if (chaine1.length > chaine2.length) {
      resultat.write(chaine1.substring(longueurMin));
    } else if (chaine2.length > chaine1.length) {
      resultat.write(chaine2.substring(longueurMin));
    }
    return resultat.toString();
  }
  String tranlsateToFrensh(bool info){
    if (info) return 'Oui'; else return 'Non';
  }
  String moisAuChaine(int mois){
    switch (mois){
      case 1 : return 'Janvier';
      case 2 : return 'février';
      case 3 : return 'Mars';
      case 4 : return 'Avril';
      case 5 : return 'juin';
      case 6 : return 'Juillet';
      case 8 : return 'Août';
      case 9 : return 'Septembre';
      case 10 : return 'Octobre';
      case 11 : return 'Novembre';
      case 12 : return 'Décembre';
    }
    return 'Mois inconnu';
  }
  String reglerTemps(int temps){
    if (temps<=9 && temps >=0){
      return ('0'+temps.toString());
    }else return temps.toString();
  }
  /// *******************************************************************************************************
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