import 'package:appcouvoiturage/pages/assistance.dart';
import 'package:appcouvoiturage/pages/lancer_reserver.dart';
import 'package:appcouvoiturage/pages/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:appcouvoiturage/pages/MapPage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'Poppins'),
    home: const home(),
  ));
}

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet=false;
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Mywid(),
    Trajets(),
    Assistance(),
    Profilepage(),
  ];

  @override
  void initState() {
    checkConnectivityinitial();
    getConnectivity();
    super.initState();
  }
  void checkConnectivityinitial() async{
    var result = await Connectivity().checkConnectivity();
    if(result==ConnectivityResult.none){
      showDialogBox();
    }
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

    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    return SafeArea(
      child: Scaffold(
        body:_widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: Container(
          height: screenHeight * 0.075,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: screenHeight*0.015, vertical: screenSize.width * 0.001),
              child: GNav(
                  rippleColor: Colors.grey[400]!,
                  hoverColor: Colors.blueGrey[300]!,
                  gap: 8,
                  activeColor: Colors.blueGrey,
                  iconSize: 24,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: Duration(milliseconds: 200),
                  tabBackgroundColor: Colors.grey[300]!,
                  color: Colors.black,
                  tabs: [
                    GButton(
                      icon: Icons.home,
                      onPressed: (){

                      },
                      text: 'Actuel',
                    ),
                    GButton(
                      icon: Icons.directions_car_filled,
                      text: 'Trajets',
                    ),
                    GButton(
                      icon: Icons.question_answer_outlined,
                      text: 'Assistance',
                    ),
                    GButton(
                      icon: Icons.account_circle_outlined,
                      text: 'Profile',
                    ),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  }
              ),
            ),
          ),
        ),
      ),
    );
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
            child: const Text('OK'),
          )
        ],
      )
  );
}



