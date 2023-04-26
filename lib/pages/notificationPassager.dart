import 'package:appcouvoiturage/pages/trajetdemandepassager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../AppClasses/Notifications.dart';

class DemandeResutlat {
  final String firstName;
  final String lastName;
  final String placeDepar;

  final String placeArrive;

  final bool accept;

  DemandeResutlat(
      {required this.firstName,
        required this.lastName,
        required this.placeDepar,
        required this.placeArrive,
        required this.accept});
}

class DemandesPassagerResultat extends StatefulWidget {
  @override
  State<DemandesPassagerResultat> createState() => _DemandesPassagerResultatState();
}

class _DemandesPassagerResultatState extends State<DemandesPassagerResultat> {

  final List<DemandeResutlat> Demandes = [
    DemandeResutlat(
        firstName: 'yasser',
        lastName: 'korzane',
        placeDepar: 'Maoklane - Setif',
        placeArrive: 'OuedSmar - Alger',
        accept: false),
    DemandeResutlat(
        firstName: 'yasser',
        lastName: 'korzane',
        placeDepar: 'Maoklane - Setif',
        placeArrive: 'OuedSmar - Alger',
        accept: true),
    DemandeResutlat(
        firstName: 'yasser',
        lastName: 'korzane',
        placeDepar: 'Maoklane - Setif',
        placeArrive: 'OuedSmar - Alger',
        accept: false),
    DemandeResutlat(
        firstName: 'yasser',
        lastName: 'korzane',
        placeDepar: 'Maoklane - Setif',
        placeArrive: 'OuedSmar - Alger',
        accept: true),
    DemandeResutlat(
        firstName: 'yasser',
        lastName: 'korzane',
        placeDepar: 'Maoklane - Setif',
        placeArrive: 'OuedSmar - Alger',
        accept: false),
    DemandeResutlat(
        firstName: 'yasser',
        lastName: 'korzane',
        placeDepar: 'Maoklane - Setif',
        placeArrive: 'OuedSmar - Alger',
        accept: true),
  ];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final double defaultPadding = 10;
    return Demandes.isEmpty
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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.cancel_outlined) ,
          onPressed:(){
            Navigator.pop(context);
          } ,
        ),
        title:  Text(
          'Les resultats de demandes',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontFamily: 'Poppins' ,
              color: Colors.black,
              fontSize: screenWidth * 0.05,
              // responsive font size
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey.shade300,
      ),

      backgroundColor: Colors.grey.shade300,
      body: ListView.builder(
        itemCount: Demandes.length,
        itemBuilder: (context, index) {
          final demande = Demandes[index];
          return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.035,
                  vertical: screenHeight * 0.015),
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
                              demande.firstName+' '+demande.lastName,
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
                                  'De : '+demande.placeDepar,
                                  style:
                                  TextStyle(fontFamily: 'Poppins'),
                                ),
                                Text(
                                  'A : '+demande.placeArrive,
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
                           padding:
                            EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Status :  ',style: TextStyle(
                                fontFamily: 'Poppins',
                              ),),
                              Text(
                                demande.accept ? 'Acceptee' : 'Refuse', // Ternary operator to conditionally display text
                                style: TextStyle(
                                  color: demande.accept ? Colors.green : Colors.red, // Ternary operator to conditionally set text color
                                  fontSize: 16.0, // Replace with your own font size
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                      ]))));
        },
      ),
    );
  }
}
