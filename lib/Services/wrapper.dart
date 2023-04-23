import 'dart:async';

import 'package:appcouvoiturage/Models/Users.dart';
import 'package:appcouvoiturage/pages/begin.dart';
import 'package:appcouvoiturage/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:provider/provider.dart';
=======
import 'package:appcouvoiturage/main.dart';
import 'package:appcouvoiturage/pages/connexion.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:appcouvoiturage/pages/login.dart';
import 'package:appcouvoiturage/pages/ressayer.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
>>>>>>> Stashed changes

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet=false;

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }
  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async{
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if(!isDeviceConnected && isAlertSet == false){
            showDialogBox();
            setState(() {
              isAlertSet = true;
            });
          }
        }
      );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);
     if (user == null) {
      return Commancer();
    } else {
      return home();
    }
  }
  showDialogBox()=> showCupertinoDialog<String>(
    context: context,
    builder:(BuildContext context) =>CupertinoAlertDialog(
      title: const Text('No connection'),
      content: const Text('please check your internet connectivity'),
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
          child: const Text('OK'),
        )
      ],
    )
  );
}
