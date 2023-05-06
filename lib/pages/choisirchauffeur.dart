import 'package:appcouvoiturage/pages/trajetdetailsconducteurs.dart';
import 'package:flutter/material.dart';
import '../Services/base de donnee.dart';

class DriverListPage extends StatelessWidget {
  List<ConducteurTrajet> listeUtilisateurs ;
  DriverListPage(this.listeUtilisateurs) ;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return Scaffold(
      backgroundColor: Color(0xffCDCACA),
      appBar: AppBar(
        title: Text(
          'Choisissez un chauffeur',
          style: TextStyle(color: Color(0xff344D59), fontSize: 20,fontFamily: 'Poppins'),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 5,
      ),
      body: ListView.builder( // Utilisation du widget ListView.builder pour afficher à l'utilisateur l'ensemble des chauffeurs disponible correspandant a sa demande
        itemCount: listeUtilisateurs.length,
        itemBuilder: (context, index) {
          final ConducteurTrajet conducteurTrajet = listeUtilisateurs[index];
          return Padding(
            padding:  EdgeInsets.all(screenWidth*0.015),
            child: Card(
              color: Colors.white,
              elevation: 8,
              margin: EdgeInsets.symmetric(horizontal: screenHeight*0.01,vertical: screenWidth*0.001),
              borderOnForeground:true,
              shape:   RoundedRectangleBorder(
                  side:  BorderSide(color: Colors.grey,width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              child:   Padding(
                padding:  EdgeInsets.all(screenWidth*0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        children: [
                      Image.network(
                        conducteurTrajet.utilisateur.imageUrl,
                        height: screenHeight*0.055,
                        width: screenWidth*0.12,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: screenWidth*0.04),
                        Text('${conducteurTrajet.utilisateur.nom} ${conducteurTrajet.utilisateur.prenom}',
                          style: TextStyle( color: Color(0xff137C8B),fontSize: 16,fontWeight: FontWeight.bold,fontFamily: 'Popping'),
                        ),
                    ]),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Icon(Icons.location_on),
                              // SizedBox(height: screenHeight * 0.03),
                              Container(
                                height: screenHeight*0.035,
                                width: 1,
                                color: Colors.grey,
                              ),
                              // SizedBox(height: screenHeight * 0.03),
                              Icon(
                                Icons.location_on,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment:CrossAxisAlignment.end ,
                            children: [
                              Container(
                                child: ListTile(
                                  title: Text(
                                    '${conducteurTrajet.trajetLance.villeDepart}\n${conducteurTrajet.trajetLance.dateDepart.year}-${conducteurTrajet.trajetLance.dateDepart.month}-${conducteurTrajet.trajetLance.dateDepart.day} à ${conducteurTrajet.trajetLance.dateDepart.hour}:${conducteurTrajet.trajetLance.dateDepart.minute}',
                                    style: TextStyle(
                                        color: Color(0xff7A90A4), fontSize: 15,fontFamily: 'Poppins'),
                                  ),
                                  onTap: () {
                                    // handle onTap event
                                  },
                                ),
                              ),
                              Container(
                                child: ListTile(
                                  title: Text(
                                    '${conducteurTrajet.trajetLance.villeArrivee}\n${conducteurTrajet.trajetLance.tempsDePause.year}-${conducteurTrajet.trajetLance.tempsDePause.month}-${conducteurTrajet.trajetLance.tempsDePause.day} à ${conducteurTrajet.trajetLance.tempsDePause.hour}:${conducteurTrajet.trajetLance.tempsDePause.minute}',
                                    style: TextStyle(
                                        color: Color(0xff7A90A4), fontSize: 15,fontFamily: 'Poppins'),
                                  ),
                                  onTap: () {
                                    // handle onTap event
                                  },
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text('Cout du Trajet : ${conducteurTrajet.trajetLance.coutTrajet} DA',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.all(screenWidth*0.04),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Details(conducteurTrajet)));
                              },
                              child: Text('Choisir',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                              ),
                              ),
                            ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //
            ),
          );
        },
      ),
    );
  }
}
