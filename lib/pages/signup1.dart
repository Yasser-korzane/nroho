import 'package:appcouvoiturage/Services/auth.dart';
import 'package:appcouvoiturage/Services/base%20de%20donnee.dart';
import 'package:appcouvoiturage/pages/Verification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../AppClasses/Evaluation.dart';
import '../AppClasses/Utilisateur.dart';
import '../AppClasses/Vehicule.dart';
import 'package:appcouvoiturage/Shared/lodingEffect.dart';
import 'package:appcouvoiturage/pages/connexion.dart';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class Sinup extends StatefulWidget {
  const Sinup({super.key});

  @override
  State<Sinup> createState() => _SinupState();
}

class _SinupState extends State<Sinup> {
  var _isObscured;
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isObscured = true;
    timer =
        Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  final BaseDeDonnee _baseDeDonnee = BaseDeDonnee();

  /// ********************************************* Les Fonctions *********************************************
  Utilisateur creerUtilisateurApresSignUp(String identifiant, String nom,
      String prenom, String email, String motDePasse, String numero,String fcmtoken) {
    return Utilisateur(
        identifiant,
        nom,
        prenom,
        email,
        motDePasse,
        numero,
        Evaluation([], 5, 0),
        Vehicule("", "", "", "", ""),
        false,
        [],
        [],
        [],
        [],
        '',
        fcmtoken);
  }

  /** ************************************************************************************************** **/
  /// *********************************** Les controlleurs ********************************************** *
  final TextEditingController _controllerNom = TextEditingController();
  final TextEditingController _controllerPrenom = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerMotDePasse = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();

  /// ************************************************************************************************** *

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    const double defaultPadding = 10;

