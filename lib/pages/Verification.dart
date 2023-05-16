import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:appcouvoiturage/pages/home.dart';


import '../Services/base de donnee.dart';
import '../AppClasses/Utilisateur.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class Verification extends StatefulWidget {
  final String email;
  final Utilisateur utilisateur;

  const Verification({ Key? key,required this.email,required this.utilisateur }) : super(key: key);

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  bool _isResendAgain = false;
  bool _isVerified = false;
  bool _isLoading = false;


  late Timer _timer;
  int _start = 60;
  int _currentIndex = 0;

  void resend() {
    setState(() {
      _isResendAgain = true;
    });

    const oneSec = Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_start == 0) {
          _start = 60;
          _isResendAgain = false;
          timer.cancel();
        } else {
          _start--;
        }
      });
    });
  }

  verify() {
    setState(() {
      _isLoading = true;
    });

    const oneSec = Duration(milliseconds: 2000);
    _timer = new Timer.periodic(oneSec, (timer) {
      setState(() {
        _isLoading = false;
        _isVerified = true;
      });
    });
  }

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _currentIndex++;

        if (_currentIndex == 3)
          _currentIndex = 0;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: screenHeight*0.27,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade200,
                    ) ,
                    child:Transform.rotate(
                      angle: 38,
                      child: Image.asset('assets/images/email.png'),
                    ) ,
                  ),
                  SizedBox(height: screenHeight*0.03,),
                  FadeInDown(
                      duration: Duration(milliseconds: 500),
                      child: Text("Verification", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,fontFamily: 'Poppins'))),
                  SizedBox(height: screenHeight*0.03,),
                  FadeInDown(
                      delay: Duration(milliseconds: 500),
                      duration: Duration(milliseconds: 500),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: screenWidth*0.05),
                        child: Text("Vérifier votre compte en cliquant sur le lien enovoyé dans votre email \n ${widget.email}",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.grey.shade500, height: 1.5,fontFamily: 'Poppins'),
                        ),
                      )
                  ),
                  SizedBox(height: screenHeight*0.03,),

                  SizedBox(height: screenHeight*0.03,),
                  FadeInDown(
                    delay: Duration(milliseconds: 700),
                    duration: Duration(milliseconds: 500),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Vous n'avez pas reçu le mail ?", style: TextStyle(fontSize: 11, color: Colors.grey.shade500,fontFamily: 'Poppins'),),
                        TextButton(
                            onPressed: () {
                              if (_isResendAgain) return;
                              FirebaseAuth.instance.currentUser!.sendEmailVerification();
                              resend();
                            },
                            child: Text(_isResendAgain ? "Réessayez dans  " + _start.toString() : "Renvoyer", style: TextStyle(fontSize:11 ,color: Colors.blueAccent,fontFamily: 'Poppins'),)
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight*0.07,),
                  FadeInDown(
                    delay: Duration(milliseconds: 800),
                    duration: Duration(milliseconds: 500),
                    child: MaterialButton(
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      onPressed: (){
                        FirebaseAuth.instance.currentUser!.reload();
                        if(FirebaseAuth.instance.currentUser!.emailVerified){
                          BaseDeDonnee().creerUtilisateur(widget.utilisateur);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    home()),
                                (Route<dynamic> route) => false,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(seconds: 2),
                              content: AwesomeSnackbarContent(
                                title: 'Bravo!!',
                                message: 'Inscription avec succés',

                                /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                contentType: ContentType.success,
                                // to configure for material banner
                                inMaterialBanner: true,
                              ),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            ),
                          );

                        };
                        print(FirebaseAuth.instance.currentUser!.emailVerified);
                      },
                      /*onPressed: _code.length < 4 ? () => {
                        if(FirebaseAuth.instance.currentUser!.emailVerified){
                      Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              home()),
                          (Route<dynamic> route) => false,
                    )
                        };


                        print(FirebaseAuth.instance.currentUser!.emailVerified);
                      } : () { verify(); },*/
                      color: Colors.blue,
                      minWidth: MediaQuery.of(context).size.width * 0.8,
                      height: 50,
                      child: _isLoading ? Container(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          strokeWidth: 3,
                          color: Colors.black,
                        ),
                      ) : _isVerified ? Icon(Icons.check_circle, color: Colors.white, size: 30,) : Text("J'ai Vérifié", style: TextStyle(color: Colors.white,fontFamily: 'Poppins'),),
                    ),
                  )
                ],)
          ),
        )
    );
  }
}