import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../AppClasses/Utilisateur.dart';
import '../Services/base de donnee.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class ModifierProfilePage extends StatefulWidget {
  final Utilisateur _utilisateur;

  const ModifierProfilePage(this._utilisateur, {super.key});

  @override
  _ModifierProfilePageState createState() => _ModifierProfilePageState();
}

class _ModifierProfilePageState extends State<ModifierProfilePage> {
  final BaseDeDonnee _baseDeDonnee = BaseDeDonnee();
  bool _changement = false;
  String imageUrl = '';
  RegExp regExpNomPrenom = RegExp(r'^[a-zA-Z\u0600-\u06FF ]+$');
  RegExp regExp = RegExp(r'^[a-zA-Z0-9_]+$');
  late TextEditingController _contrNom , _contrPrenom;
  TextEditingController _contrMarque = TextEditingController();
  TextEditingController _contrType = TextEditingController();
  TextEditingController _contrMatricule = TextEditingController();
  TextEditingController _contrModele = TextEditingController();
  TextEditingController _contrPolice = TextEditingController();
  TextEditingController _contrNum = TextEditingController();

  @override
  void initState() {
    super.initState();
    _contrNom = TextEditingController(text:  widget._utilisateur.nom);
    _contrPrenom= TextEditingController(text:  widget._utilisateur.prenom);
    _contrNum= TextEditingController(text:  widget._utilisateur.numeroTelephone);
    _contrMarque = TextEditingController(text:  widget._utilisateur.vehicule.marque);
    _contrType = TextEditingController(text:  widget._utilisateur.vehicule.typevehicule);
    _contrMatricule = TextEditingController(text:  widget._utilisateur.vehicule.matricule);
    _contrModele = TextEditingController(text:  widget._utilisateur.vehicule.modele);
    _contrPolice = TextEditingController(text:  widget._utilisateur.vehicule.policeAssurance);
  }