    final AuthService auth = AuthService();
    return Scaffold(
        body: SingleChildScrollView(
          child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                  SizedBox(
                    height: screenHeight * 0.17,
                  ),
                  Container(
                    child: const Center(
                      child: Text(
                        "Inscription",
                        style: TextStyle(
                            color: Color.fromARGB(255, 79, 77, 77),
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins'),
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Container(
                      margin: EdgeInsets.only(
                          left: screenWidth * 0.01, right: screenWidth * 0.01),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: screenHeight * 0.06,
                          ),
                          TextFormField(
                            style: const TextStyle(fontFamily: 'Poppins'),
                            controller: _controllerNom,
                            keyboardType: TextInputType.name,
                            /*validator: (input) {
                                  if (input == null) {
                                    return 'Entrez votre nom ';
                                  } else {
                                    return null;
                                  }
                                },*/

                            validator: (input) {
                              print(input);
                              List<int> numbers = List.generate(10, (index) => index);
                              if (input == null|| input == '') {
                                return 'Entrez votre nom';
                              } else if (input.contains(' ')) {
                                return 'Espace';
                              } else if (numbers
                                  .any((number) => input.contains(number.toString()))) {
                                return 'Numbers';
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.person_outline_outlined,
                                color: Colors.black,
                                size: 20,
                              ),
                              //border: OutlineInputBorder(),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),

                              labelText: 'Nom',
                              labelStyle: const TextStyle(fontFamily: 'Poppins'),
                              hintText: 'Enterez votre nom',
                              hintStyle: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14,
                                  fontFamily: 'Poppins'),
                              /* color: Colors.grey[800],
                                        fontSize: 14,
                                      fontFamily: 'Poppins'*
                                    ),*/
                              fillColor: Colors.grey.shade100,
                              filled: true,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.013,
                          ),
                          TextFormField(
                            style: const TextStyle(fontFamily: 'Poppins'),
                            controller: _controllerPrenom,
                            keyboardType: TextInputType.name,
                            /* validator: (input) {
                                  if (input == null) {
                                    return 'Entrez votre prenom';
                                  } else {
                                    return null;
                                  }
                                },*/
                            validator: (input) {
                              List<int> numbers = List.generate(10, (index) => index);
                              if (input == null || input == '') {
                                return 'Entrez votre prenom';
                              } else if (input.contains(' ')) {
                                return 'Espace';
                              } else if (numbers
                                  .any((number) => input.contains(number.toString()))) {
                                return 'Numbers';
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.person_outline_outlined,
                                color: Colors.black,
                                size: 20,
                              ),
                              //border: OutlineInputBorder(),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),

                              labelText: 'Prénom',
                              labelStyle: const TextStyle(fontFamily: 'Poppins'),
                              hintText: 'Entrez votre prénom',
                              hintStyle: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14,
                                  fontFamily: 'Poppins'),
                              fillColor: Colors.grey.shade100,
                              filled: true,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.013,
                          ),
                          TextFormField(
                            controller: _controllerPhone,
                            keyboardType: TextInputType.phone,
                            /*validator: (input) {
                                  if (input == null) {
                                    return 'Entrez votre numero de téléphone ';
                                  } else {
                                    return null;
                                  }
                                },*/
                            validator: (input) {
                              if (input == null || input == '') {
                                return 'Entrez votre numero de téléphone ';
                              } else if (int.tryParse(input) == null) {
                                return 'numéro non valid ';
                              } else if (input.length != 10 &&
                                  input.length != 14 &&
                                  input.length != 13) {
                                return 'nombre de chiffre inférieur a 10 !';
                              } else {
                                if (input.length == 10 &&
                                    !input.startsWith('05') &&
                                    !input.startsWith('06') &&
                                    !input.startsWith('07')) {
                                  return 'le numéro ne commance que avec 05 ou 06 ou 07';
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
                                  return 'erreur';
                                }
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.phone,
                                color: Colors.black,
                                size: 20,
                              ),
                              //border: OutlineInputBorder(),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),

                              labelText: 'Numéro de téléphone',
                              labelStyle: const TextStyle(fontFamily: 'Poppins'),
                              hintText: 'Entrez votre numéro de téléphone',
                              hintStyle: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14,
                                  fontFamily: 'Poppins'),
                              /*  color: Colors.grey[800],
                                      fontSize: 14,
                                      fontFamily: 'Poppins'
                                  ),*/
                              fillColor: Colors.grey.shade100,
                              filled: true,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.013,
                          ),
                          TextFormField(
                            style: const TextStyle(fontFamily: 'Poppins'),
                            controller: _controllerEmail,
                            keyboardType: TextInputType.emailAddress,
                            /* validator: (input) {
                                  if (input == null) {
                                    return 'Entrez votre adresse mail ';
                                  } else {
                                    return null;
                                  }
                                },*/
                            validator: (input) {
                              if (input == null|| input == '') {
                                return 'Entrez votre adresse email ';
                              } else if (!RegExp(
                                  r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,7}\b')
                                  .hasMatch(input)) {
                                return 'Not valid email';
                              } else if (!input.endsWith('@esi.dz')) {
                                return 'only Email esi allowd';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: Colors.black,
                                size: 20,
                              ),
                              //border: OutlineInputBorder(),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),

                              labelText: 'Email',
                              labelStyle: const TextStyle(fontFamily: 'Poppins'),
                              hintText: 'Entrez votre adresse mail de l\'esi',
                              hintStyle: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14,
                                  fontFamily: 'Poppins'),
                              /* color: Colors.grey[800],
                                      fontSize: 14,
                                      fontFamily: 'Poppins'),*/
                              fillColor: Colors.grey.shade100,
                              filled: true,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.013,
                          ),
                          TextFormField(
                              style: const TextStyle(fontFamily: 'Poppins'),
                              obscureText: _isObscured,
                              //keyboardType: TextInputType.visiblePassword,
                              controller: _controllerMotDePasse,
                              keyboardType: TextInputType.visiblePassword,
                              /* validator: (input) {
                                    if (input == null) {
                                      return 'Entrez votre mot de passe ';
                                    }
                                    return null;
                                  },*/
                              validator: (input) {
                                if (input == null || input == '') {
                                  return 'Entrez votre mot de passe ';
                                } else if (input.toString().length < 8) {
                                  return 'nombre de chifre doit etre superieur a 8 ';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.key,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                  //border: OutlineInputBorder(),
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                  ),
                                  labelText: 'Mot de passe',
                                  labelStyle: const TextStyle(fontFamily: 'Poppins'),
                                  hintText: 'Entrez votre mot de passe ',
                                  hintStyle: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 14,
                                      fontFamily: 'Poppins'),
                                  /* color: Colors.grey[800],
                                          fontSize: 14,
                                          fontFamily: 'Poppins'),*/
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  suffixIcon: IconButton(
                                    icon: !_isObscured
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        _isObscured = !_isObscured;
                                      });
                                    },
                                  ))),
                          SizedBox(
                            height: screenHeight * 0.05,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: screenHeight * 0.06,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.
                                  if (_baseDeDonnee
                                      .validerNomEtPrenom(_controllerNom.text) &&
                                      _baseDeDonnee
                                          .validerNomEtPrenom(_controllerPrenom.text) &&
                                      _baseDeDonnee
                                          .validerEmail(_controllerEmail.text) &&
                                      _baseDeDonnee.validerMotDePasse(
                                          _controllerMotDePasse.text) &&
                                      _baseDeDonnee
                                          .validatePhoneNumber(_controllerPhone.text)) {
                                    final fcm =await FirebaseMessaging.instance.getToken();
                                    Utilisateur utilisateur1 =
                                    creerUtilisateurApresSignUp(
                                        '',
                                        _controllerNom.text,
                                        _controllerPrenom.text,
                                        _controllerEmail.text,
                                        _controllerMotDePasse.text,
                                        _controllerPhone.text,fcm!);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Loading()),
                                    );
                                    dynamic result = await auth.signUp(
                                        _controllerEmail.text,
                                        _controllerMotDePasse.text,
                                        utilisateur1);
                                    if (result == null) {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          duration: const Duration(seconds: 2),
                                          content: AwesomeSnackbarContent(
                                            title: 'Oh Erreur!!',
                                            message: 'Vous devez verifier vos donnees',

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
                                    } else {
                                      utilisateur1.identifiant = result!.uid;
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Verification(
                                                email: _controllerEmail.text,utilisateur: utilisateur1)),
                                        // (Route<dynamic> route) => false,
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          duration: const Duration(seconds: 2),
                                          content: AwesomeSnackbarContent(
                                            title: 'Bravo!!',
                                            message: 'Inscription avec succés',

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
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    duration: const Duration(seconds: 2),
                                    content: AwesomeSnackbarContent(
                                      title: 'Oh Erreur!!',
                                      message: 'Vous devez verifier vos donnees',

                                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                      contentType: ContentType.failure,
                                      // to configure for material banner
                                      inMaterialBanner: true,
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                  ));
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                              ),
                              child: const Text(
                                'S\'inscrire',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontFamily: 'Poppins'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Connexin(),
                          ));
                    },
                    child: const Text.rich(
                      TextSpan(
                        text: 'Vous avez déjà un compte? ',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14.0,
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: ' Connectez-vous',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12.0,
                              fontFamily: 'Poppins',
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                            // ),
                            // TextSpan(
                            //   text: ' .',
                            // ),
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
                //),
              )),
        ));
  }
}
