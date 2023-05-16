import 'package:nroho/AppClasses/Trajet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Services/base de donnee.dart';
import 'annulertrajet.dart';
class detailsTrajetReserver extends StatelessWidget {
  Trajet _trajet ;
  detailsTrajetReserver(this._trajet);
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final double defaultPadding = 10;
    return SafeArea(
      child: Scaffold(
          floatingActionButton: ElevatedButton(
            child: Text('Annuler le trajet',style: TextStyle(fontFamily: 'poppins',color: Colors.white),),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () async {
              final bool result = await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AnnulerTrajet(_trajet.id,false);
                },
              );
              if (result) {
                Navigator.pop(context,true);
              }
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                            style: GoogleFonts.poppins(
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
                              'Date et heure de départ',
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
                                '${BaseDeDonnee().reglerTemps(_trajet.dateDepart.day)} ${BaseDeDonnee().moisAuChaine(_trajet.dateDepart.month)} ${_trajet.dateDepart.year}',
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
                                '${BaseDeDonnee().reglerTemps(_trajet.dateDepart.hour)}:${BaseDeDonnee().reglerTemps(_trajet.dateDepart.minute)}',
                                style: TextStyle(fontFamily: 'Poppins'),
                              ),
                              flex: 5,
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Divider(color: Colors.black, thickness: 1),
                        SizedBox(height: screenHeight * 0.01),
                        Row(
                          children: [
                            Text(
                              'Date et heure d\'arrivée',
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
                                '${BaseDeDonnee().reglerTemps(_trajet.tempsDePause.day)} ${BaseDeDonnee().moisAuChaine(_trajet.tempsDePause.month)} ${_trajet.tempsDePause.year}',
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
                                '${BaseDeDonnee().reglerTemps(_trajet.tempsDePause.hour)}:${BaseDeDonnee().reglerTemps(_trajet.tempsDePause.minute)} (estimation)',
                                style: TextStyle(fontFamily: 'Poppins'),
                              ),
                              flex: 5,
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.01),
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
                                        _trajet.villeDepart,
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins'),
                                      ),
                                      onTap: () {
                                        // handle onTap event
                                      },
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.005),
                                  Container(
                                    child: ListTile(
                                      title: Text(
                                        _trajet.villeArrivee,
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins'),
                                      ),
                                      onTap: () {
                                        // handle onTap event
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Divider(color: Colors.black, thickness: 1),
                        SizedBox(height: screenHeight * 0.02),
                        Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment:CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Commentaire : ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Text(
                                  '"${_trajet.avis}"',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14.0,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),

                          ],
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
