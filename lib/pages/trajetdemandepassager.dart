import 'package:nroho/AppClasses/Utilisateur.dart';
import 'package:nroho/Services/base%20de%20donnee.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:nroho/AppClasses/Notifications.dart';
import 'package:nroho/pages/Demandes.dart';
import '../AppClasses/Evaluation.dart';
import '../AppClasses/PlusInformations.dart';
import '../AppClasses/Trajet.dart';

class Detailspassaer extends StatefulWidget {
  String idPassager ;
  String idTrajetLance ;
  String idTrajetReserve ;
  List<String> nomPrenom ;
  List<String> villeDepartArrive ;
  bool accepte;
  Detailspassaer(this.idPassager,this.idTrajetLance,this.idTrajetReserve,this.nomPrenom,this.villeDepartArrive,this.accepte);
  @override
  State<Detailspassaer> createState() => _DetailspassaerState();
}

class _DetailspassaerState extends State<Detailspassaer> {
  late Utilisateur _utilisateur ;
  BaseDeDonnee baseDeDonnee=new BaseDeDonnee();
  bool est_presse=false;
  void _onButtonPressedaccepte() async{
    if (est_presse == false) {
      setState(() {
        est_presse = true;
        widget.accepte=true;
      });
    }
    await baseDeDonnee.ajouterNotification(_utilisateur.identifiant,Notifications(FirebaseAuth.instance.currentUser!.uid,_utilisateur.identifiant,widget.idTrajetLance,widget.idTrajetReserve,widget.nomPrenom[0],widget.nomPrenom[1],widget.villeDepartArrive[0],widget.villeDepartArrive[1],true));
    /* 1) et 4) et 5) */ await baseDeDonnee.modifierTrajetLance(widget.idTrajetLance, FirebaseAuth.instance.currentUser!.uid, _utilisateur.identifiant);
    /* 2) et 6) et 7) */ await baseDeDonnee.modifierTrajetReserve(widget.idTrajetReserve, FirebaseAuth.instance.currentUser!.uid, _utilisateur.identifiant);
    /* 3) */ await baseDeDonnee.incrementerNbPlacesConducteur(FirebaseAuth.instance.currentUser!.uid, widget.idTrajetLance);
    await sendNotification(_utilisateur.fcmTocken, "Nouvelle notification", "Un conducteur a accepté votre demande");
    await baseDeDonnee.updateUtilisateurilYaUneNotification(_utilisateur.identifiant, true);
  }
  void _onButtonPressedrefuse() async{
    if (est_presse == false) {
      setState(() {
        est_presse = true;
      });
    }
    await baseDeDonnee.ajouterNotification(_utilisateur.identifiant,Notifications(FirebaseAuth.instance.currentUser!.uid,_utilisateur.identifiant,widget.idTrajetLance,widget.idTrajetReserve,widget.nomPrenom[0],widget.nomPrenom[1],widget.villeDepartArrive[0],widget.villeDepartArrive[1],false));
    await sendNotification(_utilisateur.fcmTocken, "Nouvelle notification", "Un conducteur a refusé votre demande");
    await baseDeDonnee.updateUtilisateurilYaUneNotification(_utilisateur.identifiant, true);
  }
  Future _getDataFromDataBase() async {
    _utilisateur = BaseDeDonnee().creerUtilisateurVide();
    try {
      await FirebaseFirestore.instance
          .collection('Utilisateur')
          .doc(widget.idPassager)
          .get()
          .then((snapshot) async {
        if (snapshot.exists) {
          setState(() {
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
              _utilisateur.imageUrl = snapshot.data()!['imageUrl'];
              _utilisateur.fcmTocken = snapshot.data()!['fcmTocken'];
              if (_utilisateur.imageUrl.isEmpty) _utilisateur.imageUrl = 'https://www.pngkey.com/png/full/115-1150152_default-profile-picture-avatar-png-green.png';
            });
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
  late Trajet _trajet ;
  Future _getTrajet()async {
    _trajet = BaseDeDonnee().creerTrajetVide();
    await FirebaseFirestore.instance
        .collection('Utilisateur')
        .doc(widget.idPassager)
        .collection('trajetsReserves')
        .doc(widget.idTrajetReserve)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          _trajet.dateDepart = snapshot.data()!['dateDepart'].toDate(); //.add(Duration(hours: 1))
          _trajet.tempsDePause = snapshot.data()!['tempsDePause'].toDate();
          _trajet.coutTrajet = snapshot.data()!['coutTrajet'] as double;
          _trajet.villeDepart = snapshot.data()!['villeDepart'];
          _trajet.villeArrivee = snapshot.data()!['villeArrivee'];
          _trajet.plusInformations = PlusInformations(
              snapshot.data()!['plusInformations']['fumeur'],
              snapshot.data()!['plusInformations']['bagage'],
              snapshot.data()!['plusInformations']['animaux'],
              snapshot.data()!['plusInformations']['nbPlaces']);
        });
        _trajet.avis = snapshot.data()!['avis'];
      }else print('ce trajet n\'exist pas');
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getDataFromDataBase();
    _getTrajet();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    List plusInformations =
    ['Le passager fume : ${BaseDeDonnee().tranlsateToFrensh(_trajet.plusInformations.fumeur)}',
      'Le passager un bagage volumineux : ${BaseDeDonnee().tranlsateToFrensh(_trajet.plusInformations.bagage)}',
      'Le passager a des animaux : ${BaseDeDonnee().tranlsateToFrensh(_trajet.plusInformations.animaux)}',
      'Le nombre Le nombre de compagnons pour ce passager est de : ${_trajet.plusInformations.nbPlaces.toString()}'];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {Navigator.pop(context);},
            icon: const Icon(Icons.arrow_back, color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(screenWidth * 0.025, 0, screenWidth * 0.025, 0),
          padding:  EdgeInsets.all(screenWidth * 0.05),
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.04,
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 38.0,
                    backgroundImage: NetworkImage(_utilisateur.imageUrl),
                  ),
                  SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_utilisateur.nom +' '+ _utilisateur.prenom,
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
                            color: index < _utilisateur.evaluation.etoiles.round()
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
                  Expanded(child: Text(_utilisateur.email), flex: 8),
                ],
              ),
              SizedBox(height: screenHeight * 0.01),
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
                          child: Text('Plus d\'information',
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
                                  if (_utilisateur.evaluation.feedback.isEmpty) {
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
                                      itemCount: _utilisateur.evaluation.feedback.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListTile(
                                            leading: Icon(Icons.location_on_outlined),
                                            title: Text(
                                              _utilisateur.evaluation.feedback[index],
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
                        child: Text('Avis sur le passager',
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
                            //title: Text('${_trajet.lieuDepart}'),
                            title: Text(_trajet.villeDepart),
                            subtitle: Text(
                              '${_trajet.dateDepart.hour}:${_trajet.dateDepart.minute}',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Container(
                          child: ListTile(
                            title: Text(_trajet.villeArrivee),
                            subtitle: Text(
                              '${_trajet.tempsDePause.hour}:${_trajet.tempsDePause.minute}',
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${_trajet.dateDepart.day} ${BaseDeDonnee().moisAuChaine(_trajet.dateDepart.month)} ${_trajet.dateDepart.year}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              OutlinedButton(
                onPressed: () {

                  // handle right button press
                  if (BaseDeDonnee().validatePhoneNumber(_utilisateur.numeroTelephone)){
                    launchUrlString(
                        "tel:${_utilisateur.numeroTelephone}");
                  }
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
                  EdgeInsets.all(0.1),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.phone_in_talk_outlined,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "${_utilisateur.numeroTelephone}",
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                ),
              ),
               SizedBox(height: screenHeight * 0.02,),
               Text('Commentaire :  '+'<< '+_trajet.avis+' >>'),
               SizedBox(height: screenHeight * 0.02,),
               widget.accepte ?
              Container(
                margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.green[100],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 40,
                      color: Colors.green,

                    ),
                    Text("la demande a été accepté",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                      ),),
                  ],
                ),
              )
              : est_presse ? Container(
                margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.red[100],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cancel,
                      size: 40,
                      color: Colors.red,

                    ),
                    Text("la demande a été refusé",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                      ),),
                  ],
                ),
              )
                  : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    ElevatedButton(
                      onPressed: _onButtonPressedaccepte,
                      style:  ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(4.0),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.symmetric(
                                vertical: screenHeight * 0.001,
                                horizontal: screenWidth * 0.23)),
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xff137c8b)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      child: Text(
                        'Accepter la demande',
                        style: TextStyle(color: Colors.white, fontFamily: 'Poppins',fontSize: 12),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _onButtonPressedrefuse,
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
                      child: const Text('Refuser la demande',
                          style: TextStyle(color: Colors.red, fontFamily: 'Poppins',fontSize: 12)),
                    )
                  ]
              )
            ],
          ),
        ),
      ),
    );
  }
}
