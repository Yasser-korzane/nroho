import 'package:appcouvoiturage/AppClasses/Evaluation.dart';
import 'package:appcouvoiturage/AppClasses/Utilisateur.dart';
import 'package:appcouvoiturage/AppClasses/Vehicule.dart';
import 'package:appcouvoiturage/Services/auth.dart';
import 'package:appcouvoiturage/Services/base%20de%20donnee.dart';
import 'package:appcouvoiturage/Shared/lodingEffect.dart';
import 'package:appcouvoiturage/pages/email.dart';
import 'package:appcouvoiturage/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:appcouvoiturage/pages/signup1.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:appcouvoiturage/AppClasses/Notifications.dart';

class Connexin extends StatefulWidget {
  @override
  State<Connexin> createState() => _MyConnexinState();
}

class _MyConnexinState extends State<Connexin> {
  var _isObscured;
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isObscured = false;
    getConnectivity();
  }
  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
              (ConnectivityResult result) async{
            isDeviceConnected = await InternetConnectionChecker().hasConnection;
            if(!isDeviceConnected && isAlertSet == false){
              showDialogBox();
              setState(() {
                isAlertSet = true;
              });
            }
          }
      );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  /*********************************************** Les Fonctions **********************************************/
  Utilisateur creerUtilisateurApresSignUp(String identifiant, String nom,
      String prenom, String email, String motDePasse) {
    return Utilisateur(
        identifiant,
        nom,
        prenom,
        email,
        motDePasse,
        "",
        Evaluation([], 0, 0),
        Vehicule("", "", "", "", ""),
        false, [], [], [],[],'');
  }

  /** ************************************************************************************************** **/
  /** *********************************** Les controlleurs ********************************************** **/
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerMotDePasse = TextEditingController();
  BaseDeDonnee _baseDeDonnee = BaseDeDonnee();
  /** ************************************************************************************************** **/

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    bool visible = false;
    bool loading = false;
    IconData _currentIcon = Icons.visibility;
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final double defaultPadding = 10;
    final GlobalKey<FormState> _formkey1 = GlobalKey<FormState>();

    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/connexion.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      child: Column(children: [
                        SizedBox(
                          height: screenHeight * 0.4,
                        ),
                        Form(
                          // key:_formkey1,
                          child: Container(
                            margin: EdgeInsets.only(
                                left: screenWidth * 0.04,
                                right: screenWidth * 0.04),
                            // padding: EdgeInsets.fromLTRB(screenWidth*0.8, top, right, bottom)
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: screenHeight * 0.1,
                                  child: TextFormField(
                                    style: TextStyle(fontFamily: 'Poppins'),
                                    controller: _controllerEmail,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (input) {
                                      if (input == null) {
                                        return 'Entrez votre Email ';
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.person_outline_outlined,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                      //border: OutlineInputBorder(),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                      ),

                                      labelText: 'Email',
                                      hintText:
                                          'Entrez votre adresse mail de l\'esi',
                                      hintStyle: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 14),
                                         /* color: Colors.grey[800],
                                          fontSize: 14,fontFamily: 'Poppins'),*/
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.001,
                                ),
                                TextFormField(
                                    obscureText: !_isObscured,
                                  style: TextStyle(fontFamily: 'Poppins'),
                                    //keyboardType: TextInputType.visiblePassword,
                                    controller: _controllerMotDePasse,
                                    keyboardType: TextInputType.visiblePassword,
                                    validator: (input) {
                                      if (input == null) {
                                        return 'Entrez votre mot de passe ';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.fingerprint,
                                          color: Colors.black,
                                          size: 20,
                                        ),
                                        //border: OutlineInputBorder(),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                        ),
                                        labelText: 'Mot de passe',
                                        labelStyle: TextStyle(
                                          fontFamily:'Poppins'
                                        ),
                                        hintText: 'Entrez votre mot de passe ',
                                        hintStyle: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 14
                                        ,fontFamily: 'Poppins'),
                                            /*color: Colors.grey[800],
                                            fontSize: 14,fontFamily: 'Poppins'),*/
                                        fillColor: Colors.grey.shade100,
                                        filled: true,
                                        suffixIcon: IconButton(
                                          icon: _isObscured
                                              ? const Icon(Icons.visibility)
                                              : const Icon(
                                                  Icons.visibility_off),
                                          onPressed: () {
                                            setState(() {
                                              _isObscured = !_isObscured;
                                            });
                                          },
                                        ))),
                                SizedBox(
                                  height: screenHeight * 0.02,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      // MaterialPageRoute(builder: (context) => const home());
                                      if (_baseDeDonnee.validerEmail(_controllerEmail.text) &&
                                          _baseDeDonnee.validerMotDePasse(
                                              _controllerMotDePasse.text)) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Loading()),
                                        );
                                        dynamic result = await _auth.signIn(
                                            _controllerEmail.text,
                                            _controllerMotDePasse.text);
                                        if (result == null) {
                                          Navigator.pop(context);

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  "Veuillez verifier vos données ",       
                                                style: TextStyle(fontFamily: 'Poppins'),
                                              ),
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                        } else {
                                          //MaterialPageRoute(builder: (context) => const home());
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => home()),
                                            (Route<dynamic> route) => false,
                                          );
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                "Veuillez verifier vos données",                                  style: TextStyle(fontFamily: 'Poppins'),
                                            ),
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                      }
                                    },
                                    child: Text(
                                      'Connexion',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white,fontFamily: 'Poppins'),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.blue),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.02,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Emailgetter()));
                                    },
                                    child: Text('Mot de passe oublié ?',style: TextStyle(fontFamily: 'Poppins'),),
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.01,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Sinup(),));
                              },
                              child: Text.rich(
                                TextSpan(
                                  text: 'Vous n\'avez encore un compte? ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14.0,
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Inscrivez-Vous',
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
                          ],
                        )
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
  showDialogBox()=> showCupertinoDialog<String>(
      context: context,
      builder:(BuildContext context) =>CupertinoAlertDialog(
        title: const Text('Erreur de connexion'),
        content: const Text('Vérifier votre connexion internet'),
        actions: <Widget>[
          TextButton(
            onPressed: () async{
              Navigator.pop(context , 'cancel');
              setState(() {
                isAlertSet =false;
              });
              isDeviceConnected = await InternetConnectionChecker().hasConnection;
              if(!isDeviceConnected){
                showDialogBox();
                setState(() {
                  isAlertSet =true;
                });
              }
            },
            child: const Text('Réessayez'),
          )
        ],
      )
  );
}
