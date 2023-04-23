import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../AppClasses/Evaluation.dart';
import '../AppClasses/PlusInformations.dart';
import '../AppClasses/Trajet.dart';
import '../AppClasses/Utilisateur.dart';
import '../AppClasses/Vehicule.dart';
import '../Services/base de donnee.dart';
import '../Shared/lodingEffect.dart';


class ModifierProfilePage extends StatefulWidget {
  @override
  _ModifierProfilePageState createState() => _ModifierProfilePageState();
}
class _ModifierProfilePageState extends State<ModifierProfilePage> {
  final BaseDeDonnee _baseDeDonnee = BaseDeDonnee();
  bool _changement = false ;
  /*TextEditingController _contrNom = TextEditingController();
  TextEditingController _contrPrenom = TextEditingController();
  TextEditingController _contrMarque = TextEditingController();
  TextEditingController _contrType = TextEditingController();
  TextEditingController _contrMatricule = TextEditingController();
  TextEditingController _contrModele = TextEditingController();
  TextEditingController _contrPolice = TextEditingController();
  TextEditingController _contrNbPlaces = TextEditingController();*/
  // Methode pour changer la photo de profil
  void _changerPhoto() {
    // Implementer la logique pour changer la photo de profil
  }
  late Utilisateur _utilisateur ;
  Future _getDataFromDataBase()async {
    _utilisateur = BaseDeDonnee().creerUtilisateurVide();
    try {
      await FirebaseFirestore.instance.collection('Utilisateur')
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
              snapshot.data()!['vehicule']['nbPlaces'],
            );
            _utilisateur.statut = snapshot.data()!['statut'];
            //tests by printing
          }); // end setState
        } else { // end snapshot exist
          throw Exception("Utilisateur does not exist.");
        }
      });
    } catch (e) {
      throw Exception("Failed to get utilisateur.");
    }
  } /// end getdata
  @override
  void initState() {
    super.initState();
    _getDataFromDataBase();
  }
  @override
  Widget build(BuildContext context) {
    /*_contrNom.text = _utilisateur.nom;
    _contrPrenom.text = _utilisateur.prenom;
    _contrMarque.text = _utilisateur.vehicule.marque;
    _contrType.text = _utilisateur.vehicule.typevehicule;
    _contrMatricule.text = _utilisateur.vehicule.matricule;
    _contrModele.text = _utilisateur.vehicule.modele;
    _contrPolice.text = _utilisateur.vehicule.policeAssurance;
    _contrNbPlaces.text = _utilisateur.vehicule.nbPlaces.toString();*/
    if (_utilisateur.nom.isEmpty) _utilisateur.nom = 'Entrer votre nom';
    if (_utilisateur.prenom.isEmpty) _utilisateur.prenom = 'Entrer votre prenom';
    if (_utilisateur.vehicule.marque.isEmpty) _utilisateur.vehicule.marque = 'Entrez la marque de votre vehicule';
    if (_utilisateur.vehicule.typevehicule.isEmpty) _utilisateur.vehicule.typevehicule = 'Entrez le type de votre vehicule';
    if (_utilisateur.vehicule.matricule.isEmpty) _utilisateur.vehicule.matricule = 'Entrez la matircule de votre vehicule';
    if (_utilisateur.vehicule.modele.isEmpty) _utilisateur.vehicule.modele = 'Entrez le modele de votre vehicule';
    if (_utilisateur.vehicule.policeAssurance.isEmpty) _utilisateur.vehicule.policeAssurance = 'Entrez la police d\'assurance de votre vehicule';
    if (_utilisateur.vehicule.marque.isEmpty) _utilisateur.vehicule.nbPlaces = 0;
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
      Center(
      child: GestureDetector(
      onTap: _changerPhoto,
        child: CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(
              'https://media.istockphoto.com/id/1210939712/vector/user-icon-people-icon-isolated-on-white-background-vector-illustration.jpg?s=612x612&w=0&k=20&c=vKDH9j7PPMN-AiUX8vsKlmOonwx7wjqdKiLge7PX1ZQ='),
        ),
      ),
    ),
    SizedBox(height: size.height * 0.014),
    Align(
    alignment: Alignment.center,
    child: Text(
    'changer votre photo',
    style: TextStyle(
    color: Color(0xff271BAB),
    ),
    ),
    ),
    Card(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
    Row(
    children: [
    Expanded(
    child: Text(
    'Identifiant:',
    style: TextStyle(color: Colors.grey, fontSize: 12),
    ),
    ),
    Expanded(
    child: Text(
    _utilisateur.identifiant,
    style: TextStyle(color: Colors.grey, fontSize: 12),
    ),
    ),
    ],
    ),
    Row(
    children: [
    Expanded(
    child: Text(
    'Email: ',
    style: TextStyle(color: Colors.grey, fontSize: 12),
    ),
    ),
    Expanded(
    child: Text(
    _utilisateur.email,
    style: TextStyle(color: Colors.grey, fontSize: 12),
    ),
    ),
    ],
    ),
    Row(
    children: [
    Expanded(
    child: Text(
    'Numero de telephone:',
    style: TextStyle(color: Colors.grey, fontSize: 12),
    ),
    ),
    Expanded(
    child: Text(
    _utilisateur.numeroTelephone,
    style: TextStyle(color: Colors.grey, fontSize: 12),
    ),
    ),
    ],
    )
    ],
    ),
    ),
    SizedBox(height: size.height * 0.033),
    Text(
    'Nom',
    style: TextStyle(fontWeight: FontWeight.bold),
    ),
    SizedBox(
    width: size.width * 0.7,
    height: size.height * 0.06,
    child: TextFormField(//controller: _contrNom,
    decoration: InputDecoration(
    enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
    ),
    fillColor: Colors.white,
    filled: true,
    hintText: _utilisateur.nom,
    ),
    onChanged: (value) {
    _changement = true ;
    setState(() {
    _utilisateur.nom = value;
    });
    },
    ),
    ),
    SizedBox(height:size.height * 0.02),
    Text(
    'Prenom',
    style: TextStyle(fontWeight: FontWeight.bold),
    ),
    SizedBox(
    width: size.width * 0.7,
    height: size.height * 0.06,
    child: TextField(//controller: _contrPrenom,
    decoration: InputDecoration(
    enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
    ),
    fillColor: Colors.white,
    filled: true,
    hintText: _utilisateur.prenom,
    ),
    onChanged: (value) {
    _changement = true ;
    setState(() {
    //_contrPrenom.text = value;
    _utilisateur.prenom = value;
    });
    },
    )
    ),
    SizedBox(height: 25),
    SizedBox(height: 40),
    Text(
    'Informations du vehicule',
    style: TextStyle(
    color: Color(0xff0085FF),
    fontWeight: FontWeight.bold,
    fontSize: 16),
    textAlign: TextAlign.center,
    ),
    SizedBox(height: 10),
    Text(
    'marque',
    style: TextStyle(fontWeight: FontWeight.bold),
    ),
    SizedBox(
    width: size.width * 0.7,
    height: size.height * 0.06,
    child: TextField(//controller: _contrMarque,
    decoration: InputDecoration(
    enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
    ),
    fillColor: Colors.white,
    filled: true,
    hintText: _utilisateur.vehicule.marque,
    ),
    onChanged: (value) {
    setState(() {
    _changement = true ;
    //_contrMarque.text = value;
    _utilisateur.vehicule.marque = value;
    });
    },
    )
    ),
    SizedBox(height: 15),
    Text(
    'Type du vehicule',
    style: TextStyle(fontWeight: FontWeight.bold),
    ),
    SizedBox(
    width: size.width * 0.7,
    height: size.height * 0.06,
    child:    TextField(//controller: _contrType,
    decoration: InputDecoration(
    enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
    ),
    fillColor: Colors.white,
    filled: true,
    hintText: _utilisateur.vehicule.typevehicule,

    ),
    onChanged: (value) {
    _changement = true ;
    setState(() {
    //_contrType.text = value;
    _utilisateur.vehicule.typevehicule = value;
    });
    },
    )
    ),
    SizedBox(height: 15),
    Text(
    'Matricule',
    style: TextStyle(fontWeight: FontWeight.bold),
    ),
    SizedBox(
    width: size.width * 0.7,
    height: size.height * 0.06,
    child: TextField(//controller: _contrMatricule,
    decoration: InputDecoration(
    enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
    ),
    fillColor: Colors.white,
    filled: true,
    hintText:_utilisateur.vehicule.matricule,

    ),
    onChanged: (value) {
    _changement = true ;
    setState(() {
    //_contrMatricule.text = value;
    _utilisateur.vehicule.matricule = value;
    });
    },
    )
    ),
    SizedBox(height: 15),
    Text(
    'modéle',
    style: TextStyle(fontWeight: FontWeight.bold),
    ),
    SizedBox(
    width: size.width * 0.7,
    height: size.height * 0.06,
    child:  TextField(//controller: _contrModele,
    decoration: InputDecoration(
    enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
    ),
    fillColor: Colors.white,
    filled: true,
    hintText: _utilisateur.vehicule.modele,

    ),
    onChanged: (value) {
    _changement = true ;
    setState(() {
    //_contrModele.text = value;
    _utilisateur.vehicule.modele = value;
    });
    },
    )
    ),
    SizedBox(height: 15),
    Text(
    'Police d\'assurance',
    style: TextStyle(fontWeight: FontWeight.bold),
    ),
    SizedBox(
    width: size.width * 0.7,
    height: size.height * 0.06,
    child:   TextField(//controller: _contrPolice,
    decoration: InputDecoration(
    enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
    ),
    fillColor: Colors.white,
    filled: true,
    hintText: _utilisateur.vehicule.policeAssurance,

    ),
    onChanged: (value) {
    _changement = true ;
    setState(() {
    //_contrPolice.text = value;
    _utilisateur.vehicule.policeAssurance = value;
    });
    },
    )
    ),
    SizedBox(height: 15),
    Text(
    'Nombre de places',
    style: TextStyle(fontWeight: FontWeight.bold),
    ),
    SizedBox(
    width: size.width * 0.7,
    height: size.height * 0.06,
    child:  TextField(//controller: _contrNbPlaces,
    decoration: InputDecoration(
    enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
    ),
    fillColor: Colors.white,
    filled: true,
    hintText: _utilisateur.vehicule.nbPlaces.toString(),

    ),
    onChanged: (value) {
    _changement = true ;
    setState(() {
    //_contrNbPlaces.text = value;
    _utilisateur.vehicule.nbPlaces = int.parse(value);
    });
    },
    )
    ),
    SizedBox(height: 12),
    SizedBox(height: 16),
    ElevatedButton(
    onPressed: () async{
    Navigator.pop(
    context,
    MaterialPageRoute(builder: (context) => Loading()),
    );
    await _baseDeDonnee.modifierUtilisateur(FirebaseAuth.instance.currentUser!.uid, _utilisateur);
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
    content: Text('Modifications avec succes'),
    duration: Duration(seconds: 2),
    ),
    );
    if (_changement){
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
    content: Text('Modifications avec succes'),
    duration: Duration(seconds: 3),
    ),
    );
    Navigator.pop(
    context,
    MaterialPageRoute(builder: (context) => Loading()),
    );
    await _baseDeDonnee.modifierUtilisateur(FirebaseAuth.instance.currentUser!.uid, _utilisateur);
    }else {
    Navigator.pop(
    context,
    MaterialPageRoute(builder: (context) => Loading()),
    );
    }
  },
  child: Text(
  'Valider les modifications',
  style:  TextStyle(
  color: Colors.white),),
  style: ElevatedButton.styleFrom(
  backgroundColor: Colors.blue,
  ),
  ),
  ],
  ),

  ),

  ),
  ),
  );
}
}
