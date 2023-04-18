//import 'dart:html';

import 'package:appcouvoiturage/Services/auth.dart';
import 'package:appcouvoiturage/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:appcouvoiturage/Models/Users.dart';

import '../AppClasses/Evaluation.dart';
import '../AppClasses/Utilisateur.dart';
import '../AppClasses/Vehicule.dart';
import 'package:appcouvoiturage/Shared/lodingEffect.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {

  /*********************************************** Les Fonctions de validation **********************************************/
  bool validerNomEtPrenom(String value) {
    String chaineTest = value;
    String pattern = r'^[a-zA-Z\u0600-\u06FF ]+$';
    RegExp regExp = new RegExp(pattern);
    chaineTest = value.replaceAll(' ', '');
    if(value.length > 20 || chaineTest.isEmpty
        || !regExp.hasMatch(chaineTest)
        || value.startsWith(' ') || value.endsWith(' ')){
      return false;
    } else {
      return true;
    }
  }

  bool validerMotDePasse(String motDePasse){
    if (motDePasse.length >= 8 && motDePasse.isNotEmpty)return true;
    else return false;
    /** Si on veut tester un mot de passe tres fort on va la faire autrement**/
  }

  bool validerEmail(String email){
    final regex = RegExp(r'[0-9]');
    if (email.endsWith('@esi.dz') && !regex.hasMatch(email) && email.isNotEmpty) return true;
    else return false;
  }

  bool validerNumTelephone(String numTelephone){
    return true;
  }

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
    final AuthService _auth =AuthService();
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
                  child: Text("Inscription",style: TextStyle(color: Color.fromARGB(255, 79, 77, 77), fontSize: 30 ,fontWeight: FontWeight.bold) ,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 163, 160, 160).withOpacity(0.5),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(6.0),
                      color:Colors.white
                  ),
                  margin: EdgeInsets.all(12),
                  child: Row(
                    children: <Widget>[

                      new Expanded(
                        child: TextFormField(
                          controller: _controllerNom,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Nom',
                            hintText: "Enterez votre Prenom",
                            hintStyle: TextStyle(color: Colors.black),
                            contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(255, 163, 160, 160).withOpacity(0.5),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(6.0),
                    color:Color(0xD9D9D9),
                  ),
                  margin: EdgeInsets.all(12),
                  child: Row(
                    children: <Widget>[
                      new Expanded(
                        child: TextFormField(
                          controller: _controllerPrenom,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Prenom',
                            hintText: "Entrez votre Prenom",
                            hintStyle: TextStyle(color: Colors.black),
                            contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                            isDense: true,
                          ),

                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(255, 163, 160, 160).withOpacity(0.5),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(6.0),
                    //color:Colors.white
                    color:Color(0xD9D9D9),

                  ),
                  margin: EdgeInsets.all(12),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(
                          Icons.mail,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                      new Expanded(
                        child: TextFormField(
                          controller: _controllerEmail,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Email',
                            hintText: "Enterez votre mail example: abc@esi.dz",
                            hintStyle: TextStyle(color: Colors.black),
                            contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                            isDense: true,
                          ),
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(255, 163, 160, 160).withOpacity(0.5),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(6.0),
                    //color:Colors.white
                    color:Color(0xD9D9D9),

                  ),
                  margin: EdgeInsets.all(12),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(
                          Icons.key,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                      new Expanded(
                        child: TextFormField(
                          controller: _controllerMotDePasse,
                          obscureText :true,
                          //keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Mot de passe',
                            hintText: "Enterez votre mot de passe",
                            hintStyle: TextStyle(color: Colors.black),
                            contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                            isDense: true,
                          ),

                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.visibility_off,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ],
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
                    if (validerNomEtPrenom(_controllerNom.text)
                        && validerNomEtPrenom(_controllerPrenom.text)
                        && validerEmail(_controllerEmail.text)
                        && validerMotDePasse(_controllerMotDePasse.text)){
                      Utilisateur utilisateur = creerUtilisateurApresSignUp('',_controllerNom.text,_controllerPrenom.text,_controllerEmail.text, _controllerMotDePasse.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Loading()),
                      );
                      dynamic result = await _auth.signUp(_controllerEmail.text, _controllerMotDePasse.text,utilisateur);
                      if(result==null){
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Vous devez verifier les donnees"),
                            duration: Duration(seconds: 2),
                          ),
                        );}
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Succes"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => home()),
                              (Route<dynamic> route)=>false,

                        );
                      }
                    } else{
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Vous devez verifier les donnees"),
                            duration: Duration(seconds: 2),
                          )
                      );
                    }
                  },
                  child: Text(
                    'sign up',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      //),
    );
  }
}
