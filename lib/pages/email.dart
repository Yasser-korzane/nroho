import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:nroho/Services/auth.dart';
class Emailgetter extends StatefulWidget {
  const Emailgetter({super.key});

  @override
  State<Emailgetter> createState() => _EmailgetterState();
}

class _EmailgetterState extends State<Emailgetter> {
  TextEditingController _controllerEmail = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.01),
          height: MediaQuery.of(context).size.height * 0.8,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: screenHeight * 0.1,
              ),
              Container(
                height: screenHeight * 0.2,
                padding: EdgeInsets.symmetric(
                    horizontal: screenHeight * 0.1,
                    vertical: screenWidth * 0.01),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade200,
                ),
                child: Image.asset('assets/images/user-profile.png'),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              FadeInDown(
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    "Mot de passe oublié",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,                          fontFamily:'Poppins'
                    ),
                  )),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              FadeInDown(
                delay: Duration(milliseconds: 500),
                duration: Duration(milliseconds: 500),
                child: Text(
                  "Entrez votre adresse e-mail ci-dessous pour réinitialiser votre mot de passe.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16, color: Colors.grey.shade500, height: 1.5,                          fontFamily:'Poppins'
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Form(
                key: _formKey,
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                      height: screenHeight * 0.1,
                      child: TextFormField(
                        style: TextStyle(fontFamily: "Poppins"),
                        keyboardType: TextInputType.emailAddress,
                        controller: _controllerEmail,
                        validator: (input) {
                          if (input == null || input == '') {
                            return 'Veuillez entrez votre adresse email';
                          } else if (!RegExp(r'^[a-zA-Z_.@]+$').hasMatch(input)) {
                            return 'L\'email est non valide';
                          } else if (!input.endsWith('@esi.dz')) {
                            return 'Seul l\'email de l\'ESI est autorisé';
                          }else if (input.contains(' ')){
                            return 'L\'email ne doit pas contenir des espaces' ;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.black,
                            size: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),

                          labelText: 'Email',
                          labelStyle: TextStyle(
                              fontFamily:'Poppins'
                          ),
                          hintText: 'Entrez votre adresse mail de l\'esi',
                          hintStyle:
                          TextStyle(color: Colors.grey[800], fontSize: 14,
                              fontFamily:'Poppins'
                          ),
                          fillColor: Colors.grey.shade100,
                          filled: true,

                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.005,
                    ),
                    SizedBox(
                        width: screenWidth * 0.89,
                        height: screenHeight * 0.06,
                        child: Material(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()){
                                var email_correct = await _auth.resetPassword(_controllerEmail.text);
                                if(email_correct == true){
                                  showDialog(context: context,
                                      builder: (context){
                                        return AlertDialog(
                                          content: Text("Mot de passe réinitialisé, vérifier votre adresse mail et essayer de vous connecter"),
                                          actions: <Widget>[
                                            TextButton(
                                                onPressed:(){
                                                  Navigator.pop(context);
                                                },
                                                child: Text("ok"))
                                          ],
                                        );
                                      }
                                  );
                                }else{
                                  showDialog(context: context,
                                      builder: (context){
                                        return AlertDialog(
                                          content: Text("Adresse mail invalide, essayer d'entrer une adresse email correcte"),
                                          actions: <Widget>[
                                            Center(
                                              child: TextButton(onPressed:(){
                                                Navigator.pop(context);
                                              },
                                                  child: Text("réssayer")),
                                            )
                                          ],
                                        );
                                      }
                                  );
                                }
                              } // end validate
                            },
                            child: Text(
                              ' suivant',
                              style: TextStyle(fontSize: 18, color: Colors.white,fontFamily: 'Poppins'),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                            ),
                          ),
                        )),
                  ])),
            ],
          ),
        ),
      ),
    );
  }
}
