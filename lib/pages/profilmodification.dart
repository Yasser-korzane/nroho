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

  late TextEditingController _contrNom ,
      _contrPrenom;
  TextEditingController _contrMarque = TextEditingController();
  TextEditingController _contrType = TextEditingController();
  TextEditingController _contrMatricule = TextEditingController();
  TextEditingController _contrModele = TextEditingController();
  TextEditingController _contrPolice = TextEditingController();
  TextEditingController _contrNbPlaces = TextEditingController();
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
    //_contrNbPlaces = TextEditingController(text:  widget._utilisateur.vehicule.);
  }

  // Methode pour changer la photo de profil
  final ImagePicker _imagePicker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
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
    if (widget._utilisateur.nom.isEmpty) {
      widget._utilisateur.nom = 'Entrer votre nom';
    }
    if (widget._utilisateur.prenom.isEmpty) {
      widget._utilisateur.prenom = 'Entrer votre prenom';
    }
    if (widget._utilisateur.vehicule.marque.isEmpty) {
      widget._utilisateur.vehicule.marque =
      'Entrez la marque de votre vehicule';
    }
    if (widget._utilisateur.vehicule.typevehicule.isEmpty) {
      widget._utilisateur.vehicule.typevehicule =
      'Entrez le type de votre vehicule';
    }
    if (widget._utilisateur.vehicule.matricule.isEmpty) {
      widget._utilisateur.vehicule.matricule =
      'Entrez la matircule de votre vehicule';
    }
    if (widget._utilisateur.vehicule.modele.isEmpty) {
      widget._utilisateur.vehicule.modele =
      'Entrez le modele de votre vehicule';
    }
    if (widget._utilisateur.vehicule.policeAssurance.isEmpty) {
      widget._utilisateur.vehicule.policeAssurance =
      'Entrez la police d\'assurance de votre vehicule';
    }
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
              SizedBox(height: size.height * 0.033),
              Expanded(
                child: Form(
                  key: _formKey,

                  child:
                  ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      const Text(
                        'Nom',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'poppins',
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.7,
                        // height: size.height * 0.06,
                        child: TextFormField(
                          controller: _contrNom,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'nom',
                            hintStyle: const TextStyle(fontFamily: 'poppins'),
                          ),
                          onChanged: (value) {
                            _changement = true;
                            setState(() {
                              widget._utilisateur.nom = value;
                            });
                          },
                          validator: (input) {
                            List<int> numbers = List.generate(10, (index) => index);
                            if (input == null ) {
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
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'prenom',
                            hintStyle: const TextStyle(fontFamily: 'poppins'),
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
                            if (input == null ) {
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
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'numeroTelephone',
                              hintStyle: const TextStyle(fontFamily: 'poppins'),
                            ),
                            onChanged: (value) {
                              _changement = true;
                              setState(() {
                                //_contrPrenom.text = value;
                                widget._utilisateur.numeroTelephone = value;
                              });
                            },
                            validator: (input) {
                              if (input == null ) {
                                return 'Entrez votre numero de téléphone ';
                              } else if (int.tryParse(input) == null) {
                                return 'numero non valid ';
                              } else if (input.length != 10 &&
                                  input.length != 14 &&
                                  input.length != 13) {
                                return 'nombre de chiffre inferieur a 10 !';
                              } else {
                                if (input.length == 10 &&
                                    !input.startsWith('05') &&
                                    !input.startsWith('06') &&
                                    !input.startsWith('07')) {
                                  return 'le numero ne commance pas avec 05 ou 06 ou 07';
                                }
                                if (input.length == 13 &&
                                    !input.startsWith('*2135') &&
                                    !input.startsWith('*2136') &&
                                    !input.startsWith('*2137')) {
                                  return 'error';
                                }
                                if (input.length == 14 &&
                                    !input.startsWith('002135') &&
                                    !input.startsWith('002136') &&
                                    !input.startsWith('002137')) {
                                  return 'error';
                                }
                              }

                              return null;
                            },
                          )),
                      const SizedBox(height: 25),
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
                          // height: size.height * 0.06,
                          child: TextFormField(
                            //controller: _contrMarque,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: widget._utilisateur.vehicule.marque,
                              hintStyle: const TextStyle(fontFamily: 'poppins'),
                            ),
                            validator:(input){
                              List<int> numbers = List.generate(10, (index) => index);
                              if (input == null ) {
                                return 'Entrez la marque';
                              } else if (input.contains(' ')) {
                                return 'Espace';
                              } else if (numbers.any((number) => input.contains(number.toString()))) {
                                return 'Numbers';
                              }
                              return null;

                            },
                            onChanged: (value) {
                              setState(() {
                                _changement = true;
                                //_contrMarque.text = value;
                                widget._utilisateur.vehicule.marque = value;
                              });
                            },
                          )),
                      const SizedBox(height: 15),
                      const Text(
                        'Type du vehicule',
                        style: TextStyle(
                            fontFamily: 'poppins', fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                          width: size.width * 0.7,
                          // height: size.height * 0.06,
                          child: TextFormField(
                            //controller: _contrType,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: widget._utilisateur.vehicule.typevehicule,
                              hintStyle: const TextStyle(fontFamily: 'poppins'),
                            ),
                            validator: (input){
                              /*  if (input == null || input == '') {
                            return 'Entrez le type de vehicule';
                          } else if (input.contains(' ')) {
                            return 'Espace';
                          }
                          return null;*/
                              List<int> numbers = List.generate(10, (index) => index);
                              if (input == null ) {
                                return 'Entrez le type de vehicule';
                              } else if (input.contains(' ')) {
                                return 'Espace';
                              } else if (numbers
                                  .any((number) => input.contains(number.toString()))) {
                                return 'Numbers';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _changement = true;
                              setState(() {
                                //_contrType.text = value;
                                widget._utilisateur.vehicule.typevehicule = value;
                              });
                            },
                          )),
                      const SizedBox(height: 15),
                      const Text(
                        'Matricule',
                        style: TextStyle(
                            fontFamily: 'poppins', fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                          width: size.width * 0.7,
                          // height: size.height * 0.06,
                          child: TextFormField(
                            //controller: _contrMatricule,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: widget._utilisateur.vehicule.matricule,
                              hintStyle: const TextStyle(fontFamily: 'poppins'),
                            ),
                            validator: (input){
                              if (input == null ) {
                                return 'Entrez le matricule ';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _changement = true;
                              setState(() {
                                //_contrMatricule.text = value;
                                widget._utilisateur.vehicule.matricule = value;
                              });
                            },
                          )),
                      const SizedBox(height: 15),
                      const Text(
                        'Modéle',
                        style: TextStyle(
                            fontFamily: 'poppins', fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                          width: size.width * 0.7,
                          // height: size.height * 0.06,
                          child: TextFormField(
                            //controller: _contrModele,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: widget._utilisateur.vehicule.modele,
                              hintStyle: const TextStyle(fontFamily: 'poppins'),
                            ),
                            validator:(input){

                              return null;

                            },
                            onChanged: (value) {
                              _changement = true;
                              setState(() {
                                //_contrModele.text = value;
                                widget._utilisateur.vehicule.modele = value;
                              });
                            },
                          )),
                      const SizedBox(height: 15),
                      const Text(
                        'Police d\'assurance',
                        style: TextStyle(
                            fontFamily: 'poppins', fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                          width: size.width * 0.7,
                          // height: size.height * 0.06,
                          child: TextFormField(
                            //controller: _contrPolice,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: widget._utilisateur.vehicule.policeAssurance,
                              hintStyle: const TextStyle(fontFamily: 'poppins'),
                            ),
                            validator:(input){
                              if (input == null ) {
                                return 'Entrez la police d\'assurance ';
                              }
                              return null;

                            },
                            onChanged: (value) {
                              _changement = true;
                              setState(() {
                                //_contrPolice.text = value;
                                widget._utilisateur.vehicule.policeAssurance = value;
                              });
                            },
                          )),
                    ],

                  ),

                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {

                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    /* ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );*/
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

                            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                            contentType: ContentType.success,
                            // to configure for material banner
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
                          message: 'verifier vos donnees',

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
