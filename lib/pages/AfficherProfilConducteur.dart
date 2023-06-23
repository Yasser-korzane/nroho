import 'package:nroho/Services/base%20de%20donnee.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'AfficherTrajetSurLeMap.dart';
class AfficherProfilConducteur extends StatefulWidget {
  ConducteurTrajet _conducteurTrajet ;
  AfficherProfilConducteur(this._conducteurTrajet);
  @override
  State<AfficherProfilConducteur> createState() => _AfficherProfilConducteurState();
}

class _AfficherProfilConducteurState extends State<AfficherProfilConducteur> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    List plusInformations =
    ['Le conducteur fume : ${BaseDeDonnee().tranlsateToFrensh(widget._conducteurTrajet.trajetLance.plusInformations.fumeur)}',
      'Le conducteur accepte un bagage volumineux : ${BaseDeDonnee().tranlsateToFrensh(widget._conducteurTrajet.trajetLance.plusInformations.bagage)}',
      'Le conducteur accepte des animaux : ${BaseDeDonnee().tranlsateToFrensh(widget._conducteurTrajet.trajetLance.plusInformations.animaux)}',
      'Le nombre de passager que le conducteur accepte : ${widget._conducteurTrajet.trajetLance.plusInformations.nbPlaces.toString()}'];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
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
                    backgroundImage: NetworkImage(widget._conducteurTrajet.utilisateur.imageUrl),
                  ),
                  SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget._conducteurTrajet.utilisateur.nom +' '+ widget._conducteurTrajet.utilisateur.prenom,
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
                            color: index < widget._conducteurTrajet.utilisateur.evaluation.etoiles.round()
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
                    child: Text("Email : ",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff137c8b),
                          ),
                        )),
                  ),
                  Expanded(child: Text(widget._conducteurTrajet.utilisateur.email), flex: 8),
                ],
              ),
              SizedBox(height: screenHeight * 0.01),
              Row(
                children: [
                  Text("Marque de voiture :",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff137c8b),
                        ),
                      )),
                  Text(' '+widget._conducteurTrajet.utilisateur.vehicule.modele+' '+widget._conducteurTrajet.utilisateur.vehicule.marque),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text("Matricule :",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff137c8b),
                          ),
                        )),
                  ),
                  Expanded(child: Text(widget._conducteurTrajet.utilisateur.vehicule.matricule), flex: 5),
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
                                    if (widget._conducteurTrajet.trajetLance.villeIntermediaires.isEmpty) {
                                      // If the list is empty, display a message
                                      return Center(
                                          child: Text(
                                              'Il n\'y a pas de ville intermédiaire'));
                                    } else {
                                      // If the list is not empty, display the commentaires in a ListView
                                      return ListView.separated(
                                        separatorBuilder: (context, index) => Divider(
                                          thickness: 1.0,
                                          color: Colors.grey[300],
                                        ),
                                        itemCount: widget._conducteurTrajet.trajetLance.villeIntermediaires.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: ListTile(
                                              leading: Icon(Icons.location_on_outlined),
                                              title: Text(
                                                widget._conducteurTrajet.trajetLance.villeIntermediaires[index],
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
                          child: Text('Villes intermédiaires',
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
                                  if (widget._conducteurTrajet.utilisateur.evaluation.feedback.isEmpty) {
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
                                      itemCount: widget._conducteurTrajet.utilisateur.evaluation.feedback.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListTile(
                                            leading: Icon(Icons.location_on_outlined),
                                            title: Text(
                                              widget._conducteurTrajet.utilisateur.evaluation.feedback[index],
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
                        child: Text('Avis sur le conducteur',
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
              SizedBox(height: screenHeight * 0.03),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Icon(Icons.circle, color: Colors.purple),
                        // SizedBox(height: 20),
                        Container(
                          height: screenHeight * 0.07,
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
                            title: Text(widget._conducteurTrajet.trajetLance.villeDepart),
                            subtitle: Text(
                              '${BaseDeDonnee().reglerTemps(widget._conducteurTrajet.trajetLance.dateDepart.hour)}:${BaseDeDonnee().reglerTemps(widget._conducteurTrajet.trajetLance.dateDepart.minute)}',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Container(
                          child: ListTile(
                            title: Text(widget._conducteurTrajet.trajetLance.villeArrivee),
                            subtitle: Text(
                              '${BaseDeDonnee().reglerTemps(widget._conducteurTrajet.trajetLance.tempsDePause.hour)}:${BaseDeDonnee().reglerTemps(widget._conducteurTrajet.trajetLance.tempsDePause.minute)}',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),

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
                    Text('${BaseDeDonnee().reglerTemps(widget._conducteurTrajet.trajetLance.dateDepart.day)} ${BaseDeDonnee().moisAuChaine(widget._conducteurTrajet.trajetLance.dateDepart.month)} ${widget._conducteurTrajet.trajetLance.dateDepart.year}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget._conducteurTrajet.trajetLance.coutTrajet.toString()+' DA',
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
                        Navigator.push(context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => AfficherTrajetSurLeMap(widget._conducteurTrajet.trajetLance.latLngDepart, widget._conducteurTrajet.trajetLance.latLngArrivee),
                            transitionDuration: Duration(milliseconds: 600),
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
                          ),);
                      },
                      icon: Icon(Icons.map_outlined, size: 32),
                      label: Text(
                        'Voir le trajet sur la carte',
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
                        if (BaseDeDonnee().validatePhoneNumber(widget._conducteurTrajet.utilisateur.numeroTelephone)){
                          launchUrlString(
                              "tel:${widget._conducteurTrajet.utilisateur.numeroTelephone}");
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
            ],
          ),
        ),
      ),
    );
  }
}
