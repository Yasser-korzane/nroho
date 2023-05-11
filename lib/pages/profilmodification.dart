import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../AppClasses/Utilisateur.dart';
import '../Services/base de donnee.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart'; 
class ModifierProfilePage extends StatefulWidget {
  Utilisateur _utilisateur;
  ModifierProfilePage(this._utilisateur);
  @override
  _ModifierProfilePageState createState() => _ModifierProfilePageState();
}

class _ModifierProfilePageState extends State<ModifierProfilePage> {
  final BaseDeDonnee _baseDeDonnee = BaseDeDonnee();
  bool _changement = false;
  String imageUrl = '';

  /*TextEditingController _contrNom = TextEditingController();
  TextEditingController _contrPrenom = TextEditingController();
  TextEditingController _contrMarque = TextEditingController();
  TextEditingController _contrType = TextEditingController();
  TextEditingController _contrMatricule = TextEditingController();
  TextEditingController _contrModele = TextEditingController();
  TextEditingController _contrPolice = TextEditingController();
  TextEditingController _contrNbPlaces = TextEditingController();*/
  // Methode pour changer la photo de profil
  ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    /*_contrNom.text = widget._utilisateur.nom;
    _contrPrenom.text = widget._utilisateur.prenom;
    _contrMarque.text = widget._utilisateur.vehicule.marque;
    _contrType.text = widget._utilisateur.vehicule.typevehicule;
    _contrMatricule.text = widget._utilisateur.vehicule.matricule;
    _contrModele.text = widget._utilisateur.vehicule.modele;
    _contrPolice.text = widget._utilisateur.vehicule.policeAssurance;
    _contrNbPlaces.text = widget._utilisateur.vehicule.nbPlaces.toString();*/
    if (widget._utilisateur.nom.isEmpty) widget._utilisateur.nom = 'Entrer votre nom';
    if (widget._utilisateur.prenom.isEmpty)
      widget._utilisateur.prenom = 'Entrer votre prenom';
    if (widget._utilisateur.vehicule.marque.isEmpty)
      widget._utilisateur.vehicule.marque = 'Entrez la marque de votre vehicule';
    if (widget._utilisateur.vehicule.typevehicule.isEmpty)
      widget._utilisateur.vehicule.typevehicule = 'Entrez le type de votre vehicule';
    if (widget._utilisateur.vehicule.matricule.isEmpty)
      widget._utilisateur.vehicule.matricule = 'Entrez la matircule de votre vehicule';
    if (widget._utilisateur.vehicule.modele.isEmpty)
      widget._utilisateur.vehicule.modele = 'Entrez le modele de votre vehicule';
    if (widget._utilisateur.vehicule.policeAssurance.isEmpty)
      widget._utilisateur.vehicule.policeAssurance =
          'Entrez la police d\'assurance de votre vehicule';
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
                  child :SizedBox(
                    width: screenHeight * 0.15,
                    height: screenHeight * 0.15,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(widget._utilisateur.imageUrl),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.014),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed:() async{
                      /// 1) get the image from gallery
                      XFile? file = await _imagePicker.pickImage(source: ImageSource.gallery);
                      /// 2) upload the image in firebase storage
                      if (file == null) return;
                      Reference referenceRoot = FirebaseStorage. instance.ref();
                      Reference referenceDirImages=referenceRoot.child('images');
                      Reference referenceImageToUpload = referenceDirImages.child(FirebaseAuth.instance.currentUser!.uid);
                      try{
                        await referenceImageToUpload.putFile(File(file.path));
                        imageUrl = await referenceImageToUpload.getDownloadURL();
                        setState(() {
                          widget._utilisateur.imageUrl = imageUrl ;
                        });
                        await _baseDeDonnee.updateUtilisateurImage(FirebaseAuth.instance.currentUser!.uid, imageUrl);
                      }catch(error) {
                        throw Exception('Failed to set the image');
                      }
                    },
                    child : Text('changer votre photo',style: TextStyle(
                      fontFamily: 'poppins',
                      color: Color(0xff271BAB),
                    ),),
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
                            flex : 1,
                            child: Text(
                              'Identifiant:',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12,                      fontFamily: 'poppins',
                                  ),
                            ),
                          ),
                          Expanded(
                            flex : 2,
                            child: Text(
                              widget._utilisateur.identifiant,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12,                      fontFamily: 'poppins',
                                  ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex : 1,
                            child: Text(
                              'Email: ',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12,                      fontFamily: 'poppins',
                                  ),
                            ),
                          ),
                          Expanded(
                            flex : 2,
                            child: Text(
                              widget._utilisateur.email,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12 ,                     fontFamily: 'poppins',
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.033),
                Text(
                  'Nom',
                  style: TextStyle(fontWeight: FontWeight.bold,                      fontFamily: 'poppins',
                  ),
                ),
                SizedBox(
                  width: size.width * 0.7,
                  height: size.height * 0.06,
                  child: TextFormField(
                    //controller: _contrNom,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(12)),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: widget._utilisateur.nom,
                      hintStyle: TextStyle(fontFamily: 'poppins'),
                    ),
                    onChanged: (value) {
                      _changement = true;
                      setState(() {
                        widget._utilisateur.nom = value;
                      });
                    },
                     validator: (input) {
                    
                     List<int> numbers = List.generate(10, (index) => index);
                      if (input == null) {
                        return 'Entrez votre nom';
                      } else if (input.contains(' ')) {
                        return 'Espace';
                      } else if (numbers
                          .any((number) => input.contains(number.toString()))) {
                        return 'Numbers';
                      }

                      return null;
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Text(
                  'Prénom',
                  style: TextStyle(fontWeight: FontWeight.bold,                      fontFamily: 'poppins',
                  ),
                ),
                SizedBox(
                    width: size.width * 0.7,
                    height: size.height * 0.06,
                    child: TextFormField(
                      //controller: _contrPrenom,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(12)),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: widget._utilisateur.prenom,
                        hintStyle: TextStyle(fontFamily: 'poppins'),

                      ),
                      onChanged: (value) {
                        _changement = true;
                        setState(() {
                          //_contrPrenom.text = value;
                          widget._utilisateur.prenom = value;
                        });
                      },
                      validator: (input) {
                    
                     List<int> numbers = List.generate(10, (index) => index);
                      if (input == null) {
                        return 'Entrez votre prenom';
                      } else if (input.contains(' ')) {
                        return 'Espace';
                      } else if (numbers
                          .any((number) => input.contains(number.toString()))) {
                        return 'Numbers';
                      }

                      return null;
                    },
                      
                    ),
                    ),
                SizedBox(height: size.height * 0.02),
                Text(
                  'Numéro de télephone',
                  style: TextStyle(fontWeight: FontWeight.bold,                      fontFamily: 'poppins',
                  ),
                ),
                SizedBox(
                    width: size.width * 0.7,
                    height: size.height * 0.06,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(12)),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: widget._utilisateur.numeroTelephone,
                        hintStyle: TextStyle(fontFamily: 'poppins'),

                      ),
                      onChanged: (value) {
                        _changement = true;
                        setState(() {
                          //_contrPrenom.text = value;
                          widget._utilisateur.numeroTelephone = value;
                        });
                      },
                       validator: (input) {
                      if (input == null) {
                        return 'Entrez votre numero de téléphone ';
                      } else if (int.tryParse(input) == null) {
                        return 'numero non valid ';
                      }
                      else if (input.length != 10 &&  input.length != 14 && input.length != 13) {
                        return 'nombre de chiffre inferieur a 10 !';
                      } else {
                        if (input.length == 10 && !input.startsWith('05') &&  !input.startsWith('06') && !input.startsWith('07')) {
                          return 'le numero ne commance pas avec 05 ou 06 ou 07';
                        }
                        if (input.length == 13 && !input.startsWith('*2135') &&  !input.startsWith('*2136') && !input.startsWith('*2137')) {
                          return 'error';
                        }
                        if (input.length == 14 && !input.startsWith('002135') &&  !input.startsWith('002136') && !input.startsWith('002137')) {
                          return 'error';
                        }
                      }

                      return null;
                    },

                      
                    )),
                SizedBox(height: 25),
                SizedBox(height: 40),
                Text(
                  'Informations du vehicule',
                  style: TextStyle(
                      fontFamily: 'poppins',
                      color: Color(0xff0085FF),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  'Marque',
                  style: TextStyle(fontWeight: FontWeight.bold,                      fontFamily: 'poppins',
                  ),
                ),
                SizedBox(
                    width: size.width * 0.7,
                    height: size.height * 0.06,
                    child: TextField(
                      //controller: _contrMarque,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(12)),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: widget._utilisateur.vehicule.marque,
                        hintStyle: TextStyle(fontFamily: 'poppins'),

                      ),
                      onChanged: (value) {
                        setState(() {
                          _changement = true;
                          //_contrMarque.text = value;
                          widget._utilisateur.vehicule.marque = value;
                        });
                      },
                    )),
                SizedBox(height: 15),
                Text(
                  'Type du vehicule',
                  style: TextStyle(                      fontFamily: 'poppins',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                    width: size.width * 0.7,
                    height: size.height * 0.06,
                    child: TextField(
                      //controller: _contrType,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(12)),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: widget._utilisateur.vehicule.typevehicule,
                        hintStyle: TextStyle(fontFamily: 'poppins'),

                      ),
                      onChanged: (value) {
                        _changement = true;
                        setState(() {
                          //_contrType.text = value;
                          widget._utilisateur.vehicule.typevehicule = value;
                        });
                      },
                    )),
                SizedBox(height: 15),
                Text(
                  'Matricule',
                  style: TextStyle(                      fontFamily: 'poppins',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                    width: size.width * 0.7,
                    height: size.height * 0.06,
                    child: TextField(
                      //controller: _contrMatricule,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(12)),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: widget._utilisateur.vehicule.matricule,
                        hintStyle: TextStyle(fontFamily: 'poppins'),

                      ),
                      onChanged: (value) {
                        _changement = true;
                        setState(() {
                          //_contrMatricule.text = value;
                          widget._utilisateur.vehicule.matricule = value;
                        });
                      },
                    )),
                SizedBox(height: 15),
                Text(
                  'Modéle',
                  style: TextStyle(                      fontFamily: 'poppins',
                      fontWeight: FontWeight.bold),
                ),
                
                SizedBox(
                    width: size.width * 0.7,
                    height: size.height * 0.06,
                    child: TextField(
                      //controller: _contrModele,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(12)),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: widget._utilisateur.vehicule.modele,
                        hintStyle: TextStyle(fontFamily: 'poppins'),

                      ),
                      onChanged: (value) {
                        _changement = true;
                        setState(() {
                          //_contrModele.text = value;
                          widget._utilisateur.vehicule.modele = value;
                        });
                      },
                    )),
                SizedBox(height: 15),
                Text(
                  'Police d\'assurance',
                  style: TextStyle(                      fontFamily: 'poppins',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                    width: size.width * 0.7,
                    height: size.height * 0.06,
                    child: TextField(
                      //controller: _contrPolice,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: widget._utilisateur.vehicule.policeAssurance,
                        hintStyle: TextStyle(fontFamily: 'poppins'),

                      ),
                      onChanged: (value) {
                        _changement = true;
                        setState(() {
                          //_contrPolice.text = value;
                          widget._utilisateur.vehicule.policeAssurance = value;
                        });
                      },
                    )),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_changement) {
                      await _baseDeDonnee.modifierUtilisateur(FirebaseAuth.instance.currentUser!.uid, widget._utilisateur);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          //content: Text('Modification effectué avec avec succès'),
                          //duration: Duration(seconds: 3),
                           duration: const Duration(seconds: 4),
                    content: AwesomeSnackbarContent(
                    title: 'bravo!!',
                    message:
                        'Modification effectué avec avec succès',

                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                    contentType: ContentType.failure,
                    // to configure for material banner
                    inMaterialBanner: true,
                  ),
 behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  elevation: 0,


                        ),
                      );
                    }
                    Navigator.pop(context,);
                  },
                  child: Text(
                    'Valider les modifications',
                    style: TextStyle(                      fontFamily: 'poppins',
                        color: Colors.white),
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
