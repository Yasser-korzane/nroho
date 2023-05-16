import 'package:appcouvoiturage/pages/home.dart';
import 'package:appcouvoiturage/pages/trajetdemandepassager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../AppClasses/Notifications.dart';
import 'package:appcouvoiturage/Services/base de donnee.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
              notificationData['id_trajetLance'],
              notificationData['id_trajetReserve'],
              notificationData['nom'],
              notificationData['prenom'],
              notificationData['villeDepart'],
              notificationData['villeArrive'],
              notificationData['accepte_refuse'],
            );
            if(notification.id_conducteur==FirebaseAuth.instance.currentUser!.uid){
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
    return listeNotifications.isEmpty
        ? Scaffold(
            backgroundColor: Colors.grey.shade300,
            body: Center(
                child: Text(
              "Vous n'avez aucune notification",
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
                      onTap: () async{
                        List<String> nomPrenom = [];
                        nomPrenom = await baseDeDonnee.getNomPrenom(FirebaseAuth.instance.currentUser!.uid);
                        List<String> villesDepartArrive = [] ;
                        villesDepartArrive = await baseDeDonnee.getVilleDepartVilleArrive(FirebaseAuth.instance.currentUser!.uid, demande.id_trajetLance);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Detailspassaer(demande.id_pasagers,demande.id_trajetLance,demande.id_trajetReserve,nomPrenom,villesDepartArrive)));
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
                                      style: TextStyle(fontFamily: 'Poppins',fontSize: 14),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Départ : ${demande.villeDepart}',

                                          style:
                                              TextStyle(fontFamily: 'Poppins',fontSize: 14),
                                        ),
                                        Text(
                                          'Arrivée : ${demande.villeArrive}',
                                          style:
                                              TextStyle(fontFamily: 'Poppins',fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    isThreeLine: true,
                                    dense: true,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.005),
                                GestureDetector(
                                  onTap: () async{
                                    List<String> nomPrenom = [];
                                    nomPrenom = await baseDeDonnee.getNomPrenom(FirebaseAuth.instance.currentUser!.uid);
                                    List<String> villesDepartArrive = [] ;
                                    villesDepartArrive = await baseDeDonnee.getVilleDepartVilleArrive(FirebaseAuth.instance.currentUser!.uid, demande.id_trajetLance);
                                    String fcmTockenPassager = await baseDeDonnee.getFcmTocken(demande.id_pasagers);
                                    await baseDeDonnee.ajouterNotification("${demande.id_pasagers}",Notifications("${demande.id_conducteur}","${demande.id_pasagers}","${demande.id_trajetLance}","${demande.id_trajetReserve}",nomPrenom[0],nomPrenom[1],villesDepartArrive[0],villesDepartArrive[1],true));
                                    /// 1) mettre trajetEstValide pour le conducteur (current user)
                                    /// 2) mettre trajetEstValide pour les deux le passager
                                    /// 3) decrementer nbPassager du trajetLance du conducteur
                                    /// 4) ajouter id du passager dans la liste des idPassagers du trajetLance du conducteur
                                    /// 5) ajouter id du conducteur dans idConducteur du trajetLance du conducteur
                                    /// 6) ajouter id du passager dans la liste des idPassagers du trajetReserve du passager
                                    /// 7) ajouter id du conducteur dans idConducteur du trajetReserve du passager
                                    /* 1) et 4) et 5) */ await baseDeDonnee.modifierTrajetLance(demande.id_trajetLance, demande.id_conducteur, demande.id_pasagers);
                                    /* 2) et 6) et 7) */ await baseDeDonnee.modifierTrajetReserve(demande.id_trajetReserve, demande.id_conducteur, demande.id_pasagers);
                                    /* 3) */ await baseDeDonnee.incrementerNbPlacesConducteur(demande.id_conducteur, demande.id_trajetLance);
                                    await sendNotification(fcmTockenPassager, "Nouvelle notification", "Un conducteur a accepté votre demande pour rejoindre son trajet");
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => home()),
                                          (Route<dynamic> route) => false,
                                    );
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
                                              Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => home()),
                                                    (Route<dynamic> route) => false,
                                              );
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
                                                        screenHeight * 0.007),
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => home()),
                                                          (Route<dynamic> route) => false,
                                                    );

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
                                          padding: EdgeInsets.all(10),
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
                                SizedBox(height: screenHeight * 0.015),
                                GestureDetector(
                                  onTap: () async{
                                    List<String> nomPrenom = [];
                                    nomPrenom = await baseDeDonnee.getNomPrenom(FirebaseAuth.instance.currentUser!.uid);
                                    List<String> villesDepartArrive = [] ;
                                    villesDepartArrive = await baseDeDonnee.getVilleDepartVilleArrive(FirebaseAuth.instance.currentUser!.uid, demande.id_trajetLance);
                                    String fcmTockenPassager = await baseDeDonnee.getFcmTocken(demande.id_pasagers);
                                    print('fcmTockenPassager : $fcmTockenPassager');
                                    await baseDeDonnee.ajouterNotification("${demande.id_pasagers}",Notifications("${demande.id_conducteur}","${demande.id_pasagers}","${demande.id_trajetLance}","${demande.id_trajetReserve}",nomPrenom[0],nomPrenom[1],villesDepartArrive[0],villesDepartArrive[1],false));
                                    await sendNotification(fcmTockenPassager, "Nouvelle notification", "Un conducteur a refusé votre demande pour rejoindre son trajet");
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => home()),
                                          (Route<dynamic> route) => false,
                                    );
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
                                              Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => home()),
                                                    (Route<dynamic> route) => false,
                                              );
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
                                                        screenHeight * 0.007),
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => home()),
                                                          (Route<dynamic> route) => false,
                                                    );
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
                                          padding: EdgeInsets.all(10),
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
Future<void> sendNotification(String fcmToken, String title, String body) async {
  // Envoyez une demande HTTP POST à Firebase Cloud Messaging pour envoyer la notification push
  final response = await http.post(
    Uri.parse('https://fcm.googleapis.com/fcm/send'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=AAAAP4EF2a0:APA91bEexLSapubrW8u_tYhI5ITWpV0OMhc9PWEUZ-D-0GTbb-EszQ12q1QG_qOG8sMsZ6zH6JpalT0Xzjq6fPxCAdQsEDiSTMoqN91rXcU8EHDZpBSb12NHqBDr0-PIagF4hlXgy999',
    },
    body: jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{
          'title': title,
          'body': body,
          'image': 'asset://assets/images/logo.png',
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        },
        'data':{
          'routes': '/home',
        },
        'to': fcmToken,
      },
    ),
  );

  // Vérifiez la réponse de la demande HTTP POST
  if (response.statusCode == 200) {
    print('Notification envoyée avec succès.');
  } else {
    print('Échec de l\'envoi de la notification. Code de réponse: ${response.statusCode} ${response.body}');
  }
}


