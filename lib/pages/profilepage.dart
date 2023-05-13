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
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
import 'package:animations/animations.dart';

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
            _utilisateur.imageUrl = snapshot.data()!['imageUrl'];
            _utilisateur.fcmTocken = snapshot.data()!['fcmTocken'];
            if (_utilisateur.imageUrl.isEmpty) _utilisateur.imageUrl = 'https://www.pngkey.com/png/full/115-1150152_default-profile-picture-avatar-png-green.png';
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
      for (QueryDocumentSnapshot trajetDoc in trajetsSnapshot.docs) {
        Map<String, dynamic> data = trajetDoc.data() as Map<String, dynamic>;
        Trajet historique = BaseDeDonnee().creerTrajetVide();
        historique.id = data['id'] ;
        historique.dateDepart = data['dateDepart'].toDate();
        historique.tempsDePause = data['tempsDePause'].toDate();
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
        /// ---------------------
        GeoPoint geoPointDepart = data['latLngDepart'];
        GeoPoint geoPointArrivee = data['latLngArrivee'];
        LatLng latLngDepart = LatLng(geoPointDepart.latitude, geoPointDepart.longitude);
        LatLng latLngArrivee = LatLng(geoPointArrivee.latitude, geoPointArrivee.longitude);
        historique.latLngDepart = latLngDepart;
        historique.latLngArrivee = latLngArrivee;
        historique.idConductuer = data['idConductuer'];
        historique.idPassagers = List<String>.from(data['idPassagers']);
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
  }

  @override
  void dispose() {
    StreamController<int> myStreamController = StreamController<int>();
    Stream<int> myStream = myStreamController.stream;
    subscription = myStream.listen((data) {
      // Do something with the data
    });
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
                            fontFamily: 'Poppins',
                            color: Color(0xff344d59),
                            fontSize: screenHeight * 0.038)),
                    SizedBox(
                        width: screenHeight * 0.15,
                        height: screenHeight * 0.15,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(_utilisateur.imageUrl),
                        ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.015),
                Text("${_utilisateur.nom} ${_utilisateur.prenom}",
                    style: TextStyle(fontFamily: 'Poppins',fontSize: 24)),
                RatingWidget(
                    color: Colors.yellow,
                    rating: _utilisateur.evaluation.etoiles.toDouble(),
                    size: screenWidth * 0.05),
                SizedBox(height: screenHeight * 0.005),
                Text(_utilisateur.email,style: TextStyle(fontFamily: 'Poppins',fontSize: 15)),
                SizedBox(height: screenHeight * 0.02),
                SizedBox(
                    width: screenWidth * 0.5,
                    child: GestureDetector(
                      child: ElevatedButton(
                        onPressed: () {
                         /* Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ModifierProfilePage(_utilisateur),
                              ));
                              */
                              Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) => ModifierProfilePage(_utilisateur),
                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                        var begin = Offset(1.0, 0.0);
                                        var end = Offset.zero;
                                         var curve = Curves.ease;

                                         var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                    return SlideTransition(
                                      position: animation.drive(tween),
                                      child: child,
                                    );
                                   },
                                 ),
                              );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text('Modifier mon profil',
                            style: TextStyle(color: Colors.white,fontFamily: 'Poppins')),
                      ),
                    )),
                SizedBox(height: screenHeight * 0.04),
                const Divider(),
                SizedBox(height: screenHeight * 0.01),

                //  Menu
                Profilewidget(
                  title: 'Mes courses',
                  icon: Icons.navigation_rounded,
                  onPress: () {
                    _utilisateur.afficher();
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => Historique(_utilisateur,),));
                    Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) => Historique(_utilisateur),
                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                        var begin = Offset(1.0, 0.0);
                                        var end = Offset.zero;
                                         var curve = Curves.ease;

                                         var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                    return SlideTransition(
                                      position: animation.drive(tween),
                                      child: child,
                                    );
                                   },
                                 ),
                              );
                  },
                ),
                SizedBox(height: screenHeight * 0.008),
                Profilewidget(
                  title: 'Mot de passe',
                  icon: Icons.key_outlined,
                  onPress: () {
                   /* Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MotdePasse(),
                        ));*/
                        Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) => MotdePasse(),
                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                        var begin = Offset(1.0, 0.0);
                                        var end = Offset.zero;
                                         var curve = Curves.ease;

                                         var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                    return SlideTransition(
                                      position: animation.drive(tween),
                                      child: child,
                                    );
                                   },
                                 ),
                              );
                    
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
