import 'package:animate_do/animate_do.dart';
import 'package:appcouvoiturage/pages/Verification.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class Emailgetter extends StatelessWidget {
  const Emailgetter({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final double defaultPadding = 10;
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
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                      fontSize: 16, color: Colors.grey.shade500, height: 1.5),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Form(
                  child: Column(children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  height: screenHeight * 0.1,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (input) {
                      if (input == null) {
                        return 'Entrez votre e_mail adress';
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
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),

                      labelText: 'Email',
                      hintText: 'Entrez votre adresse mail abc@esi.dz',
                      hintStyle:
                          TextStyle(color: Colors.grey[800], fontSize: 14),
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
                        onPressed: () {
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => Verification()));
                        },
                        child: Text(
                          ' suivant',
                          style: TextStyle(fontSize: 18, color: Colors.white,fontFamily: 'Popping'),
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
