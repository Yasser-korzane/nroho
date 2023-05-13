import 'package:appcouvoiturage/Services/base%20de%20donnee.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:appcouvoiturage/AppClasses/Notifications.dart';
import 'package:appcouvoiturage/pages/Demandes.dart';
import 'AfficherTrajetSurLeMap.dart';
import 'package:appcouvoiturage/pages/profilepage.dart';
import 'package:appcouvoiturage/Services/base de donnee.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appcouvoiturage/AppClasses/Utilisateur.dart';
import '../AppClasses/Evaluation.dart';
import '../AppClasses/Notifications.dart';
import '../AppClasses/PlusInformations.dart';
import '../AppClasses/Trajet.dart';
import '../AppClasses/Vehicule.dart';

class Details extends StatefulWidget {
  ConducteurTrajet _conducteurTrajet ;
  Details(this._conducteurTrajet);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late Utilisateur _utilisateur;
  Future _getDataFromDataBase() async {
    _utilisateur = BaseDeDonnee().creerUtilisateurVide();
    try {
      await FirebaseFirestore.instance
          .collection('Utilisateur')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((snapshot) async {
        if (snapshot.exists) {
          setState(() {
            _utilisateur.identifiant = snapshot.data()!['identifiant'];
            _utilisateur.nom = snapshot.data()!['nom'];
            _utilisateur.prenom = snapshot.data()!['prenom'];
            _utilisateur.email = snapshot.data()!['email'];
            _utilisateur.numeroTelephone = snapshot.data()!['numeroTelephone'];
            _utilisateur.evaluation = Evaluation(
              List<String>.from(snapshot.data()!['evaluation']['feedback']),
              snapshot.data()!['evaluation']['etoiles'],
              snapshot.data()!['evaluation']['nbSignalement'],
            );
            _utilisateur.vehicule = Vehicule(
              snapshot.data()!['vehicule']['marque'],
              snapshot.data()!['vehicule']['typevehicule'],
              snapshot.data()!['vehicule']['matricule'],
              snapshot.data()!['vehicule']['modele'],
              snapshot.data()!['vehicule']['policeAssurance'],
            );
            _utilisateur.statut = snapshot.data()!['statut'];
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
              _utilisateur.notifications.add(notification);
            }
            _utilisateur.imageUrl = snapshot.data()!['imageUrl'];
            _utilisateur.fcmTocken = snapshot.data()!['fcmTocken'];
            if (_utilisateur.imageUrl.isEmpty) _utilisateur.imageUrl = 'https://www.pngkey.com/png/full/115-1150152_default-profile-picture-avatar-png-green.png';
            //tests by printing
          }); // end setState
        } else {
          // end snapshot exist
          throw Exception("Utilisateur does not exist.");
        }
      });
    } catch (e) {
      throw Exception("Failed to get utilisateur.");
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDataFromDataBase();
  }
  @override
  Widget build(BuildContext context) {

    final Size screenSize = MediaQuery.of(context).size;

    BaseDeDonnee baseDeDonnee=new BaseDeDonnee();


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
                  Text(' '+widget._conducteurTrajet.utilisateur.vehicule.marque),
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
                            title: Text('Oued Smar_Alger'),
                            subtitle: Text(
                    '${widget._conducteurTrajet.trajetLance.dateDepart.hour}:${widget._conducteurTrajet.trajetLance.dateDepart.minute}',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Container(
                          child: ListTile(
                            title: Text('Maouklane_setif'),
                            subtitle: Text(
                          '${widget._conducteurTrajet.trajetLance.tempsDePause.hour}:${widget._conducteurTrajet.trajetLance.tempsDePause.minute}',
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
                    Text('${widget._conducteurTrajet.trajetLance.dateDepart.day} ${BaseDeDonnee().moisAuChaine(widget._conducteurTrajet.trajetLance.dateDepart.month)} ${widget._conducteurTrajet.trajetLance.dateDepart.year}',
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
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                              AfficherTrajetSurLeMap(widget._conducteurTrajet.trajetLance.latLngDepart, widget._conducteurTrajet.trajetLance.latLngArrivee),
                        ));
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
              SizedBox(
                height: screenHeight * 0.08,
              ),
              ElevatedButton(
                onPressed: () {
                  baseDeDonnee.ajouterNotification("${widget._conducteurTrajet.utilisateur.identifiant}",Notifications("${widget._conducteurTrajet.utilisateur.identifiant}","${FirebaseAuth.instance.currentUser!.uid}","${widget._conducteurTrajet.trajetLance.id}","${_utilisateur.nom}","${_utilisateur.nom}","${widget._conducteurTrajet.trajetLance.villeDepart}","${widget._conducteurTrajet.trajetLance.villeArrivee}",true));
                  sendNotification("${widget._conducteurTrajet.utilisateur.fcmTocken}", "nouvelle notification", "un passager vous a envoyé une demande ");
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
                onPressed: () {
                  Navigator.pop(context);
                },
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
                child: const Text('Annuler',
                    style: TextStyle(color: Colors.red, fontFamily: 'Poppins')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
