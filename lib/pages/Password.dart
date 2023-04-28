import 'package:appcouvoiturage/AppClasses/Notifications.dart';
import 'package:appcouvoiturage/AppClasses/PlusInformations.dart';
import 'package:appcouvoiturage/AppClasses/Trajet.dart';
import 'package:appcouvoiturage/AppClasses/Utilisateur.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:places_service/places_service.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../Services/base de donnee.dart';
import '../Shared/lodingEffect.dart';
class MotdePasse extends StatefulWidget {
  const MotdePasse({Key? key}) : super(key: key);

  @override
  State<MotdePasse> createState() => _MotdePasseState();
}

class _MotdePasseState extends State<MotdePasse> {
  final BaseDeDonnee _baseDeDonnee = BaseDeDonnee();
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('Utilisateur');
  String oldPassword = '';
  String newPassword = '';
  List<Utilisateur> utilisateurs = [];
  void changePassword(BuildContext context) async {
    try {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Loading()),
      );
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Erreur'),
                content: Text('L\'utilisateur n\'est pas authentifiée!'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK'),
                  )
                ],
              );
            });
        return;
      }
      // Re-authenticate the user with their old password
      AuthCredential credential = EmailAuthProvider.credential(email: user.email!, password: oldPassword);
      await user.reauthenticateWithCredential(credential);
      // Update the user's password
      await user.updatePassword(newPassword);
      /* Update the password in the Firestore collection
      await usersCollection.doc(user.uid).update({'password': newPassword});*/
      Navigator.pop(context);
      // Show success dialog
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Succès'),
              content: Text('Mot de passe mis à jour avec succès'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                )
              ],
            );
          });
    } catch (e) {
      // Handle error
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Ancien mot de passe incorrect!',style: TextStyle(fontFamily: 'Poppins'),),
              content: Text('Échec de la mise à jour du mot de passe. Veuillez réessayer',style: TextStyle(fontFamily: 'Poppins'),),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK',style: TextStyle(fontFamily: 'Poppins'),),
                )
              ],
            );
          });
    }
  }
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final double defaultPadding = 10;
    Timestamp timestamp = Timestamp.now();
    DateTime dateTime = timestamp.toDate();
    PlacesAutoCompleteResult lieuDepart = PlacesAutoCompleteResult(
      placeId: '',
      description: '',
      secondaryText: '',
      mainText: '',
    );
    PlacesAutoCompleteResult lieuArrive = PlacesAutoCompleteResult(
      placeId: '',
      description: '',
      secondaryText: '',
      mainText: '',
    );
    int year = dateTime.year;
    int month = dateTime.month;
    int day = dateTime.day;
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    DateTime timearrivee = DateTime(year,month,day,hour+1,minute-15) ;
    Trajet trajetReserve = Trajet('' , dateTime, timearrivee, 300, 'BeauLieu', "Esi",lieuDepart,lieuArrive, ['Itemm'], PlusInformations(false,false,false,1), false, "", "", false);
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
            onPressed: () {
        Navigator.pop(context);
  },
                icon: const Icon(Icons.arrow_back, color: Color(0xff344d59))),
          title: Text('Mot de passe',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenHeight*0.035,
                fontFamily: 'Poppins',
              )),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
        child: Padding(
        padding:  EdgeInsets.all(screenWidth*0.08),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    // mainAxisAlignment: MainAxisAlignment.start,
    children: [
    SizedBox(height: screenHeight*0.04,),
      Center(child:
      TextButton(child: Text('changer le mot de passe ',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
        onPressed: ()async{
        Notifications not = Notifications(FirebaseAuth.instance.currentUser!.uid, 'id_pasagers', 'XFFvL2tupM3GrpRUvqkv','Grine','Mohammed','Alger','Bouira',false);
        // await _baseDeDonnee.ajouterNotification(FirebaseAuth.instance.currentUser!.uid, not);
        // await _baseDeDonnee.saveTrajetReserveAsSubcollection(FirebaseAuth.instance.currentUser!.uid, trajetReserve);
        // await _baseDeDonnee.saveTrajetLanceAsSubcollection(FirebaseAuth.instance.currentUser!.uid, trajetReserve);
        // await _baseDeDonnee.saveHistoriqueAsSubcollection(FirebaseAuth.instance.currentUser!.uid, trajetReserve);
        //await _baseDeDonnee.chercherConductuersPossibles(FirebaseAuth.instance.currentUser!.uid, 'JJo7Q4E6IJHmLJdA6XD8');
         },
      ),
      ),
    SizedBox(height: screenHeight*0.1),
    Text('Ancien mot de passe',
    style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Poppins'),),

    TextField(
      style: TextStyle(fontFamily: 'Poppins'),
    keyboardType: TextInputType.text,
    onChanged: (value) {
    setState(() {
    oldPassword = value ;
    });
    },

    decoration: InputDecoration(
    enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
    ),
    fillColor: Colors.white,
    filled: true,
    hintText: 'Entrez votre ancien mot de passe',
    ),
    obscureText: true,
    ),
    SizedBox(height: screenHeight*0.07),
    Text('Nouveau mot de passe ',
    style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Poppins'),),
    TextField(
      style: TextStyle(fontFamily: 'Poppins'),
    keyboardType: TextInputType.text,
    onChanged: (value) {
    setState(() {
    newPassword = value ;
    });
    },
    obscureText: true,
    decoration: InputDecoration(
    enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
    ),
    fillColor: Colors.white,
    filled: true,
    hintText: 'Entrez votre nouveau mot de passe',

    ),
    ),
    SizedBox(height: screenHeight*0.1),
    ElevatedButton(
    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue),),
    onPressed: () async{
      if(_baseDeDonnee.validerMotDePasse(newPassword)){
    changePassword(context);
      }else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  "Vous devez verifier le mot de passe",
                style: TextStyle(fontFamily: 'Poppins'),),
              duration: Duration(seconds: 2),
            )
        );
      }
    },
    child: Center(child: Text('Valider les modifications',style: TextStyle(color: Colors.white,fontFamily: 'Poppins'),)),

    ),
    SizedBox(height: screenHeight*0.17),
    Center(
    child: Text.rich(
    TextSpan(
    text: 'besoin d’aide? ',
    style: TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 16.0,
    fontFamily: 'Poppins',
    ),
    children: [
    TextSpan(
    text: ' Cliquez ici',
    style: TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 16.0,
    fontFamily: 'Poppins',
    color: Colors.blue,
    decoration: TextDecoration.underline,
    ),
    recognizer: TapGestureRecognizer()
    ..onTap = () {
    launchUrlString('https://tresor.cse.club/');
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
        )
    );
  }
}