import 'package:appcouvoiturage/Services/auth.dart';
import 'package:appcouvoiturage/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:appcouvoiturage/pages/signup.dart';
import 'package:appcouvoiturage/pages/login.dart';
import 'package:appcouvoiturage/pages/details.dart';
import 'package:appcouvoiturage/pages/profilepage.dart';
import 'package:appcouvoiturage/AppClasses/Utilisateur.dart';
import 'package:appcouvoiturage/AppClasses/Vehicule.dart';
import 'package:appcouvoiturage/AppClasses/Evaluation.dart';

class  Connexin extends StatefulWidget {
   const Connexin ({super.key, required this.title});

  final String title;

  @override
  State<Connexin> createState() => _MyConnexinState();
}

class _MyConnexinState extends State<Connexin> {

  /*********************************************** Les Fonctions **********************************************/
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
    if (motDePasse.length >= 8)return true;
    else return false;
    /** Si on veut tester un mot de passe tres fort on va la faire autrement**/
  }

  bool validerEmail(String email){
    final regex = RegExp(r'[0-9]');
    if (email.endsWith('@esi.dz') && !regex.hasMatch(email)) return true;
    else return false;
  }

  Utilisateur creerUtilisateurApresSignUp(String identifiant, String nom, String prenom, String email, String motDePasse) {
    return Utilisateur(identifiant, nom, prenom, email, motDePasse, "", Evaluation([], 0, 0),
        Vehicule("", "", "", "", "", 0), false, [],[],[]
    );
  }
  /** ************************************************************************************************** **/
  /** *********************************** Les controlleurs ********************************************** **/
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerMotDePasse = TextEditingController();
  /** ************************************************************************************************** **/

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    String email='';
    String password='';
    bool visible=true;
    IconData _currentIcon = Icons.visibility;
    return Scaffold(
       resizeToAvoidBottomInset : false,
       
       appBar: AppBar(
          toolbarHeight: 100,

          leading: null,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white, 
          title: Text(''),
          flexibleSpace: Container(
           decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/ellipse.png'),
                  fit: BoxFit.fill,
                  
              )
            ),
          ),
       ),
      body: Center(
        
        child: Column(
          //padding: const EdgeInsets.all(30),
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            Container(
              height: 300.0,
              width: 350.0,
              padding: EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
              ),
              child: Center(
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
           Padding(
             padding: const EdgeInsets.only(left: 15,right: 15),
             child: Container(
             // backgroundColor: Color(0xF0F0F0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 163, 160, 160).withOpacity(0.5),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(6.0),
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
                      onChanged: (val){
                          setState(() {
                            email=val;
                          });
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Email',
                        hintText: "Entrez votre mail example: abc@esi.dz",
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
            padding: const EdgeInsets.only(left: 15,right: 15),
            child: Container(

              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xF0F0F0).withOpacity(0.5),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(6.0),
                color:Color(0xF0F0F0),

                //color:Colors.white
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
                      onChanged: (val){
                          password=val;
                      },
                      obscureText : visible,
                      keyboardType: TextInputType.text,
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
                InkWell(
                   onTap: (){
                    setState(() {
                      visible = !visible;
                    });
                   },
                    child:
                     Padding(
                      padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          /*Icons.visibility_off,*/
                          visible ? Icons.visibility : Icons.visibility_off,

                          color: Colors.black,
                          size: 20,
                        ),
                    ),
                  ) ,
                ],
              ),
            ),
          ),
          Container(
            width: 300,
            //padding: EdgeInsets.all(20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
            color: Colors.lightBlue ),
            child: TextButton(
              onPressed: ()
            async
             {
               // MaterialPageRoute(builder: (context) => const home());
               /*if (validerEmail(_controllerEmail.text)
                  && validerMotDePasse(_controllerMotDePasse.text)){*/
                dynamic result = await _auth.signIn('lh_boulacheb@esi.dz', 'hichem12345');
                if(result==null){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Vous devez verifier les donnees"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("succes"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  MaterialPageRoute(builder: (context) => const home());
                }

    },
             child: Text('Connexion',style: TextStyle(fontSize: 18,color: Colors.white),),
             
             ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text('Mot de passe oublier ?',style: TextStyle(color: Color.fromARGB(255, 37, 15, 161), fontSize: 15)),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text('Voua n avez pas un compte?',style: TextStyle(color: Colors.grey, fontSize: 15)),
          ),
          Container(
            padding: EdgeInsets.all(10),
          //  child: Text('Create Account ',style: TextStyle(color: Color.fromARGB(255, 37, 15, 161), fontSize: 15)),
          child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage(title: " sing up ",)),
            );
            // Navigate back to first route when tapped.
          },
          child: const Text('creer un compte',style: TextStyle(color: Color.fromARGB(255, 37, 15, 161), fontSize: 15)),
          ),
          ),
          ]
        ),
      ),
    );
  }
}
