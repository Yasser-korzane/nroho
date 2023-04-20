import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Services/base de donnee.dart';

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
  File _image = File('assets/images/logo.png');

  void pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    var _image = await
    imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = _image;
    });
  }

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
                        backgroundImage: _image ==null ? null : FileImage(_image),
            ),
                  ),
                ),
                SizedBox(height: size.height * 0.014),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(
                        color: Color(0xff271BAB),
                      ),
                    ),
                    onPressed: pickImage,
                    child: Text('changer votre photo'),
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
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '$_nom $_prenom',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Email:',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '$_email',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Numero de telephone:',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '$_telephone',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
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
                      hintText: 'Entrez votre nom',
                    ),
                    onChanged: (value) {
                      _changement = true ;
                      setState(() {
                        _nom = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.02),
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
                      onChanged: (value) {
                        _changement = true ;
                        setState(() {
                          //_contrPrenom.text = value;
                          _utilisateur.prenom = value;
                        });
                      },
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
                  child: TextField(
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff004DF6)),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _changement = true ;
                          //_contrMarque.text = value;
                          _utilisateur.vehicule.marque = value;
                        });
                      },
                    )
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
                SizedBox(height: 15),
                Text(
                  'Type du vehicule',
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
                      onChanged: (value) {
                        _changement = true ;
                        setState(() {
                          //_contrType.text = value;
                          _utilisateur.vehicule.typevehicule = value;
                        });
                      },
                    )
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
                SizedBox(height: 15),
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
                      onChanged: (value) {
                        _changement = true ;
                        setState(() {
                          //_contrMatricule.text = value;
                          _utilisateur.vehicule.matricule = value;
                        });
                      },
                    )
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff004DF6)),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Entrez le matricule de votre vehicule',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _matricule = value;
                      });
                    },
                  ),
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
                SizedBox(height: 15),
                Text(
                  'Police d\'assurance',
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
                      onChanged: (value) {
                        _changement = true ;
                        setState(() {
                          //_contrPolice.text = value;
                          _utilisateur.vehicule.policeAssurance = value;
                        });
                      },
                    )
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff004DF6)),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText:
                          'Entrez la Police d\'assurance de votre vehicule',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _policeAssurance = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Nombre de places',
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
                      onChanged: (value) {
                        _changement = true ;
                        setState(() {
                          //_contrNbPlaces.text = value;
                          _utilisateur.vehicule.nbPlaces = int.parse(value);
                        });
                      },
                    )
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
                  child: Text(
                    'Valider les modifications',
                    style: TextStyle(color: Colors.white),
                  ),
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
