import 'package:appcouvoiturage/AppClasses/Utilisateur.dart';
import 'package:appcouvoiturage/Services/auth.dart';
import 'package:appcouvoiturage/pages/Historique.dart';
import 'package:appcouvoiturage/pages/Password.dart';
import 'package:appcouvoiturage/pages/connexion.dart';
import 'package:appcouvoiturage/pages/profilmodification.dart';
import 'package:appcouvoiturage/widgets/profilwidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:places_service/places_service.dart';

import '../AppClasses/Evaluation.dart';
import '../AppClasses/Notifications.dart';
import '../AppClasses/PlusInformations.dart';
import '../AppClasses/Trajet.dart';
import '../AppClasses/Vehicule.dart';
import '../Services/base de donnee.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({Key? key}) : super(key: key);
  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet=false;
  final AuthService _auth = AuthService();
  late Utilisateur _utilisateur;
  Future _getDataFromDataBase() async {
    _utilisateur = BaseDeDonnee().creerUtilisateurVide();
    try {
      await FirebaseFirestore.instance
          .collection('Utilisateur')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((snapshot) async {
        if (snapshot.exists) {
          setState(() {
            _utilisateur.identifiant = snapshot.data()!['identifiant'];
            _utilisateur.nom = snapshot.data()!['nom'];
            _utilisateur.prenom = snapshot.data()!['prenom'];
            _utilisateur.email = snapshot.data()!['email'];
            _utilisateur.numeroTelephone = snapshot.data()!['numeroTelephone'];
            _utilisateur.evaluation = Evaluation(
              List<String>.from(snapshot.data()!['evaluation']['feedback']),
              snapshot.data()!['evaluation']['etoiles'],
              snapshot.data()!['evaluation']['nbSignalement'],
            );
            _utilisateur.vehicule = Vehicule(
              snapshot.data()!['vehicule']['marque'],
              snapshot.data()!['vehicule']['typevehicule'],
              snapshot.data()!['vehicule']['matricule'],
              snapshot.data()!['vehicule']['modele'],
              snapshot.data()!['vehicule']['policeAssurance'],
            );
            _utilisateur.statut = snapshot.data()!['statut'];
            List<dynamic> notificationsData = snapshot.data()!['notifications'];
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
              _utilisateur.notifications.add(notification);
            }
            //tests by printing
          }); // end setState
        } else {
          // end snapshot exist
          throw Exception("Utilisateur does not exist.");
        }
      });
    } catch (e) {
      throw Exception("Failed to get utilisateur.");
    }
  }
  Future _getHistorique() async {
    QuerySnapshot trajetsSnapshot = await FirebaseFirestore.instance
        .collection('Utilisateur')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Historique')
        .get();
    if (trajetsSnapshot.docs.isNotEmpty) {
      print("Le trajet Existe");
      for (QueryDocumentSnapshot trajetDoc in trajetsSnapshot.docs) {
        Map<String, dynamic> data = trajetDoc.data() as Map<String, dynamic>;
        Trajet historique = BaseDeDonnee().creerTrajetVide();
        historique.dateDepart = data['dateDepart'].toDate().add(Duration(hours: 1));
        historique.tempsDePause = data['tempsDePause'].toDate().add(Duration(hours: 1));
        historique.coutTrajet = data['coutTrajet'] as double;
        historique.villeDepart = data['villeDepart'];
        historique.villeArrivee = data['villeArrivee'];
        historique.lieuDepart = PlacesAutoCompleteResult(
          placeId: data['lieuDepart']['placeId'],
          description: data['lieuDepart']['description'],
          secondaryText: data['lieuDepart']['secondaryText'],
          mainText: data['lieuDepart']['mainText'],
        );
        historique.lieuArrivee = PlacesAutoCompleteResult(
          placeId: data['lieuArrivee']['placeId'],
          description: data['lieuArrivee']['description'],
          secondaryText: data['lieuArrivee']['secondaryText'],
          mainText: data['lieuArrivee']['mainText'],
        );
        historique.villeIntermediaires = List<String>.from(data['villeIntermediaires']);
        historique.plusInformations = PlusInformations(
            data['plusInformations']['fumeur'],
            data['plusInformations']['bagage'],
            data['plusInformations']['animaux'],
            data['plusInformations']['nbPlaces']);
        historique.trajetEstValide = data['trajetEstValide'];
        historique.confort = data['confort'];
        historique.avis = data['avis'];
        historique.probleme = data['probleme'];
        setState(() {
        _utilisateur.Historique.add(historique);
        });
      }
    }
  }
  @override
  void initState() {
    super.initState();
    _getDataFromDataBase();
    _getHistorique();
    getConnectivity();
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
              (ConnectivityResult result) async{
            isDeviceConnected = await InternetConnectionChecker().hasConnection;
            if(!isDeviceConnected && isAlertSet == false){
              showDialogBox();
              setState(() {
                isAlertSet = true;
              });
            }
          }
      );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(screenWidth * 0.03),
            child: Column(
              children: [
                Column(
                  children: [
                    Text("Profil",
                        style: TextStyle(
                            color: Color(0xff344d59),
                            fontSize: screenHeight * 0.038)),
                    SizedBox(
                        width: screenHeight * 0.15,
                        height: screenHeight * 0.15,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: const Image(
                              image: NetworkImage(
                                  'https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1031&q=80'),
                            ))),
                  ],
                ),
                SizedBox(height: screenHeight * 0.015),
                Text("${_utilisateur.nom} ${_utilisateur.prenom}",
                    style: Theme.of(context).textTheme.headlineSmall),
                RatingWidget(
                    color: Colors.yellow,
                    rating: _utilisateur.evaluation.etoiles.toDouble(),
                    size: screenWidth * 0.05),
                SizedBox(height: screenHeight * 0.005),
                Text(_utilisateur.email, style: Theme.of(context).textTheme.bodyMedium),
                SizedBox(height: screenHeight * 0.02),
                SizedBox(
                    width: screenWidth * 0.5,
                    child: GestureDetector(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ModifierProfilePage(_utilisateur),
                              ));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text('Modifier Profile',
                            style: TextStyle(color: Colors.white,fontFamily: 'Poppins')),
                      ),
                    )),
                SizedBox(height: screenHeight * 0.04),
                const Divider(),
                SizedBox(height: screenHeight * 0.01),

                //  Menu
                Profilewidget(
                  title: 'Mes Courses',
                  icon: Icons.navigation_rounded,
                  onPress: () {
                    _utilisateur.afficher();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Historique(_utilisateur),));
                  },
                ),
                SizedBox(height: screenHeight * 0.008),
                Profilewidget(
                  title: 'Mot de passe',
                  icon: Icons.key_outlined,
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MotdePasse(),
                        ));
                  },
                ),
                SizedBox(height: screenHeight * 0.008),
                Profilewidget(
                  title: 'Déconnexion',
                  icon: Icons.logout,
                  onPress: () async {
                    await _auth.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Connexin()),
                    );
                  },
                  endIcon: false,
                  textColor: Colors.redAccent,
                ),
              ],
            ),
          ),
        ));
  }
  showDialogBox()=> showCupertinoDialog<String>(
      context: context,
      builder:(BuildContext context) =>CupertinoAlertDialog(
        title: const Text('Erreur de connexion'),
        content: const Text('Vérifier votre connexion internet'),
        actions: <Widget>[
          TextButton(
            onPressed: () async{
              Navigator.pop(context , 'cancel');
              setState(() {
                isAlertSet =false;
              });
              isDeviceConnected = await InternetConnectionChecker().hasConnection;
              if(!isDeviceConnected){
                showDialogBox();
                setState(() {
                  isAlertSet =true;
                });
              }
            },
            child: const Text('OK'),
          )
        ],
      )
  );
}

class RatingWidget extends StatelessWidget {
  final double rating;
  final Color color;
  final double size;

  const RatingWidget(
      {super.key,
      this.rating = 0.0,
      this.color = Colors.amber,
      this.size = 24.0});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) => Icon(
          index < rating.floor() ? Icons.star : Icons.star_border,
          size: size,
          color: color,
        ),
      ),
    );
  }
}
