import 'package:appcouvoiturage/pages/InfoTrajetLancerReserve.dart';
import 'package:appcouvoiturage/pages/trajet.dart';
import 'package:flutter/material.dart';

import 'cardLancer.dart';

class cardLancerList extends StatelessWidget {
  final List<cardLancer> cardLancers = [
    cardLancer(
        firstName: 'boulachabe',
        lastName: 'hicham',
        heurDepar: '08:30 AM',
        heureArrive: '08:45 AM',
        placeArrive: 'harache',
        placeDepart: 'oued smar',
        nbPassager: 3,
        nombraStar: 4.5,
        price: 50),
    cardLancer(
        firstName: 'korzane',
        lastName: 'yasser',
        heurDepar: '08:30 AM',
        heureArrive: '08:45 AM',
        placeArrive: 'harache',
        placeDepart: 'oued smar',
        nbPassager: 2,
        nombraStar: 3.7,
        price: 55),
    cardLancer(
        firstName: 'korzane',
        lastName: 'yasser',
        heurDepar: '08:30 AM',
        heureArrive: '08:45 AM',
        placeArrive: 'harache',
        placeDepart: 'oued smar',
        nbPassager: 2,
        nombraStar: 3.7,
        price: 55),
    cardLancer(
        firstName: 'korzane',
        lastName: 'yasser',
        heurDepar: '08:30 AM',
        heureArrive: '08:45 AM',
        placeArrive: 'harache',
        placeDepart: 'oued smar',
        nbPassager: 2,
        nombraStar: 3.7,
        price: 55),
    cardLancer(
        firstName: 'korzane',
        lastName: 'yasser',
        heurDepar: '08:30 AM',
        heureArrive: '08:45 AM',
        placeArrive: 'harache',
        placeDepart: 'oued smar',
        nbPassager: 2,
        nombraStar: 3.7,
        price: 55),
  ];

  final List<String> Passagers = [
    'allah akbar',
    'allah akbar ',
    'allah akbar ',

  ];


  // Widget cardLancerTamplate (cardLancer){
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => OuAllezVous()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        shape: CircleBorder(),
      ),
      body: ListView.builder(
        itemCount: cardLancers.length,
        itemBuilder: (context, index) {
          final lancer = cardLancers[index];
          return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.035,
                  vertical: screenHeight * 0.015),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => detailsPassagerConducteurHis()));
                },
                child: Card(
                  color: Colors.white,
                  elevation: 8,
                  margin: EdgeInsets.symmetric(
                      horizontal: screenHeight * 0.01,
                      vertical: screenWidth * 0.001),
                  borderOnForeground: true,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.02),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(screenWidth * 0.015),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  ' 21 janvier 2024 a 18:10',
                                  style: TextStyle(fontFamily: 'poppins'),
                                ),
                                Column(children: [
                                  Text(
                                    'Le cout',
                                    style: TextStyle(fontFamily: 'Poppins'),
                                  ),
                                  Text(
                                    lancer.price.toString() + ' DA',
                                    style: TextStyle(fontFamily: 'Poppins'),
                                  ),
                                ])
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.black,
                          ),
                        ),
                        //SizedBox(height: screenHeight*0.04),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Icon(Icons.circle, color: Colors.purple),
                                  // SizedBox(height: 20),
                                  Container(
                                    height: screenHeight * 0.05,
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  // SizedBox(height: 8),
                                  Icon(
                                    Icons.circle_outlined,
                                    color: Colors.purple,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Column(
                                children: [
                                  Container(
                                    child: ListTile(
                                      title: Text(
                                        lancer.heurDepar,
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            fontFamily: 'Poppins'),
                                      ),
                                      subtitle: Text(
                                        lancer.placeDepart,
                                        style: TextStyle(fontFamily: 'Poppins'),
                                      ),
                                    ),
                                  ),
                                  //SizedBox(height: screenHeight*0.03),
                                  Container(
                                    child: ListTile(
                                      title: Text(
                                        lancer.heureArrive,
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            fontFamily: 'Poppins'),
                                      ),
                                      subtitle: Text(
                                        lancer.placeArrive,
                                        style: TextStyle(fontFamily: 'Poppins'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        //SizedBox(height: screenHeight*0.018),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: screenWidth * 0.06),
                          child: GestureDetector(
                            onTap: (){
                              showModalBottomSheet(
                                  isDismissible: true,
                                  context: context,
                                  builder: (context) => Builder(
                                builder: (context) {
                                  if (Passagers.isEmpty) {
                                    // If the list is empty, display a message
                                    return Center(
                                        child: Text(
                                            'Il y a pas de ville intermidiere'));
                                  } else {
                                    // If the list is not empty, display the commentaires in a ListView
                                    return ListView.separated(
                                      separatorBuilder: (context, index) => Divider(
                                        thickness: 1.0,
                                        color: Colors.grey[300],
                                      ),
                                      itemCount: Passagers.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListTile(
                                            leading: Icon(Icons.person_outline_outlined),
                                            title: Text(
                                              Passagers[index],
                                              style: TextStyle(
                                                fontFamily: 'poppins',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                              )
                              );
                            },
                            child: Container(
                              child: Row(children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.blue,
                                  size: screenHeight * 0.03,
                                ),
                                Text(
                                  ' ' + lancer.nbPassager.toString() + ' passagers',
                                  style: TextStyle(
                                      color: Colors.blue, fontFamily: 'Poppins'),
                                )
                              ]),
                            ),
                          ),
                        ),
                        // SizedBox(height: screenHeight * 0.03),
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
