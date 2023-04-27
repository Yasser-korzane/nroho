import 'package:appcouvoiturage/pages/trajetdemandepassager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../AppClasses/Notifications.dart';

class Demande {
  final String firstName;
  final String lastName;
  final String placeDepar;

  final String placeArrive;

  final String phone;

  Demande(
      {required this.firstName,
      required this.lastName,
      required this.placeDepar,
      required this.placeArrive,
      required this.phone});
}

class DemandesPassager extends StatefulWidget {
  @override
  State<DemandesPassager> createState() => _DemandesPassagerState();
}

class _DemandesPassagerState extends State<DemandesPassager> {
  List<Notifications> listeNotifications = [];

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
            listeNotifications.add(notification);
            print(listeNotifications);
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

  final List<Demande> Demandes = [
    Demande(
        firstName: 'yasser',
        lastName: 'korzane',
        placeDepar: 'Maoklane - Setif',
        placeArrive: 'OuedSmar - Alger',
        phone: '+213665300362'),
    Demande(
        firstName: 'yasser',
        lastName: 'korzane',
        placeDepar: 'Maoklane - Setif',
        placeArrive: 'OuedSmar - Alger',
        phone: '+213665300362'),
    Demande(
        firstName: 'yasser',
        lastName: 'korzane',
        placeDepar: 'Maoklane - Setif',
        placeArrive: 'OuedSmar - Alger',
        phone: '+213665300362'),
    Demande(
        firstName: 'yasser',
        lastName: 'korzane',
        placeDepar: 'Maoklane - Setif',
        placeArrive: 'OuedSmar - Alger',
        phone: '+213665300362'),
    Demande(
        firstName: 'yasser',
        lastName: 'korzane',
        placeDepar: 'Maoklane - Setif',
        placeArrive: 'OuedSmar - Alger',
        phone: '+213665300362'),
    Demande(
        firstName: 'yasser',
        lastName: 'korzane',
        placeDepar: 'Maoklane - Setif',
        placeArrive: 'OuedSmar - Alger',
        phone: '+213665300362'),
  ];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final double defaultPadding = 10;
    return listeNotifications.isEmpty
        ? Scaffold(
            backgroundColor: Colors.grey.shade300,
            body: Center(
                child: Text(
              "pas de notifications maintenant",
              style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
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
                                      'id Conducteur : ${demande.id_conducteur}',
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
                                          'De : idPassager : ${demande.id_pasagers}',
                                          style:
                                              TextStyle(fontFamily: 'Poppins'),
                                        ),
                                        Text(
                                          'A : idTrajet : ${demande.id_trajet}',
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
                                  onTap: () {},
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
                                                  onTap: () {},
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
                                  onTap: () {},
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
                                              // Add your logic here to navigate back to the previous page
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
                                                  onTap: () {},
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