  // Methode pour changer la photo de profil
  final ImagePicker _imagePicker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body:Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: SizedBox(
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
                  onPressed: () async {
                    /// 1) get the image from gallery
                    XFile? file = await _imagePicker.pickImage(
                        source: ImageSource.gallery);

                    /// 2) upload the image in firebase storage
                    if (file == null) return;
                    Reference referenceRoot = FirebaseStorage.instance.ref();
                    Reference referenceDirImages =
                    referenceRoot.child('images');
                    Reference referenceImageToUpload = referenceDirImages
                        .child(FirebaseAuth.instance.currentUser!.uid);
                    try {
                      await referenceImageToUpload.putFile(File(file.path));
                      imageUrl =
                      await referenceImageToUpload.getDownloadURL();
                      setState(() {
                        widget._utilisateur.imageUrl = imageUrl;
                      });
                      await _baseDeDonnee.updateUtilisateurImage(
                          FirebaseAuth.instance.currentUser!.uid, imageUrl);
                    } catch (error) {
                      throw Exception('Failed to set the image');
                    }
                  },
                  child: const Text(
                    'changer votre photo',
                    style: TextStyle(
                      fontFamily: 'poppins',
                      color: Color(0xff271BAB),
                    ),
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Text(
                              'Identifiant:',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontFamily: 'poppins',
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              widget._utilisateur.identifiant,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontFamily: 'poppins',
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6,),
                      Row(
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Text(
                              'Email: ',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontFamily: 'poppins',
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              widget._utilisateur.email,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontFamily: 'poppins',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.033),
              Expanded(
                child: Form(
                  key: _formKey,
                  child:
                  ListView(
                    children: [
                      const Text(
                        'Nom',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'poppins',
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.7,
                        child: TextFormField(
                          controller: _contrNom,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Nom',
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
                            if (input == null|| input == '') {
                              return 'Veuillez entrez votre nom';
                            } else if (numbers.any((number) => input.contains(number.toString()))) {
                              return 'Le nom ne doit pas contenir des nombres';
                            }else if (!regExpNomPrenom.hasMatch(input)){
                              return 'Le nom non valide' ;
                            }
                            else if (input.length >= 20){
                              return 'Nom trop long' ;
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      const Text(
                        'Prénom',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'poppins',
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.7,
                        // height: size.height * 0.06,
                        child: TextFormField(
                          controller: _contrPrenom,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'prénom',
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
                            if (input == null|| input == '') {
                              return 'Veuillez entrez votre prénom';
                            } else if (numbers.any((number) => input.contains(number.toString()))) {
                              return 'Le prénom ne doit pas contenir des nombres';
                            }else if (!regExpNomPrenom.hasMatch(input)){
                              return 'Le prénom est non valide' ;
                            }
                            else if (input.length >= 20){
                              return 'Prénom trop long' ;
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      const Text(
                        'Numéro de télephone',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'poppins',
                        ),
                      ),
                      SizedBox(
                          width: size.width * 0.7,
                          // height: size.height * 0.06,
                          child: TextFormField(
                            controller: _contrNum,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'NumeroTelephone',
                              hintStyle: TextStyle(fontFamily: 'poppins'),
                            ),
                            onChanged: (value) {
                              _changement = true;
                              setState(() {
                                widget._utilisateur.numeroTelephone = value;
                              });
                            },
                            validator: (input) {
                              if (input == null || input == '') {
                                return 'Veuillez entrez votre numéro de téléphone';
                              } else if (int.tryParse(input) == null) {
                                return 'Numéro de téléphone est non valide';
                              } else if (input.length != 10) {
                                return 'Nombre de chiffre doit étre égale à 10 !';
                              } else if (
                              !(
                                  input.startsWith('05') ||
                                      input.startsWith('06') ||
                                      input.startsWith('07') ) ) {
                                return 'Le numéro doit commencer par \'05\' ou \'06\' ou \'07\'';
                              }
                              return null;
                            },
                          )),
                      const SizedBox(height: 40),
                      const Text(
                        'Informations du vehicule',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            color: Color(0xff0085FF),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Marque',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'poppins',
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.7,
                        child: TextFormField(
                          controller: _contrMarque,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Marque',
                            hintStyle: TextStyle(fontFamily: 'poppins'),
                          ),
                          onChanged: (value) {
                            _changement = true;
                            setState(() {
                              widget._utilisateur.vehicule.marque = value;
                            });
                          },
                          validator: (input) {
                            if (input == null || input.isEmpty){
                              return 'Veuillez entrer la marque' ;
                            }
                            else if (!regExp.hasMatch(input)){
                              return 'La marque est non valide' ;
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Type du vehicule',
                        style: TextStyle(
                            fontFamily: 'poppins', fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: size.width * 0.7,
                        child: TextFormField(
                          controller: _contrType,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Type de vehicule',
                            hintStyle: TextStyle(fontFamily: 'poppins'),
                          ),
                          onChanged: (value) {
                            _changement = true;
                            setState(() {
                              widget._utilisateur.vehicule.typevehicule = value;
                            });
                          },
                          validator: (input) {
                            if (input == null || input.isEmpty){
                              return 'Veuillez entrer le type de vehicule' ;
                            }
                            else if (!regExp.hasMatch(input)){
                              return 'Le type de vehicule est non valide' ;
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Matricule',
                        style: TextStyle(
                            fontFamily: 'poppins', fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: size.width * 0.7,
                        child: TextFormField(
                          controller: _contrMatricule,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Matricule',
                            hintStyle: TextStyle(fontFamily: 'poppins'),
                          ),
                          onChanged: (value) {
                            _changement = true;
                            setState(() {
                              widget._utilisateur.vehicule.matricule = value;
                            });
                          },
                          validator: (input) {
                            if (input == null || input.isEmpty){
                              return 'Veuillez entrer le matricule' ;
                            }
                            else if (!regExp.hasMatch(input)){
                              return 'Le matricule est non valide' ;
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Modéle',
                        style: TextStyle(
                            fontFamily: 'poppins', fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: size.width * 0.7,
                        child: TextFormField(
                          controller: _contrModele,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Modèle',
                            hintStyle: TextStyle(fontFamily: 'poppins'),
                          ),
                          onChanged: (value) {
                            _changement = true;
                            setState(() {
                              widget._utilisateur.vehicule.modele = value;
                            });
                          },
                          validator: (input) {
                            if (input == null || input.isEmpty){
                              return 'Veuillez entrer le modèle' ;
                            }
                            else if (!regExp.hasMatch(input)){
                              return 'Le modèle est non valide' ;
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Police d\'assurance',
                        style: TextStyle(
                            fontFamily: 'poppins', fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: size.width * 0.7,
                        child: TextFormField(
                          controller: _contrPolice,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Police d\'assurance',
                            hintStyle: TextStyle(fontFamily: 'poppins'),
                          ),
                          onChanged: (value) {
                            _changement = true;
                            setState(() {
                              widget._utilisateur.vehicule.policeAssurance = value;
                            });
                          },
                          validator: (input) {
                            if (input == null || input.isEmpty){
                              return 'Veuillez entrer la police d\'assurance' ;
                            }
                            else if (!regExp.hasMatch(input)){
                              return 'La police d\'assurance est non valide' ;
                            }
                          },
                        ),
                      ),
                    ],

                  ),

                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (_changement) {
                      await _baseDeDonnee.modifierUtilisateur(
                          FirebaseAuth.instance.currentUser!.uid,
                          widget._utilisateur);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 3),
                          content: AwesomeSnackbarContent(
                            title: 'Succés!!',
                            message: 'Modification effectué avec avec succès',
                            contentType: ContentType.success,
                            inMaterialBanner: true,
                          ),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                      );
                    }
                    Navigator.pop(
                      context,
                    );
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 3),
                        content: AwesomeSnackbarContent(
                          title: 'oh Erreurs!!',
                          message: 'Vérifier votre données',
                          contentType: ContentType.failure,
                          inMaterialBanner: true,
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'Valider les modifications',
                  style:
                  TextStyle(fontFamily: 'poppins', color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
