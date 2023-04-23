import 'package:appcouvoiturage/pages/trajetdetails.dart';
import 'package:flutter/material.dart';


class Driver {
  final String name;
  final String phoneNumber;
  final String depart;
  final String arrivee;
  final String imageUrl;

  Driver({
    required this.name,
    required this.phoneNumber,
    required this.depart,
    required this.arrivee,
    required this.imageUrl,
  });
}

class DriverListPage extends StatelessWidget {
  final List<Driver> drivers = [ // Creation de 3 instances de la classe Driver afin de dérouler le code
    Driver(
      name: 'Ali Lapointe',
      phoneNumber: '07786111801',
      depart: 'Alger',
      arrivee: 'Bejaia',
      imageUrl:
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5GqJhCPYeRpx_456iXN_bHMWVpQbqtcDreQ&usqp=CAU',
    ),
    Driver(
      name: 'Mohamed Boudief',
      phoneNumber: '05555555555',
      depart: 'Constantine',
      arrivee: 'Setif',
      imageUrl:
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5GqJhCPYeRpx_456iXN_bHMWVpQbqtcDreQ&usqp=CAU',
    ),
    Driver(
      name: 'Ferhat Abbas',
      phoneNumber: '05513555655',
      depart: 'Oran',
      arrivee: 'Tlemcen',
      imageUrl:
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5GqJhCPYeRpx_456iXN_bHMWVpQbqtcDreQ&usqp=CAU',
    ),
    Driver(
      name: 'Ferhat Abbas',
      phoneNumber: '05513555655',
      depart: 'Oran',
      arrivee: 'Tlemcen',
      imageUrl:
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5GqJhCPYeRpx_456iXN_bHMWVpQbqtcDreQ&usqp=CAU',
    ),
    Driver(
      name: 'Ferhat Abbas',
      phoneNumber: '05513555655',
      depart: 'Oran',
      arrivee: 'Tlemcen',
      imageUrl:
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5GqJhCPYeRpx_456iXN_bHMWVpQbqtcDreQ&usqp=CAU',
    ),
    Driver(
      name: 'Ferhat Abbas',
      phoneNumber: '05513555655',
      depart: 'Oran',
      arrivee: 'Tlemcen',
      imageUrl:
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5GqJhCPYeRpx_456iXN_bHMWVpQbqtcDreQ&usqp=CAU',
    ),
    Driver(
      name: 'Ferhat Abbas',
      phoneNumber: '05513555655',
      depart: 'Oran',
      arrivee: 'Tlemcen',
      imageUrl:
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5GqJhCPYeRpx_456iXN_bHMWVpQbqtcDreQ&usqp=CAU',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final double defaultPadding = 10;
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        title: Text(
          'Choisissez un chauffeur',
          style: TextStyle(color: Color(0xff344D59), fontSize: 20,fontFamily: 'Popping'),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 5,
      ),
      body: ListView.builder( // Utilisation du widget ListView.builder pour afficher à l'utilisateur l'ensemble des chauffeurs disponible correspandant a sa demande
        itemCount: drivers.length,
        itemBuilder: (context, index) {
          final driver = drivers[index];
          return Padding(
            padding:  EdgeInsets.all(screenWidth*0.015),
            child: Card(
              color: Colors.white,
              elevation: 8,
              margin: EdgeInsets.symmetric(horizontal: screenHeight*0.01,vertical: screenWidth*0.001),
              borderOnForeground:true,
              shape:   RoundedRectangleBorder(
                  side:  BorderSide(color: Colors.grey,width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              child:   Padding(
                padding:  EdgeInsets.all(screenWidth*0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        children: [
                      Image.network(
                        driver.imageUrl,
                        height: screenHeight*0.055,
                        width: screenWidth*0.12,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: screenWidth*0.04),
                      Column(children: [
                        Text(driver.name,
                          style: TextStyle( color: Color(0xff137C8B),fontSize: 16,fontWeight: FontWeight.bold,fontFamily: 'Popping'),
                        ),
                        Text(driver.phoneNumber,
                          style: TextStyle( color: Color(0xff7A90A4),fontSize: 14,fontWeight: FontWeight.bold,fontFamily: 'Popping'),
                        ),
                      ]),
                    ]),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Icon(Icons.location_on),
                              // SizedBox(height: screenHeight * 0.03),
                              Container(
                                height: screenHeight*0.035,
                                width: 1,
                                color: Colors.grey,
                              ),
                              // SizedBox(height: screenHeight * 0.03),
                              Icon(
                                Icons.location_on,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //crossAxisAlignment:CrossAxisAlignment.start ,
                            children: [
                              Container(
                                child: ListTile(
                                  title: Text(
                                    driver.depart,
                                    style: TextStyle(
                                        color: Color(0xff7A90A4), fontSize: 15,fontFamily: 'Popping'),
                                  ),
                                  onTap: () {
                                    // handle onTap event
                                  },
                                ),
                              ),
                              Container(
                                child: ListTile(
                                  title: Text(
                                    driver.arrivee,
                                    style: TextStyle(
                                        color: Color(0xff7A90A4), fontSize: 15,fontFamily: 'Popping'),
                                  ),
                                  onTap: () {
                                    // handle onTap event
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.all(screenWidth*0.04),
                          child: Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Details(photoUrl: 'assets/images/user-profile.png', fullName: ' weal bougessa', rating: 2, phoneNumber: '0665996688', email: 'bougessa.hrach@esi.dz', carName: 'car_pooling'),));
                              },
                              child: Text('Choisir',
                              style: TextStyle(
                                  fontFamily: 'Popping',
                              ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //
            ),
          );
        },
      ),
    );
  }
}
