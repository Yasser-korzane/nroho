import 'package:flutter/material.dart';


class ModifierProfilePage extends StatefulWidget {
  @override
  _ModifierProfilePageState createState() => _ModifierProfilePageState();
}

class _ModifierProfilePageState extends State<ModifierProfilePage> {
  // Initialisation des variables
  String _nom = 'Omar';
  String _prenom = 'Hemmadi';
  String _email = 'omarhemmadi@esi.dz';
  String _telephone = '0123456789';
  String _ancienMotDePasse = '';
  String _nouveauMotDePasse = '';
  String _confirmationMotDePasse = '';
  String _marque = '';
  String _type = '';
  String _matricule = '';
  String _modele = '';
  String _policeAssurance = '';
  int _nombrePlaces = 0;

  // Methode pour changer la photo de profil
  void _changerPhoto() {
    // Implementer la logique pour changer la photo de profil
  }

  // Methode pour sauvegarder les modifications
  void _validerModifications() {
    //  Implementer la logique pour valider les modifications
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                //    Text('Informations du vehicule',style :TextStyle(color: Color(0xff0085FF),fontWeight: FontWeight.bold,fontSize: 16),),
                //Text('changer votre photo',TextStyle(color:Color(0xff271BAB),),),
              ),
              SizedBox(height: 12),
              /*     <svg width="360" height="127" viewBox="0 0 360 127" fill="none" xmlns="http://www.w3.org/2000/svg">
      <rect x="-15" y="-5" width="390" height="132" rx="30" fill="#0085FF"/>
      </svg>  */

              Align(
                alignment: Alignment.center,
                child:  Text(
                  'changer votre photo',
                  style: TextStyle(color: Color(0xff271BAB),),),
              ),
              Card(
                  child :Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('Identifiant:                                                              $_nom $_prenom',style: TextStyle(color:Colors.grey,fontSize: 12),),
                      Text('Email:                                                       $_email',style: TextStyle(color:Colors.grey,fontSize: 12),),

                      Text('Telephone:                                                                      $_telephone',style: TextStyle(color:Colors.grey,fontSize: 12),),

                    ],
                  )
              ),



              SizedBox(height: 30),
              Text('Nom', style: TextStyle(fontWeight: FontWeight.bold),),



              TextField(

                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  fillColor: Colors.white,
                  filled: true,

                  labelText: 'Nom',
                  hintText: 'Entrez votre nom',

                ),
                onChanged: (value) {
                  setState(() {
                    _nom = value;
                  });
                },
              ),
              SizedBox(height: 25),
              Text('Prenom', style: TextStyle(fontWeight: FontWeight.bold),),
              TextField(

                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  fillColor: Colors.white,
                  filled: true,

                  labelText: 'prenom',
                  hintText: 'Entrez votre prenom',

                ),
                onChanged: (value) {
                  setState(() {
                    _prenom = value;
                  });
                },
              ),

              SizedBox(height: 25),
              Text('Ancien mot de passe',
                style: TextStyle(fontWeight: FontWeight.bold),),

              TextField(

                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  fillColor: Colors.white,
                  filled: true,

                  labelText: 'Ancien mot de passe',
                  hintText: 'Entrez votre ancien mot de passe',

                ),
                onChanged: (value) {
                  setState(() {
                    _ancienMotDePasse = value;
                  });
                },
              ),


              SizedBox(height: 25),
              Text('Nouveau mot de passe ',
                style: TextStyle(fontWeight: FontWeight.bold),),

              TextField(
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  fillColor: Colors.white,
                  filled: true,

                  labelText: 'Nouveau mot de passe',
                  hintText: 'Entrez votre nouveau mot de passe',

                ),
                onChanged: (value) {
                  setState(() {
                    _nouveauMotDePasse = value;
                  });
                },
              ),


              SizedBox(height: 40),
              Text('Informations du vehicule', style: TextStyle(
                  color: Color(0xff0085FF),
                  fontWeight: FontWeight.bold,
                  fontSize: 16),),

              SizedBox(height: 10),
              Text('marque', style: TextStyle(fontWeight: FontWeight.bold),),
              TextField(
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff004DF6)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff004DF6)),
                  ),
                  fillColor: Colors.white,
                  filled: true,

                  // labelText: 'Marque',
                  hintText: 'Entrez la marque de votre vehicule',

                ),
                onChanged: (value) {
                  setState(() {
                    _marque = value;
                  });
                },
              ),
              SizedBox(height: 15),
              Text(
                'Type du vehicule', style: TextStyle(fontWeight: FontWeight.bold),),
              TextField(
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff004DF6)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff004DF6)),
                  ),
                  fillColor: Colors.white,
                  filled: true,

                  labelText: 'Type',
                  hintText: 'Entrez le type de votre vehicule',

                ),
                onChanged: (value) {
                  setState(() {
                    _type = value;
                  });
                },
              ),
              SizedBox(height: 15),
              Text('Matricule', style: TextStyle(fontWeight: FontWeight.bold),),
              TextField(
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff004DF6)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff004DF6)),
                  ),
                  fillColor: Colors.white,
                  filled: true,

                  labelText: 'Matricule',
                  hintText: 'Entrez le matricule de votre vehicule',

                ),
                onChanged: (value) {
                  setState(() {
                    _matricule = value;
                  });
                },
              ),
              SizedBox(height: 15),
              Text('modéle', style: TextStyle(fontWeight: FontWeight.bold),),
              TextField(
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff004DF6)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff004DF6)),
                  ),
                  fillColor: Colors.white,
                  filled: true,

                  labelText: 'Modéle',
                  hintText: 'Entrez le modele de votre vehicule',

                ),
                onChanged: (value) {
                  setState(() {
                    _modele = value;
                  });
                },
              ),
              SizedBox(height: 15),
              Text('Police d\'assurance',
                style: TextStyle(fontWeight: FontWeight.bold),),
              TextField(
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff004DF6)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff004DF6)),
                  ),
                  fillColor: Colors.white,
                  filled: true,

                  labelText: 'Police d\'assurance',
                  hintText: 'Entrez la Police d\'assurance de votre vehicule',

                ),
                onChanged: (value) {
                  setState(() {
                    _policeAssurance = value;
                  });
                },
              ),
              SizedBox(height: 15),
              Text(
                'Nombre de places', style: TextStyle(fontWeight: FontWeight.bold),),
              TextField(
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff004DF6)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff004DF6)),
                  ),
                  fillColor: Colors.white,
                  filled: true,

                  labelText: 'Nombre de places',
                  hintText: 'Entrez le nombre de places de votre vehicule',

                ),
                onChanged: (value) {
                  setState(() {
                    _nombrePlaces = int.parse(value);
                  });
                },
              ),
              SizedBox(height: 12),


              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _validerModifications,
                child: Text('Valider les modifications'),

              ),
            ],
          ),

        ),

      ),);
  }
}
/* reste a faire : -Ajouter la bande bleu du haut.
                   -Separer identifiant Email Telephone en utilisant Row et non pas l'espace

 */

