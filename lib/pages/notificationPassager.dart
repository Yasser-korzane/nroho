import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../AppClasses/Notifications.dart';

class DemandesPassagerResultat extends StatefulWidget {
  @override
  State<DemandesPassagerResultat> createState() => _DemandesPassagerResultatState();
}

class _DemandesPassagerResultatState extends State<DemandesPassagerResultat> {
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
            if(notification.id_conducteur!=FirebaseAuth.instance.currentUser!.uid){
              listeNotifications.add(notification);
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
    Notifications notifications = Notifications('id_conducteur', 'id_pasagers', 'id_trajet', 'Grine', 'Mohammed', 'Bab El Zouar', 'Beau Lieu', true);
    listeNotifications.add(notifications);
    return listeNotifications.isEmpty
        ? Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.cancel_outlined) ,
            onPressed:(){
              Navigator.pop(context);
            } ,
          ),
          title:  Text(
            'Resultats des demandes',
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
        body: Center(
            child: Text(
              "Aucune notification pour l'instant",
              style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),
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
          'Resultats des demandes',
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
        itemCount: listeNotifications.length,
        itemBuilder: (context, index) {
          final demande = listeNotifications[index];
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
                              '${demande.nom} ${demande.prenom}',
                              style: TextStyle(fontFamily: 'Poppins'),
                            ),
                            /*leading: Container(
                              height: screenHeight * 0.06,
                              width: screenHeight * 0.06,
                              child: CircleAvatar(
                                //backGrounndImage: AssetImage('your image path'),
                                backgroundImage: AssetImage(
                                  'asset/images/profile.png',
                                ),
                                radius: 50,
                              ),
                            ),*/
                            subtitle: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'De : '+demande.villeDepart,
                                  style:
                                  TextStyle(fontFamily: 'Poppins'),
                                ),
                                Text(
                                  'A : '+demande.villeArrive,
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
                                demande.accepte_refuse ? 'Acceptée' : 'Refusée', // Ternary operator to conditionally display text
                                style: TextStyle(
                                  color: demande.accepte_refuse ? Colors.green : Colors.red, // Ternary operator to conditionally set text color
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

