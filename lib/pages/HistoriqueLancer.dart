import 'package:appcouvoiturage/pages/Commancer.dart';

import 'cardLancer.dart';
import 'package:flutter/material.dart';




class cardLancerListH extends StatelessWidget{
  final List<cardLancer> cardLancers = [
    cardLancer(firstName: 'boulachabe',lastName: 'hicham',heurDepar: '08:30 AM',heureArrive: '08:45 AM',placeArrive: 'harache',placeDepart: 'oued smar',nbPassager: 3,nombraStar: 4.5 ,price: 50 ),
    cardLancer(firstName: 'korzane',lastName: 'yasser',heurDepar: '08:30 AM',heureArrive: '08:45 AM',placeArrive: 'harache',placeDepart: 'oued smar',nbPassager: 2,nombraStar: 3.7 ,price: 55 ),
    cardLancer(firstName: 'korzane',lastName: 'yasser',heurDepar: '08:30 AM',heureArrive: '08:45 AM',placeArrive: 'harache',placeDepart: 'oued smar',nbPassager: 2,nombraStar: 3.7 ,price: 55 ),
    cardLancer(firstName: 'korzane',lastName: 'yasser',heurDepar: '08:30 AM',heureArrive: '08:45 AM',placeArrive: 'harache',placeDepart: 'oued smar',nbPassager: 2,nombraStar: 3.7 ,price: 55 ),
    cardLancer(firstName: 'korzane',lastName: 'yasser',heurDepar: '08:30 AM',heureArrive: '08:45 AM',placeArrive: 'harache',placeDepart: 'oued smar',nbPassager: 2,nombraStar: 3.7 ,price: 55 ),

  ];
  // Widget cardLancerTamplate (cardLancer){
  @override
  Widget build (BuildContext context){
    final Size screenSize = MediaQuery
        .of(context)
        .size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final double defaultPadding = 10;
    return Scaffold(
      body: ListView.builder(
        itemCount: cardLancers.length,
        itemBuilder: (context, index) {
          final lancer = cardLancers[index];
          return  Padding(
              padding:  EdgeInsets.symmetric(horizontal: screenWidth*0.035,vertical: screenHeight*0.015),
              child: Card(
                color: Colors.white,
                elevation: 8,
                margin: EdgeInsets.symmetric(horizontal: screenHeight*0.01,vertical: screenWidth*0.001),
                borderOnForeground:true,
                shape:   RoundedRectangleBorder(
                  side:  BorderSide(color: Colors.grey,width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(15)
                  ),
                ),
                child: Padding(
                  padding:  EdgeInsets.all(screenWidth*0.02),
                  child: Column(
                    children: [
                      Padding(
                        padding:  EdgeInsets.all(screenWidth*0.015),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget> [
                              //Image،
                              Container(
                                height: screenHeight*0.06,
                                width: screenHeight*0.06,
                                child: CircleAvatar(
                                  //backGrounndImage: AssetImage('your image path'),
                                  backgroundImage: AssetImage('asset/images/profile.png',),
                                  radius: 50,
                                ),
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(lancer.firstName),
                                      Text(lancer.lastName),
                                      SizedBox(
                                        height: 1,
                                        width: 90,
                                      )
                                    ],
                                  ),
                                  Row(
                                    //crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons.star , color: Colors.amber[600] ,),
                                      Text(lancer.nombraStar.toString()),
                                      SizedBox(
                                        height: 1,
                                        width: 160,
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                  children : [
                                    Text('Le court'),
                                    Text(  lancer.price.toString() +' DA'),
                                  ]
                              )

                            ]
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:10.0, right: 10),
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
                                  height: screenHeight* 0.05,
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
                                      ),
                                    ),
                                    subtitle: Text(lancer.placeDepart),
                                    onTap: () {
                                      // handle onTap event
                                    },
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
                                      ),
                                    ),
                                    subtitle: Text(lancer.placeArrive),
                                    onTap: () {
                                      // handle onTap event
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      //SizedBox(height: screenHeight*0.018),
                      Padding(
                        padding: const EdgeInsets.only(left:10.0, right: 10),
                        child: Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: screenWidth*0.06),
                        child: Container(
                          child:  Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.blue,
                                  size: screenHeight*0.03,
                                ),
                                Text(' '+ lancer.nbPassager.toString() +' passagers',style: TextStyle( color: Colors.blue ,  ),)
                              ]),
                        ),
                      ),
                      // SizedBox(height: screenHeight * 0.03),
                    ],
                  ),
                ),
              )
          );
        },),
    );
  }
}