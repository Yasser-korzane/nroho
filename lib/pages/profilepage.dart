import 'package:appcouvoiturage/Services/auth.dart';
import 'package:appcouvoiturage/pages/Password.dart';
import 'package:appcouvoiturage/pages/profilmodification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:appcouvoiturage/widgets/profilwidget.dart';
import 'package:appcouvoiturage/pages/connexion.dart';
import 'package:get/get.dart';
import '../AppClasses/Evaluation.dart';
import '../AppClasses/PlusInformations.dart';
import '../AppClasses/Trajet.dart';
import '../AppClasses/Utilisateur.dart';
import '../AppClasses/Vehicule.dart';
import '../Models/Users.dart';
import '../Services/base de donnee.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({Key? key}) : super(key: key);

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  final AuthService _auth=AuthService();
  String _email = '';
  String _nom = '';
  String _prenom = '';
  Evaluation _evaluation = Evaluation([],0, 0) ;
  Future _getProfileInfo()async{
    await FirebaseFirestore.instance.collection('Utilisateur')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async{
      if (snapshot.exists){
        setState(() {
          _nom = snapshot.data()!['nom'];
          _prenom = snapshot.data()!['prenom'];
          _email = snapshot.data()!['email'];
          _evaluation = Evaluation(
            List<String>.from(snapshot.data()!['evaluation']['feedback']),
            snapshot.data()!['evaluation']['etoiles'],
            snapshot.data()!['evaluation']['nbSignalement'],
          );
        });
      }
    });
  }
  @override
  void initState() {
    super.initState();
    _getProfileInfo();
  }
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery
        .of(context)
        .size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final double defaultPadding = 10;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
        child: Container(
        padding:  EdgeInsets.all(screenWidth * 0.03),
    child: Column(
    children: [
    Column(
    children: [
    Text("Profil",style: TextStyle(color: Color(0xff344d59),fontSize: screenHeight*0.038)),
    SizedBox(
    width: screenHeight *0.15,
    height: screenHeight *0.15,
    child: ClipRRect(
    borderRadius: BorderRadius.circular(100),
    child: const Image(
    image: NetworkImage(
    'https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1031&q=80'),
    )
    )
    ),
    ],
    ),
    SizedBox(height: screenHeight * 0.015),
    Text("$_nom $_prenom", style: Theme.of(context).textTheme.headlineSmall),
    RatingWidget(color: Colors.yellow,rating: _evaluation.etoiles.toDouble(),size: screenWidth*0.05),
    SizedBox(height: screenHeight * 0.005),
    Text(_email,
    style: Theme.of(context).textTheme.bodyMedium),
    SizedBox(height: screenHeight * 0.02),
    SizedBox(
    width: screenWidth * 0.5,
    child: GestureDetector(onTap: (){
    Get.to(()=> ModifierProfilePage(),transition: Transition.zoom,);
    },
    child: ElevatedButton(
    onPressed: () {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ModifierProfilePage(),));
    },
    style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blue,
    side: BorderSide.none,
    shape: const StadiumBorder()),
    child: const Text('Modifier Profile',
    style: TextStyle(color: Colors.white)),
    ),
    )),
    SizedBox(height: screenHeight * 0.04),
    const Divider(),
    SizedBox(height: screenHeight * 0.01 ),

    //  Menu
      Profilewidget(
        title: 'Mes Courses',
        icon: Icons.navigation_rounded,
        onPress: () {

        },
      ),
      SizedBox(height: screenHeight * 0.008 ),
      Profilewidget(
        title: 'Mot de passe',
        icon: Icons.key_outlined,
        onPress: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MotdePasse(),));
        },
      ),
      SizedBox(height: screenHeight * 0.008 ),
      Profilewidget(
        title: 'Déconnexion',
        icon: Icons.logout,
        onPress: () async {
          await _auth.signOut();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Connexin(title: 'test')),
          );
        },
        endIcon: false,
        textColor: Colors.redAccent,
      ),
    ],
    ),
        ),
        ));
  }
}



class RatingWidget extends StatelessWidget {
  final double rating;
  final Color color;
  final double size;

  const RatingWidget({super.key, this.rating = 0.0, this.color = Colors.amber, this.size = 24.0});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
            (index) => Icon(
          index < rating.floor() ? Icons.star : Icons.star_border,
          size: size,
          color: color,
        ),
      ),
    );
  }
}