import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';

class erreur_connexion_fenetre extends StatefulWidget {
  const erreur_connexion_fenetre({Key? key}) : super(key: key);

  @override
  State<erreur_connexion_fenetre> createState() => _erreur_connexion_fenetreState();
}

class _erreur_connexion_fenetreState extends State<erreur_connexion_fenetre> {
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet=false;
  @override
  Widget build(BuildContext context) {
    return showDialogBox();
  }

  showDialogBox()=> showCupertinoDialog<String>(
      context: context,
      builder:(BuildContext context) =>CupertinoAlertDialog(
        title: const Text('Erreur de connexion'),
        content: const Text('Vérifier votre connexion internet'),
        actions: <Widget>[
          TextButton(
            onPressed: () async{
              Navigator.pop(context , 'cancel');
              setState(() {
                isAlertSet =false;
              });
              isDeviceConnected = await InternetConnectionChecker().hasConnection;
              if(!isDeviceConnected){
                showDialogBox();
                setState(() {
                  isAlertSet =true;
                });
              }
            },
            child: const Text('Réessayer'),
          )
        ],
      )
  );
}
