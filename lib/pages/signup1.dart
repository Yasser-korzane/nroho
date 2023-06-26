import 'package:nroho/Services/auth.dart';
import 'package:nroho/Services/base%20de%20donnee.dart';
import 'package:nroho/pages/Verification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../AppClasses/Evaluation.dart';
import '../AppClasses/Utilisateur.dart';
import '../AppClasses/Vehicule.dart';
import 'package:nroho/Shared/lodingEffect.dart';
import 'package:nroho/pages/connexion.dart';

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
        fcmtoken,false);
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
  RegExp regExpNomPrenom = RegExp(r'^[a-zA-Z\u0600-\u06FF ]+$');
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

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
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.person_outline_outlined,
                                color: Colors.black,
                                size: 20,
                              ),
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
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.person_outline_outlined,
                                color: Colors.black,
                                size: 20,
                              ),
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
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.phone,
                                color: Colors.black,
                                size: 20,
                              ),
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
                            validator: (input) {
                              if (input == null || input == '') {
                                return 'Veuillez entrez votre adresse email';
                              } else if (!RegExp(r'^[a-zA-Z_.@]+$').hasMatch(input)) {
                                return 'L\'email n\'est pas validé';
                              } else if (!input.endsWith('@esi.dz')) {
                                return 'Seul l\'email de l\'ESI est autorisé';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: Colors.black,
                                size: 20,
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                              ),
                              labelText: 'Email',
                              labelStyle: const TextStyle(fontFamily: 'Poppins'),
                              hintText: 'Entrez votre adresse email de l\'esi',
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
                              style: const TextStyle(fontFamily: 'Poppins'),
                              obscureText: _isObscured,
                              controller: _controllerMotDePasse,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (input) {
                                if (input == null || input == '') {
                                  return 'Veuillez entrez votre mot de passe';
                                } else if (!(input.toString().length >= 8 && input.toString().length < 20)) {
                                  return 'Le mot de passe doit étre supérieur à 8 et inférieur à 20';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.key,
                                    color: Colors.black,
                                    size: 20,
                                  ),
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
                                            message: 'Cette adresse email est déja utilisé',
                                            contentType: ContentType.failure,
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
                                      );
                                    }
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    duration: const Duration(seconds: 2),
                                    content: AwesomeSnackbarContent(
                                      title: 'Oh Erreur!!',
                                      message: 'Vous devez vérifier vos données',
                                      contentType: ContentType.failure,
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
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 600),
                          pageBuilder: (context, animation, secondaryAnimation) => Connexin(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            var begin = Offset(1.0, 0.0);
                            var end = Offset.zero;
                            var curve = Curves.ease;
                            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );
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
                            )
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
