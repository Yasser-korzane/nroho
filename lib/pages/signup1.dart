import 'package:appcouvoiturage/Services/auth.dart';
import 'package:appcouvoiturage/Services/base%20de%20donnee.dart';
import 'package:appcouvoiturage/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:appcouvoiturage/Models/Users.dart';

import '../AppClasses/Evaluation.dart';
import '../AppClasses/Utilisateur.dart';
import '../AppClasses/Vehicule.dart';
import 'package:appcouvoiturage/Shared/lodingEffect.dart';
import 'package:appcouvoiturage/pages/connexion.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  final BaseDeDonnee _baseDeDonnee = BaseDeDonnee();
  /*********************************************** Les Fonctions **********************************************/
  Utilisateur creerUtilisateurApresSignUp(String identifiant, String nom, String prenom, String email, String motDePasse) {
    return Utilisateur(identifiant, nom, prenom, email, motDePasse, "", Evaluation([], 0, 0),
        Vehicule("", "", "", "", "", 0), false, [],[],[]
    );
  }
  /** ************************************************************************************************** **/
  /** *********************************** Les controlleurs ********************************************** **/
  TextEditingController _controllerNom = TextEditingController();
  TextEditingController _controllerPrenom = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerMotDePasse = TextEditingController();
  /** ************************************************************************************************** **/
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery
        .of(context)
        .size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    const double defaultPadding = 10;

    final AuthService _auth = AuthService();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 100,
          leading: null,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text(''),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Ellipse 5.png'),
                  fit: BoxFit.fill,
                )),
          ),
        ),

        body: Center(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Center(
                        child: Text("Inscription", style: TextStyle(
                            color: Color.fromARGB(255, 79, 77, 77),
                            fontSize: 30,
                            fontWeight: FontWeight.bold),),
                      ),
                    ),
                    Form(
                      // key: _formkey,
                      child: Column(
                        children: [
                          Container(
                            height: screenHeight * 0.080,

                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 5, top: 5),
                              //padding: EdgeInsets.all(20),
                              child: TextField(
                                controller: _controllerNom,

                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12)),),
                                  labelText: 'Nom',
                                  hintText: 'Entere votre nom ',
                                  hintStyle: TextStyle(
                                      color: Colors.grey[500], fontSize: 14),
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: screenHeight * 0.080,

                            child: Padding(
                              // padding: EdgeInsets.all(20),
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 5, top: 5),

                              child: TextFormField(
                                controller: _controllerPrenom,
                                validator: (input) {
                                  if (input == null) {
                                    return 'Entrer votre nom svp';
                                  }
                                  return null;
                                },

                                decoration: InputDecoration(
                                  //border: OutlineInputBorder(),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12)),),

                                  labelText: 'Prenom',
                                  hintText: 'Enterez votre prenom',
                                  hintStyle: TextStyle(
                                      color: Colors.grey[500], fontSize: 14),
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: screenHeight * 0.080,

                            child: Padding(
                              // padding: EdgeInsets.al
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 5, top: 5),

                              child: TextFormField(
                                controller: _controllerPrenom,
                                validator: (input) {
                                  if (input == null) {
                                    return 'Entrer votre nom svp';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  //border: OutlineInputBorder(),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12)),),

                                  labelText: ' numero de telephone',
                                  hintText: 'Enterez votre numero de telephone',
                                  hintStyle: TextStyle(
                                      color: Colors.grey[500], fontSize: 14),
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: screenHeight * 0.080,

                            child: Padding(
                              //padding: const EdgeInsets.all(8.0),
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 5, top: 5),

                              child: TextFormField(

                                controller: _controllerEmail,
                                validator: (input) {
                                  if (input == null) {
                                    return 'Entrer votre nom svp';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,

                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.mail,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                  //border: OutlineInputBorder(),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12)),),

                                  labelText: 'Email',
                                  hintText: 'Enter valid mail id as abc@gmail.com',
                                  hintStyle: TextStyle(
                                      color: Colors.grey[500], fontSize: 14),
                                  fillColor: Colors.white,
                                  filled: true,

                                ),
                                // borderRadius: BorderRadius.circular(6.0),
                                // //color:Colors.white
                                // color:Color(0xD9D9D9),

                              ),
                            ),
                          ),
                          Container(
                            height: screenHeight * 0.080,

                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 5, top: 5),
                              child: TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                validator: (input) {
                                  if (input == null) {
                                    return 'Entrer votre nom svp';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.key,
                                    color: Colors.black,
                                    size: 15,
                                  ),
                                  //border: OutlineInputBorder(),
                                  labelText: 'Mot de passe',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12)),),

                                  hintText: 'entrer votre mot de passe ',
                                  hintStyle: TextStyle(
                                      color: Colors.grey[500], fontSize: 14),
                                  fillColor: Colors.white,
                                  filled: true,

                                  // suffix:  TextButton(
                                  //   child: Icon(
                                  //           /*Icons.visibility_off,*/
                                  //           // visible ? Icons.visibility : Icons.visibility_off,
                                  //
                                  //           // color: Colors.black,
                                  //           // size: 15,
                                  //         // ),
                                  //     onPressed: () =>{
                                  //       setState(()=> {visible= !visible})
                                  //     },
                                  // ),

                                ),
                              ),
                            ),
                          ),

                          Container(
                            width: 300,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.lightBlue),
                            child: TextButton(
                              onPressed: () async {
                                if (_baseDeDonnee.validerNomEtPrenom(_controllerNom.text)
                                    &&
                                    _baseDeDonnee.validerNomEtPrenom(_controllerPrenom.text)
                                    && _baseDeDonnee.validerEmail(_controllerEmail.text)
                                    && _baseDeDonnee.validerMotDePasse(
                                        _controllerMotDePasse.text)) {
                                  Utilisateur utilisateur = creerUtilisateurApresSignUp(
                                      '', _controllerNom.text,
                                      _controllerPrenom.text,
                                      _controllerEmail.text,
                                      _controllerMotDePasse.text);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Loading()),
                                  );
                                  dynamic result = await _auth.signUp(
                                      _controllerEmail.text,
                                      _controllerMotDePasse.text, utilisateur);
                                  if (result == null) {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "Vous devez verifier les donnees"),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                  else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("Succes"),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => home()),
                                          (Route<dynamic> route) => false,

                                    );
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "Vous devez verifier les donnees"),
                                        duration: Duration(seconds: 2),
                                      )
                                  );
                                }
                              },
                              child: Text(
                                'sign up',
                                style: TextStyle(fontSize: 18,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
              //),
            )

        )
    );
  }
}
