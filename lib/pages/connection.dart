import 'package:appcouvoiturage/Services/auth.dart';
import 'package:appcouvoiturage/Shared/lodingEffect.dart';
import 'package:appcouvoiturage/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:appcouvoiturage/pages/signup1.dart';
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
    bool visible=true;
    bool loading =false;
    IconData _currentIcon = Icons.visibility;
     final Size screenSize = MediaQuery
        .of(context)
        .size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final double defaultPadding = 10;
  final GlobalKey<FormState> _formkey1 = GlobalKey<FormState>();

    return loading ? Loading() : Scaffold(
       resizeToAvoidBottomInset : false,
       
       appBar: AppBar(
          toolbarHeight: 100,

          leading: null,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey, 
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
            /***********************************************************************/
           Form(
            key:_formkey1,
            child: Column(
              children:[
                Container(
                   height: screenHeight*0.080,

                  child: Padding(
                              padding: const EdgeInsets.only(left: 20,right: 20 ,bottom: 5,top: 5,),
                              child: TextFormField(
                    
                    controller: _controllerEmail,
                    keyboardType: TextInputType.emailAddress,
                     validator:(input){
                                    if(input == null ){
                                      return 'Entrer votre nom svp';
                                    }
                                    return null;
                                  },
                          
                    decoration: InputDecoration(
                    
                    prefixIcon:Icon(
                            Icons.mail,
                            color: Colors.black,
                            size: 20,
                          ) ,
                    //border: OutlineInputBorder(),
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)),),
                
                    labelText: 'User Name',
                    hintText: 'Enter valid mail id as abc@gmail.com',
                    hintStyle: TextStyle(color: Colors.grey[200],fontSize: 14),
                    fillColor: Colors.grey,
                    filled: true,
                    
                    ),
                  ),
                            ),
                ),
              /*************************************************************/
           Container(
            height: screenHeight*0.080,
             child: Padding(
                padding: const EdgeInsets.only(left: 20,right: 20, bottom:5 , top: 5,),
               
               child: TextFormField(         
                    //keyboardType: TextInputType.visiblePassword,
                    keyboardType: TextInputType.visiblePassword,
                     validator:(input){
                                    if(input == null ){
                                      return 'Entrer votre nom svp';
                                    }
                                    return null;
                                  },
               
                    decoration: InputDecoration(
                    prefixIcon:Icon(
                            Icons.key,
                            color: Colors.black,
                            size: 20,
                          ) ,
                    //border: OutlineInputBorder(),
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)),),
           
                    labelText: 'Mot de passe',
                    hintText: 'entrer votre mot de passe ',
                    hintStyle: TextStyle(color: Colors.grey[200],fontSize: 14),
                    fillColor: Colors.grey,
                    filled: true,
                    
                    suffix:  TextButton(
                      child: Icon(
                              /*Icons.visibility_off,*/
                              visible ? Icons.visibility : Icons.visibility_off,
             
                              color: Colors.black,
                              size: 15,
                            ),
                        onPressed: () =>{
                          setState(()=> {
                            visible ? visible= false : visible= true,
                          })
                        },
                    ),
                    
                    ),
                  ),
             ),
           ),
              ],
           ),
          
           ),
      
          Container(
            width: 300,
            //padding: EdgeInsets.all(20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
            color: Colors.lightBlue ),
            child: TextButton(
              onPressed: () async
             {
               // MaterialPageRoute(builder: (context) => const home());
               if (validerEmail(_controllerEmail.text)
                  && validerMotDePasse(_controllerMotDePasse.text)) {
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => Loading()),
                 );
                 dynamic result = await _auth.signIn(
                     _controllerEmail.text, _controllerMotDePasse.text);
                 if (result == null) {

                     Navigator.pop(context);

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
                   //MaterialPageRoute(builder: (context) => const home());
                   Navigator.pushAndRemoveUntil(
                     context,
                     MaterialPageRoute(builder: (context) => home()),
                         (Route<dynamic> route)=>false,
                   );
                 }
               }else{
                 ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                     content: Text("Vous devez verifier les donneess"),
                     duration: Duration(seconds: 2),
                   ),
                 );
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
            child: Text('Vous n avez pas un compte?',style: TextStyle(color: Colors.grey, fontSize: 15)),
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
