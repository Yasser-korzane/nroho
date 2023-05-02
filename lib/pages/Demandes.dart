import 'package:appcouvoiturage/pages/trajetdemandepassager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../AppClasses/Notifications.dart';
import 'package:appcouvoiturage/Services/base de donnee.dart';

import '../Services/localNotification.dart';

/**
    Je doit afficher pour le conducteur :
      -Le nom et prenom du passager
      - ville depart et ville arrivee
      - Le commentaire
 **/


class DemandesPassager extends StatefulWidget {
  @override
  State<DemandesPassager> createState() => _DemandesPassagerState();
}

class _DemandesPassagerState extends State<DemandesPassager> {
  List<Notifications> listeNotifications = [];
  BaseDeDonnee baseDeDonnee=new BaseDeDonnee();
  Future _getNotifications() async {
    await FirebaseFirestore.instance
        .collection('Utilisateur')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
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
            if(notification.id_conducteur==FirebaseAuth.instance.currentUser!.uid){
              listeNotifications.add(notification);
              print(listeNotifications);
            }
          }
        });
      }
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getNotifications();
  }
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final double defaultPadding = 10;
    Notifications notifications = Notifications('id_conducteur', 'id_pasagers', 'id_trajet', 'Grine', 'Mohammed', 'Bab El Zouar', 'Beau Lieu', true);
    //listeNotifications.add(notifications);
    return listeNotifications.isEmpty
        ? Scaffold(
            backgroundColor: Colors.grey.shade300,
            body: Center(
                child: Text(
              "Pas de notifications maintenant",
              style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),
            )))
        : Scaffold(
            backgroundColor: Colors.grey.shade300,
            body: ListView.builder(
              itemCount: listeNotifications.length,
              itemBuilder: (context, index) {
                final demande = listeNotifications[index];
                return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.035,
                        vertical: screenHeight * 0.015),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Detailspassaer(
                                  photoUrl: 'assets/images/user-profile.png',
                                  fullName: ' weal bougessa',
                                  rating: 2,
                                  phoneNumber: '0665996688',
                                  email: 'bougessa.hrach@esi.dz',
                                  carName: 'car_pooling'),
                            ));
                      },
                      child: Card(
                          color: Colors.white,
                          elevation: 8,
                          margin: EdgeInsets.symmetric(
                              horizontal: screenHeight * 0.01,
                              vertical: screenWidth * 0.001),
                          borderOnForeground: true,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Padding(
                              padding: EdgeInsets.all(screenWidth * 0.02),
                              child: Column(children: [
                                Padding(
                                  padding: EdgeInsets.all(screenWidth * 0.01),
                                  child: ListTile(
                                    title: Text(
                                      '${demande.nom} ${demande.prenom}',
                                      style: TextStyle(fontFamily: 'Poppins'),
                                    ),
                                    leading: Container(
                                      height: screenHeight * 0.06,
                                      width: screenHeight * 0.06,
                                      child: CircleAvatar(
                                        //backGrounndImage: AssetImage('your image path'),
                                        backgroundImage: AssetImage(
                                          'asset/images/profile.png',
                                        ),
                                        radius: 50,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Ville départ : ${demande.villeDepart}',
                                          style:
                                              TextStyle(fontFamily: 'Poppins'),
                                        ),
                                        Text(
                                          'Ville arrivée : ${demande.villeArrive}',
                                          style:
                                              TextStyle(fontFamily: 'Poppins'),
                                        ),
                                      ],
                                    ),
                                    isThreeLine: true,
                                    dense: true,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10),
                                  child: OutlinedButton(
                                    onPressed: () {
                                      launchUrlString(
                                          "tel:+213 65498325"); // Handle button press
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          side: BorderSide(color: Colors.blue),
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.blue),
                                    ),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.all(defaultPadding * 0.01),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.phone_in_talk_outlined,
                                            color: Colors.blue,
                                          ),
                                          SizedBox(width: defaultPadding * 0.5),
                                          Text(
                                            '+213 65498325',
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Poppins'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.005),
                                GestureDetector(
                                  onTap: () {
                                    print("hichem");
                                    baseDeDonnee.ajouterNotification("pKxumk4XaoUi9ou1WuesRd6Bzs33",Notifications("N4sMJH5Un6aqWNuwGaTnQ34cPqt1","id_passager","id_trajet","Boulacheb","Hichem","Alger","el Aziziya",true));
                                    LocalNotification.initialize();
                                    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
                                      LocalNotification.showNotification(message);
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.02),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFD2FCC4),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: screenWidth * 0.01,
                                        ),
                                        InkWell(
                                            onTap: () {
                                              // Add your logic here to navigate back to the previous page
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xFF09CA3F),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        screenWidth * 0.01,
                                                    vertical:
                                                        screenHeight * 0.005),
                                                child: InkWell(
                                                  onTap: () {
                                                    print("khaled");
                                                  },
                                                  child: Icon(
                                                    Icons.check_outlined,
                                                    color: Colors.white,
                                                    size: screenWidth *
                                                        0.04, // responsive icon size
                                                  ),
                                                ),
                                              ),
                                            )),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: screenWidth * 0.05,
                                              vertical: screenHeight * 0.005),
                                          child: Text(
                                            'Accepter le passager',
                                            style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Color(0xff09CA3F),
                                                fontSize: screenWidth * 0.04,
                                                // responsive font size
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                GestureDetector(
                                  onTap: () {
                                    baseDeDonnee.ajouterNotification("pKxumk4XaoUi9ou1WuesRd6Bzs33",Notifications("N4sMJH5Un6aqWNuwGaTnQ34cPqt1","id_passager","id_trajet","Boulacheb","Hichem","Alger","el Aziziya",false));
                                    LocalNotification.initialize();
                                    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
                                      LocalNotification.showNotification(message);
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.02),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFF8484),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: screenWidth * 0.01,
                                        ),
                                        InkWell(
                                            onTap: () {
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xFFFA0000),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        screenWidth * 0.01,
                                                    vertical:
                                                        screenHeight * 0.005),
                                                child: InkWell(
                                                  onTap: () {
                                                  },
                                                  child: Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                    size: screenWidth *
                                                        0.04, // responsive icon size
                                                  ),
                                                ),
                                              ),
                                            )),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: screenWidth * 0.05,
                                              vertical: screenHeight * 0.005),
                                          child: Text(
                                            'Refuser le passager',
                                            style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Color(0xffFC0707),
                                                fontSize: screenWidth * 0.04,
                                                // responsive font size
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.01),
                              ]))),
                    ));
              },
            ),
          );
  }
}
