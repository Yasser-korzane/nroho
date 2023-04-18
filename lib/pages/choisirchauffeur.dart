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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xff344D59),
          ),
          onPressed: () {},
        ),
        title: Text(
          'Choisissez un chauffeur',
          style: TextStyle(color: Color(0xff344D59), fontSize: 20),
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
            padding: const EdgeInsets.all(8.0),
            child: Card(
              margin: EdgeInsets.all(2),
              borderOnForeground:true,
              shape:   RoundedRectangleBorder(
                  side:  BorderSide(color: Colors.grey,width: 3),
                  borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              child:   Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Image.network(
                        driver.imageUrl,
                        height: 45,
                        width: 45,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 6,height: 6,),
                      Column(children: [
                        Text(driver.name,
                          style: TextStyle( color: Color(0xff137C8B),fontSize: 16,fontWeight: FontWeight.bold),
                        ),
                        Text(driver.phoneNumber,
                          style: TextStyle( color: Color(0xff7A90A4),fontSize: 14,fontWeight: FontWeight.bold),
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
                                height: 20,
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
                          flex: 9,
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //crossAxisAlignment:CrossAxisAlignment.start ,
                            children: [
                              Container(
                                child: ListTile(
                                  title: Text(
                                    driver.depart,
                                    style: TextStyle(
                                        color: Color(0xff7A90A4), fontSize: 15),
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
                                        color: Color(0xff7A90A4), fontSize: 15),
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
                          padding: const EdgeInsets.all(6.0),
                          child: SizedBox(
                            child: Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text('Choisir'),
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
