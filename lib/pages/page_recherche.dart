//import 'dart:js_util';

import 'package:appcouvoiturage/Services/base de donnee.dart';
import 'package:flutter/material.dart';
import 'package:appcouvoiturage/AppClasses/Trajet.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Page_recherche extends StatefulWidget {

  @override
  State<Page_recherche> createState() => _Page_rechercheState();
}

class _Page_rechercheState extends State<Page_recherche> {
  BaseDeDonnee _baseDeDonnee = BaseDeDonnee();


  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery
        .of(context)
        .size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return Scaffold(
      body:
      Column(
        children:<Widget> [
          Container(
            padding: EdgeInsets.fromLTRB(0, screenHeight*0.07, 0, 0),
            child: Image.asset("assets/images/photo_recherche.png"),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0,0),
            child: Text(
              "En covoiturant,diminuez le nombre de",
              style: TextStyle(
                color: Colors.grey[700],
                fontFamily: "Poppins",
                fontSize: 18,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0,0),
            child: Text(
              "véhicules sur la route , réduisez la",
              style: TextStyle(
                color: Colors.grey[700],
                fontFamily: "Poppins",
                fontSize: 18,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(screenWidth*0.010, 0, 0,screenHeight*0.020),
            child: Text(
              "pollution et sauvez la planéte !",
              style: TextStyle(
                color: Colors.grey[700],
                fontFamily: "Poppins",
                fontSize: 18,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(screenWidth*0.080, 0,screenWidth*0.080, 0),
            color: Colors.white30,
            child: LinearProgressIndicatorDemo(),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0,screenHeight*0.010, 0, 0),
            child: Text(
              "Nous recherchons vos covoitureurs",
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
              ),
            ),
          ),
          Container(
            child: Text(
                "Merci de patienter",
              style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
              ),
            ),
          ),
        ],
      )
    );
  }
}

class LinearProgressIndicatorDemo extends StatefulWidget {
 // const LinearProgressIndicatorDemo({Key? key}) : super(key: key);

  @override
  State<LinearProgressIndicatorDemo> createState() => _LinearProgressIndicatorDemoState();
}

class _LinearProgressIndicatorDemoState extends State<LinearProgressIndicatorDemo> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    animation=Tween(begin: 0.0,end: 1.0).animate(controller!)..addListener(() {setState(() {
    });});
    controller!.repeat();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    controller!.stop();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Center(child: Container(child: LinearProgressIndicator(value: animation!.value,),),);
  }
}


