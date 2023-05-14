import 'package:appcouvoiturage/pages/AfficherTrajetSurLeMap.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../AppClasses/Trajet.dart';

class detailsConducteur extends StatelessWidget {
  Trajet _trajet;
  bool cond_pas;

  List<String> utilisateur = [
    'yasser',
    'mohammed',
    'hicham',
    'karim',
    'riyad'
  ]; // si false alors passager else est conducteur
  detailsConducteur(this._trajet, this.cond_pas);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final double defaultPadding = 10;
    String qualite = '\n';
    if (_trajet.probleme)
      qualite += '"Il y avait un problème avec ce trajet!';
    else
      qualite += '"Le trajet Le s\'est bien passé sans problèmes';
    return SafeArea(
      child: Scaffold(
          floatingActionButton: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            child: Text('Voir le trajet sur la carte',style: TextStyle(fontFamily: 'poppins',color: Colors.blue,fontWeight: FontWeight.bold),),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => AfficherTrajetSurLeMap(_trajet.latLngDepart, _trajet.latLngArrivee),));
            },
          ),
          body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            defaultPadding,
            defaultPadding * 2,
            defaultPadding,
            defaultPadding * 2,
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: Color(0xFFBAF1F9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Text(
                        'Informations de la course',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: screenWidth * 0.05,
                              // responsive font size
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins'),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Add your logic here to navigate back to the previous page
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.cancel,
                              color: Colors.white,
                              size: screenWidth * 0.04, // responsive icon size
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Date et Heure de depart',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Icon(Icons.calendar_month_outlined)),
                        Expanded(
                          child: Text(
                            '${_trajet.dateDepart.year}-${_trajet.dateDepart.month}-${_trajet.dateDepart.day}',
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                          flex: 5,
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      children: [
                        Expanded(flex: 1, child: Icon(Icons.access_time)),
                        Expanded(
                          child: Text(
                            '${_trajet.dateDepart.hour}:${_trajet.dateDepart.minute}',
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                          flex: 5,
                        ),
                      ],
                    ),
                    Divider(color: Colors.black, thickness: 1),
                    Row(
                      children: [
                        Text(
                          'Date et Heure d\'arrivée',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Icon(Icons.calendar_month_outlined)),
                        Expanded(
                          child: Text(
                            '${_trajet.tempsDePause.year}-${_trajet.tempsDePause.month}-${_trajet.tempsDePause.day}',
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                          flex: 5,
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      children: [
                        Expanded(flex: 1, child: Icon(Icons.access_time)),
                        Expanded(
                          child: Text(
                            '${_trajet.tempsDePause.hour}:${_trajet.tempsDePause.minute}',
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                          flex: 5,
                        ),
                      ],
                    ),
                    Divider(color: Colors.black, thickness: 1),
                    SizedBox(height: screenHeight * 0.01),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Icon(Icons.circle, color: Colors.purple),
                              // SizedBox(height: screenHeight * 0.03),
                              Container(
                                height: screenHeight * 0.05,
                                width: 1,
                                color: Colors.grey,
                              ),
                              // SizedBox(height: screenHeight * 0.03),
                              Icon(
                                Icons.circle_outlined,
                                color: Colors.purple,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 9,
                          child: Column(
                            children: [
                              Container(
                                child: ListTile(
                                  title: Text(
                                    '${_trajet.villeDepart}',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins'),
                                  ),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.005),
                              Container(
                                child: ListTile(
                                  title: Text(
                                    '${_trajet.villeArrivee}',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Divider(color: Colors.black, thickness: 1),
                    Row(
                      children: [
                        Text(
                          'Le conducteur/Les passagers :',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    /*ListView.separated(
                        itemBuilder: (context, index) {},
                        separatorBuilder: (context, index) {
                          return ListTile(
                            title: Center(child: Text(utilisateur[index])),
                            // customize the appearance of your separator as desired
                            // e.g. change the color, size, etc.
                          );
                        },
                        itemCount: utilisateur.length),*/
                    Divider(color: Colors.black, thickness: 1),
                    Row(
                      children: [
                        Text(
                          'Prix : ',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            '${_trajet.coutTrajet} DA',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(color: Colors.black, thickness: 1),
                    Row(
                      children: [
                        Text(
                          ' Note et commentaire : ',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      /*child: Row(
                        children: List.generate(5,
                          (index) => Icon(
                            Icons.star,
                            size: 20.0,
                            color: index <
                                    4.round() //on utilise un variable pour donner le raiting
                                ? Colors.yellow
                                : Colors.grey,
                          ),
                        ),
                      ),*/
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 4),
                          child: Text(
                            '" ${_trajet.avis} "',
                            style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 15.5,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Qualité du trajet:\n$qualite"',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Divider(color: Colors.black, thickness: 1),
                    Row(
                      children: [
                        Text(
                          'Besoin d’aide ?',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Center(
                      child: Text.rich(
                        TextSpan(
                          text:
                              'Si vous avez un problème avec ce trajet, contactez notre service client pour plus d’aide ou signalez directement par ',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16.0,
                            fontFamily: 'Poppins',
                          ),
                          children: [
                            TextSpan(
                              text: 'ici',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16.0,
                                fontFamily: 'Poppins',
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launch(
                                      'https://karimiarkane.github.io/NrohoSignaler.github.io/');
                                },
                            )
                          ],
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        maxLines: null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
