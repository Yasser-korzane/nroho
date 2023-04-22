import 'package:appcouvoiturage/AppClasses/Evaluation.dart';
import 'package:appcouvoiturage/AppClasses/Utilisateur.dart';
import 'package:appcouvoiturage/AppClasses/Vehicule.dart';
import 'package:appcouvoiturage/Services/auth.dart';
import 'package:appcouvoiturage/Shared/lodingEffect.dart';
import 'package:appcouvoiturage/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:appcouvoiturage/pages/signup1.dart';

class Connexin extends StatefulWidget {
  @override
  State<Connexin> createState() => _MyConnexinState();
}

class _MyConnexinState extends State<Connexin> {
  var _isObscured;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isObscured = true;
  }

  /*********************************************** Les Fonctions **********************************************/
  bool validerNomEtPrenom(String value) {
    String chaineTest = value;
    String pattern = r'^[a-zA-Z\u0600-\u06FF ]+$';
    RegExp regExp = new RegExp(pattern);
    chaineTest = value.replaceAll(' ', '');
    if (value.length > 20 ||
        chaineTest.isEmpty ||
        !regExp.hasMatch(chaineTest) ||
        value.startsWith(' ') ||
        value.endsWith(' ')) {
      return false;
    } else {
      return true;
    }
  }

  bool validerMotDePasse(String motDePasse) {
    if (motDePasse.length >= 8)
      return true;
    else
      return false;
    /** Si on veut tester un mot de passe tres fort on va la faire autrement**/
  }

  bool validerEmail(String email) {
    final regex = RegExp(r'[0-9]');
    if (email.endsWith('@esi.dz') && !regex.hasMatch(email))
      return true;
    else
      return false;
  }

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
        Vehicule("", "", "", "", "", 0),
        false, [], [], []);
  }

  /** ************************************************************************************************** **/
  /** *********************************** Les controlleurs ********************************************** **/
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerMotDePasse = TextEditingController();

  /** ************************************************************************************************** **/

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    bool visible = true;
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
                                    controller: _controllerEmail,
                                    keyboardType: TextInputType.emailAddress,
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

                                      labelText: 'User Name',
                                      hintText:
                                          'Entrez votre adresse mail abc@gmail.com',
                                      hintStyle: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 14),
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.001,
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
                                  height: screenHeight * 0.02,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      // MaterialPageRoute(builder: (context) => const home());
                                      if (validerEmail(_controllerEmail.text) &&
                                          validerMotDePasse(
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
                                                  "Veuillez verifier vos données "),
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
                                                "Veuillez verifier vos données"),
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                      }
                                    },
                                    child: Text(
                                      'Connexion',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
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
                                    onPressed: () {},
                                    child: Text('Mot de passe oublié ?'),
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
                            Text('Oubien?'),
                            TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Sinup(),));
                              },
                              child: Text.rich(
                                TextSpan(
                                  text: 'Vous n\'avez pas compte? ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14.0,
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'S\'inscrire',
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
}