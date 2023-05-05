import 'package:appcouvoiturage/Services/base%20de%20donnee.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:appcouvoiturage/AppClasses/Notifications.dart';
import '../Services/localNotification.dart';
import 'AfficherTrajetSurLeMap.dart';

class Details extends StatelessWidget {
  ConducteurTrajet _conducteurTrajet ;
  Details(this._conducteurTrajet);
  @override
  Widget build(BuildContext context) {

    final Size screenSize = MediaQuery.of(context).size;

    BaseDeDonnee baseDeDonnee=new BaseDeDonnee();


    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    List plusInformations =
      ['Le conducteur fume : ${BaseDeDonnee().tranlsateToFrensh(_conducteurTrajet.trajetLance.plusInformations.fumeur)}',
      'Le conducteur accepte un bagage volumineux : ${BaseDeDonnee().tranlsateToFrensh(_conducteurTrajet.trajetLance.plusInformations.bagage)}',
      'Le conducteur accepte des animaux : ${BaseDeDonnee().tranlsateToFrensh(_conducteurTrajet.trajetLance.plusInformations.animaux)}',
      'Le nombre de passager que le conducteur accepte : ${_conducteurTrajet.trajetLance.plusInformations.nbPlaces.toString()}'];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(screenWidth * 0.03),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.04,
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 38.0,
                  backgroundImage: NetworkImage(_conducteurTrajet.utilisateur.imageUrl),
                ),
                SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_conducteurTrajet.utilisateur.nom +' '+ _conducteurTrajet.utilisateur.prenom,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    SizedBox(height: 4.0),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          Icons.star,
                          size: 20.0,
                          color: index < _conducteurTrajet.utilisateur.evaluation.etoiles.round()
                              ? Colors.yellow
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.025),
            // SizedBox(height: screenHeight * 0.014),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text("Email = ",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff137c8b),
                        ),
                      )),
                ),
                Expanded(child: Text(_conducteurTrajet.utilisateur.email), flex: 8),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Text("Marque de voiture = ",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff137c8b),
                        ),
                      )),
                ),
                Expanded(child: Text(_conducteurTrajet.utilisateur.vehicule.marque), flex: 5),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text("Matricule = ",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff137c8b),
                        ),
                      )),
                ),
                Expanded(child: Text(_conducteurTrajet.utilisateur.vehicule.matricule), flex: 3),
                Expanded(
                  child: IconButton(
                    icon: Icon(Icons.add_circle_outline),
                    iconSize: 20,
                    onPressed: () {
                      showModalBottomSheet(
                        isDismissible: true,
                        context: context,
                        builder: (context) => Builder(
                          builder: (context) {
                              return ListView.separated(
                                separatorBuilder: (context, index) => Divider(
                                  thickness: 1.0,
                                  color: Colors.grey[300],
                                ),
                                itemCount: plusInformations.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      plusInformations[index],
                                      style: TextStyle(
                                        fontFamily: 'poppins',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14,
                                      ),
                                    ),
                                  );
                                },
                              );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: OutlinedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.blue),
                            ),
                          ),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(
                              Colors.white),
                          foregroundColor:
                          MaterialStateProperty.all<Color>(
                              Color(0xff137c8b)),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                              isDismissible: true,
                              context: context,
                              builder: (context) => Builder(
                                builder: (context) {
                                  if (_conducteurTrajet.trajetLance.villeIntermediaires.isEmpty) {
                                    // If the list is empty, display a message
                                    return Center(
                                        child: Text(
                                            'Il y a pas de ville intermidiere'));
                                  } else {
                                    // If the list is not empty, display the commentaires in a ListView
                                    return ListView.separated(
                                      separatorBuilder: (context, index) => Divider(
                                        thickness: 1.0,
                                        color: Colors.grey[300],
                                      ),
                                      itemCount: _conducteurTrajet.trajetLance.villeIntermediaires.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: ListTile(
                                            leading: Icon(Icons.location_on_outlined),
                                            title: Text(
                                              _conducteurTrajet.trajetLance.villeIntermediaires[index],
                                              style: TextStyle(
                                                fontFamily: 'poppins',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                              )
                          );
                        },
                        child: Text('Villes intermedieres',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff137c8b),
                              ),
                        )

                    ),
                  ),
                ),
                SizedBox(width: 8,),
                Expanded(
                  child: OutlinedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.blue),
                          ),
                        ),
                        backgroundColor:
                        MaterialStateProperty.all<Color>(
                            Colors.white),
                        foregroundColor:
                        MaterialStateProperty.all<Color>(
                            Color(0xff137c8b)),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                            isDismissible: true,
                            context: context,
                            builder: (context) => Builder(
                              builder: (context) {
                                if (_conducteurTrajet.utilisateur.evaluation.feedback.isEmpty) {
                                  // If the list is empty, display a message
                                  return Center(
                                      child: Text(
                                          'Aucun avis'
                                      ,style: TextStyle(fontFamily: 'Poppins',),));
                                } else {
                                  // If the list is not empty, display the commentaires in a ListView
                                  return ListView.separated(
                                    separatorBuilder: (context, index) => Divider(
                                      thickness: 1.0,
                                      color: Colors.grey[300],
                                    ),
                                    itemCount: _conducteurTrajet.utilisateur.evaluation.feedback.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListTile(
                                          leading: Icon(Icons.location_on_outlined),
                                          title: Text(
                                            _conducteurTrajet.utilisateur.evaluation.feedback[index],
                                            style: TextStyle(
                                              fontFamily: 'poppins',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                            )
                        );
                      },
                      child: Text('avis sur le conducteur',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff137c8b),
                            ),
                          )
                      )
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.04),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Icon(Icons.circle, color: Colors.purple),
                      // SizedBox(height: 20),
                      Container(
                        height: screenHeight * 0.09,
                        width: 1,
                        color: Colors.grey,
                      ),
                      // SizedBox(height: 8),
                      Icon(
                        Icons.circle_outlined,
                        color: Colors.purple,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Container(
                        child: ListTile(
                          title: Text(
                            '${_conducteurTrajet.trajetLance.dateDepart.hour}:${_conducteurTrajet.trajetLance.dateDepart.minute}',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(_conducteurTrajet.trajetLance.villeDepart),
                          onTap: () {
                            // handle onTap event
                          },
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Container(
                        child: ListTile(
                          title: Text(
                            '${_conducteurTrajet.trajetLance.tempsDePause.hour}:${_conducteurTrajet.trajetLance.tempsDePause.minute}',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(_conducteurTrajet.trajetLance.villeArrivee),
                          onTap: () {
                            // handle onTap event
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.04),
            Container(
              padding: EdgeInsets.fromLTRB(
                  screenWidth * 0.03,
                  screenHeight * 0.016,
                  screenWidth * 0.03,
                  screenHeight * 0.016),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                border: Border.all(color: Colors.grey[400]!),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${_conducteurTrajet.trajetLance.dateDepart.day} ${BaseDeDonnee().moisAuChaine(_conducteurTrajet.trajetLance.dateDepart.month)} ${_conducteurTrajet.trajetLance.dateDepart.year}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _conducteurTrajet.trajetLance.coutTrajet.toString()+' DA',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            AfficherTrajetSurLeMap(_conducteurTrajet.trajetLance.latLngDepart, _conducteurTrajet.trajetLance.latLngArrivee),
                      ));
                    },
                    icon: Icon(Icons.map_outlined, size: 32),
                    label: Text(
                      'Voir le rajet sur le Map',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff137c8b)),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffb8cbd0),
                        side: BorderSide.none,
                        shape: StadiumBorder(side: BorderSide())),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: 5,
                    )),
                Expanded(
                  flex: 4,
                  child: ElevatedButton.icon(
                    onPressed: () {

                      // handle right button press
                      if (BaseDeDonnee().validatePhoneNumber(_conducteurTrajet.utilisateur.numeroTelephone)){
                        launchUrlString(
                            "tel:${_conducteurTrajet.utilisateur.numeroTelephone}");
                      }
                    },
                    icon: Icon(Icons.phone_in_talk_outlined, size: 32),
                    label: Text(
                      'Contacter le chauffeur',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff137cb8)),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffb8cbd0),
                        side: BorderSide.none,
                        shape: StadiumBorder(side: BorderSide())),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.06,
            ),
            ElevatedButton(
              onPressed: () {
                baseDeDonnee.ajouterNotification("N4sMJH5Un6aqWNuwGaTnQ34cPqt1",Notifications("N4sMJH5Un6aqWNuwGaTnQ34cPqt1","id_passager","id_trajet","Grine","Mohammed","Alger","el Aziziya",true));
                LocalNotification.initialize();
                FirebaseMessaging.onMessage.listen((RemoteMessage message) {
                  LocalNotification.showNotification(message);
                });
              },
              style:  ButtonStyle(
                elevation: MaterialStateProperty.all<double>(4.0),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(
                        vertical: screenHeight * 0.001,
                        horizontal: screenWidth * 0.23)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xff137c8b)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              child: Text(
                'Choisir ce conducteur',
                style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(0.0),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(
                        vertical: screenHeight * 0.001,
                        horizontal: screenWidth * 0.20)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.transparent),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              child: const Text('Annulez',
                  style: TextStyle(color: Colors.red, fontFamily: 'Poppins')),
            )
          ],
        ),
      ),
    );
  }
}
