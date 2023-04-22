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

class Sinup extends StatefulWidget {
  @override
  State<Sinup> createState() => _SinupState();
}
class _SinupState extends State<Sinup> {
  var _isObscured;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isObscured = true;
  }
  final BaseDeDonnee _baseDeDonnee = BaseDeDonnee();
  /*********************************************** Les Fonctions **********************************************/
  Utilisateur creerUtilisateurApresSignUp(String identifiant, String nom, String prenom, String email, String motDePasse,String numero) {
    return Utilisateur(identifiant, nom, prenom, email, motDePasse, numero, Evaluation([], 5, 0),
        Vehicule("", "", "", "", "", 0), false, [],[],[]
    );
  }
  /** ************************************************************************************************** **/
  /** *********************************** Les controlleurs ********************************************** **/
  TextEditingController _controllerNom = TextEditingController();
  TextEditingController _controllerPrenom = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerMotDePasse = TextEditingController();
  TextEditingController _controllerPhone = TextEditingController();
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
              padding: const EdgeInsets.all(10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: Center(
                        child: Text("Inscription", style: TextStyle(
                            color: Color.fromARGB(255, 79, 77, 77),
                            fontSize: 40,
                            fontWeight: FontWeight.bold),),
                      ),
                    ),
                    Form(
                      // key: _formkey,
                      child: Container(
                        margin: EdgeInsets.only(
                            left: screenWidth * 0.01,
                            right: screenWidth * 0.01),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: screenHeight * 0.06,
                            ),
                            TextFormField(
                                controller: _controllerNom,
                                keyboardType: TextInputType.name,
                                validator: (input) {
                                  if (input == null) {
                                    return 'Entrez votre nom ';
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

                                  labelText: 'Nom',
                                  hintText: 'Entere votre nom',
                                  hintStyle: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 14),
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                ),
                              ),

                            SizedBox(
                              height: screenHeight * 0.013,
                            ),
                            TextFormField(
                              controller: _controllerPrenom,
                              keyboardType: TextInputType.name,
                              validator: (input) {
                                if (input == null) {
                                  return 'Entrer votre prenom';
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

                                labelText: 'Prenom',
                                hintText: 'Entrer votre prenom',
                                hintStyle: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 14),
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
                                if (input == null) {
                                  return 'Entrer votre numero de telephone ';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                //border: OutlineInputBorder(),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(12)),
                                ),

                                labelText: 'Numero de Telephone',
                                hintText: 'Entrer votre numero de telephone',
                                hintStyle: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 14),
                                fillColor: Colors.grey.shade100,
                                filled: true,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.013,
                            ),
                            TextFormField(
                              controller: _controllerEmail,
                              keyboardType: TextInputType.emailAddress,
                              validator: (input) {
                                if (input == null) {
                                  return 'Entrer votre address email ';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                //border: OutlineInputBorder(),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(12)),
                                ),

                                labelText: 'Email',
                                hintText: 'Entrez votre adresse mail de l\'esi',
                                hintStyle: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 14),
                                fillColor: Colors.grey.shade100,
                                filled: true,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.013,
                            ),
                            TextFormField(
                                obscureText: _isObscured,
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
                                      Icons.key,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                    //border: OutlineInputBorder(),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12)),
                                    ),
                                    labelText: 'Mot de passe',
                                    hintText: 'Entrez votre mot de passe ',
                                    hintStyle: TextStyle(
                                        color: Colors.grey[800],
                                        fontSize: 14),
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
                              height: screenHeight * 0.05,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: screenHeight*0.06,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_baseDeDonnee.validerNomEtPrenom(_controllerNom.text)
                                      &&
                                      _baseDeDonnee.validerNomEtPrenom(_controllerPrenom.text)
                                      && _baseDeDonnee.validerEmail(_controllerEmail.text)
                                      && _baseDeDonnee.validerMotDePasse(_controllerMotDePasse.text)
                                      && _baseDeDonnee.validatePhoneNumber(_controllerPhone.text)) {
                                    Utilisateur utilisateur = creerUtilisateurApresSignUp(
                                        '', _controllerNom.text,
                                        _controllerPrenom.text,
                                        _controllerEmail.text,
                                        _controllerMotDePasse.text,
                                        _controllerPhone.text);
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
                                  'S\'inscrire',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(
                                      Colors.blue),
                                ),
                              ),
                            ),                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight*0.01,),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Connexin(),));
                      },
                      child: Text.rich(
                        TextSpan(
                          text: 'Vous avez deja un compte? ',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14.0,
                            fontFamily: 'Poppins',
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: ' Connecter',
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
            )

        )
    );
  }
}
