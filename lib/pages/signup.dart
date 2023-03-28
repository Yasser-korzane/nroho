import 'package:appcouvoiturage/pages/home.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
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
  TextEditingController _controllerNom = TextEditingController();
  TextEditingController _controllerPrenom = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerMotDePasse = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
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
              Padding(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  controller: _controllerNom,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: ' First Name',
                      hintText: 'Enter your First name '),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  controller: _controllerPrenom,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'last Name',
                      hintText: 'Enter your last name'),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  controller: _controllerEmail,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter valid mail id as abc@esi.dz'),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  obscureText: true,
                  controller: _controllerMotDePasse,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter your secure password'),
                ),
              ),
              Container(
                width: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.lightBlue),
                child: TextButton(
                  onPressed: () {
                    if (validerNomEtPrenom(_controllerNom.text)
                    && validerNomEtPrenom(_controllerPrenom.text)
                    && validerEmail(_controllerEmail.text)
                    && validerMotDePasse(_controllerMotDePasse.text)){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => home(),));
                    }else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Vous devez verifier les donnes"),
                          duration: Duration(seconds: 2),
                        ),
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
