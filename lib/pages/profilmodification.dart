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
<<<<<<< Updated upstream
                    child :Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Identifiant:                                                              $_nom $_prenom',style: TextStyle(color:Colors.grey,fontSize: 12),),
                        Text('Email:                                                       $_email',style: TextStyle(color:Colors.grey,fontSize: 12),),
                        Text('Telephone:                                                                $_telephone',style: TextStyle(color:Colors.grey,fontSize: 12),),
                        /// ****************** Il faut faire une autre methode pour afficher ses informations ********************
=======
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: [
                       Expanded(
                        child:Text('Identifiant:',style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                       ), Expanded(
                        child:Text('$_nom $_prenom',style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                       ),
>>>>>>> Stashed changes
                      ],
                    ),
                    Row(
                      children: [
                    Expanded(
                        child:Text('Email:',style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                       ),
                    Expanded(
                        child:Text('$_email',style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                       ),
                      ],
                    ), Row(
                      children: [
                    Expanded(
                        child:Text('Numero de telephone:',style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                       ),
                    Expanded(
                        child:Text('$_telephone',style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                       ),
                      ],
                    ),


                  ],
                )),
                SizedBox(height: size.height * 0.033),
                Text(
                  'Nom',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
<<<<<<< Updated upstream
                SizedBox(height: 30),
                Text('Nom', style: TextStyle(fontWeight: FontWeight.bold),),



                TextField(

=======
          SizedBox(
            width: size.width * 0.7,
            height: size.height * 0.06,
                child:  TextField(
>>>>>>> Stashed changes
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Entrez votre nom',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _nom = value;
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
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Entrez votre prenom',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _prenom = value;
                    });
                  },
                ),
          ),
                SizedBox(height: size.height * 0.05),

                Text(
                  'Informations du vehicule',
                  style: TextStyle(
                      color: Color(0xff0085FF),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                    textAlign: TextAlign.center
                ),
                SizedBox(height: size.height * 0.02),
                Text(
                  'marque',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
          SizedBox(
            width: size.width * 0.7,
            height: size.height * 0.06,
             child:   TextField(
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
          ),
                SizedBox(height: size.height * 0.02),
                Text(
                  'Type du vehicule',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
          SizedBox(
            width: size.width * 0.7,
            height: size.height * 0.06,
                child:   TextField(
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff004DF6)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff004DF6)),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Entrez le type de votre vehicule',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _type = value;
                    });
                  },
                ),
          ),
                SizedBox(height: size.height * 0.02),
                Text(
                  'Matricule',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
          SizedBox(
            width: size.width * 0.7,
            height: size.height * 0.06,
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff004DF6)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff004DF6)),
                    ),
                    fillColor: Colors.white,
                    filled: true,
<<<<<<< Updated upstream
=======
                    labelText: 'Matricule',
>>>>>>> Stashed changes
                    hintText: 'Entrez le matricule de votre vehicule',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _matricule = value;
                    });
                  },
                ),
          ),
                SizedBox(height: size.height * 0.02),
                Text(
                  'modéle',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
          SizedBox(
            width: size.width * 0.7,
            height: size.height * 0.06,
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff004DF6)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff004DF6)),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Entrez le modele de votre vehicule',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _modele = value;
                    });
                  },
                ),
          ),
                SizedBox(height: size.height * 0.02),
                Text(
                  'Police d\'assurance',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
          SizedBox(
            width: size.width * 0.7,
            height: size.height * 0.06,
                child:  TextField(
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff004DF6)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff004DF6)),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Entrez la Police d\'assurance de votre vehicule',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _policeAssurance = value;
                    });
                  },
                ),
          ),
                SizedBox(height: size.height * 0.02),
                Text(
                  'Nombre de places',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
          SizedBox(
            width: size.width * 0.7,
            height: size.height * 0.06,
                child:  TextField(
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff004DF6)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff004DF6)),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Entrez le nombre de places de votre vehicule',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _nombrePlaces = int.parse(value);
                    });
                  },
                ),
          ),
                SizedBox(height: 12),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _validerModifications,
<<<<<<< Updated upstream
                  child: Text('Valider les modifications',style: TextStyle(color: Colors.white),),
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue),),

=======
                  child: Text('Valider les modifications',  style: TextStyle(
                      color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
>>>>>>> Stashed changes
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/* reste a faire : -Ajouter la bande bleu du haut.


 */
