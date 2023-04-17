import 'package:flutter/material.dart';


import 'cardLancer.dart';
import 'cardReserver.dart';
import 'package:appcouvoiturage/pages/tragetLancer.dart';
import 'package:appcouvoiturage/pages/tragetReserver.dart';







class cardReserverLancerList extends StatefulWidget{
  @override
  _cardReserverLancerListeState createState()=> _cardReserverLancerListeState();
} 

class _cardReserverLancerListeState extends State<cardReserverLancerList> {

  List<dynamic> cardReservers= [
    cardReserver(firstName: 'boulachabe',lastName: 'hicham',heurDepar: '08:30 AM',heureArrive: '08:45 AM',placeArrive: 'harache',placeDepart: 'oued smar',nombraStar: 4.5 ,price: 50 ),
    cardReserver(firstName: 'korzane',lastName: 'yasser',heurDepar: '08:30 AM',heureArrive: '08:45 AM',placeArrive: 'harache',placeDepart: 'oued smar',nombraStar: 4.5 ,price: 50 ),

  ];
  List<cardLancer> cardLancers = [
    cardLancer(firstName: 'boulachabe',lastName: 'hicham',heurDepar: '08:30 AM',heureArrive: '08:45 AM',placeArrive: 'harache',placeDepart: 'oued smar',nbPassager: 3,nombraStar: 4.5 ,price: 50 ),
    cardLancer(firstName: 'korzane',lastName: 'yasser',heurDepar: '08:30 AM',heureArrive: '08:45 AM',placeArrive: 'harache',placeDepart: 'oued smar',nbPassager: 2,nombraStar: 3.7 ,price: 55 ),    
  ];
  Widget cardLancerTamplate (cardLancer){
     final Size screenSize = MediaQuery
        .of(context)
        .size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final double defaultPadding = 10;
   
    return  Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Card(
          child:Column(
            
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget> [
                  //Image، 
                  CircleAvatar(
                    //backGrounndImage: AssetImage('your image path'),
                    backgroundImage: AssetImage('asset/images/profile.png',),
                    radius: 50,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text( cardLancer.firstName),
                          Text(cardLancer.lastName)
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.star , color: Colors.amber[600] ,),
                          Text(cardLancer.nombraStar.toString())
                        ],
                        )
                    ],
                  ),
                  Column(
                    children : [
                    Text('Le court'),
                    Text(  cardLancer.price.toString() +' DA'),
                    ]
                  )
                  
                  ]
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Divider(
                  height: 3,
                  thickness: 2,
                  color: Colors.black,
                ),
              ),    
              // SizedBox(height: screenHeight*0.04),
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
                            cardLancer.heurDepar,
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(cardLancer.placeDepart),
                          onTap: () {
                            // handle onTap event
                          },
                        ),
                      ),
                     // SizedBox(height: screenHeight*0.03),
                      Container(
                        child: ListTile(
                          title: Text(
                            cardLancer.heureArrive,
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(cardLancer.placeArrive),
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
           // SizedBox(height: screenHeight*0.018),
            Container(
              child:  Row(children: [
                Icon(
                  Icons.person,
                  color: Colors.blue,
                  size: 20,
                ),
                Text( cardLancer.nbPassager.toString() +'passagers',style: TextStyle( color: Colors.blue ,  ),)
              ]),
            ),
            
            //SizedBox(height: screenHeight * 0.03),
      
              ],
          ),
           ),
    
    
    
    ),
    );
  }
  Widget cardReserverTamplate (cardReserver){
    final Size screenSize = MediaQuery
        .of(context)
        .size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final double defaultPadding = 10;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Card(
          child:Column(
            
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget> [
                  //Image، 
                  CircleAvatar(
                    //backGrounndImage: AssetImage('your image path'),
                    backgroundImage: AssetImage('asset/images/profile.png',),
                    radius: 50,
                  ),
                  Column(
                    children: [
                       Row(
                        children: [
                          Text( cardReserver.firstName),
                          Text(cardReserver.lastName)
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.star , color: Colors.amber[600] ,),
                          Text(cardReserver.nombraStar.toString())
                        ],
                        )
                    ],
                  ),
                  Column(
                    children : [
                    Text('Le court'),
                    Text(cardReserver.price.toString()+'DA'),
                    ]
                  )
                  
                  ]
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey,
                ),
              ),    
               SizedBox(height: screenHeight*0.01),
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
                            cardReserver.heurDepar,
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(cardReserver.placeDepart),
                          onTap: () {
                            // handle onTap event
                          },
                        ),
                      ),
                      //SizedBox(height: screenHeight*0.01),
                      Container(
                        child: ListTile(
                          title: Text(
                           cardReserver.heureArrive ,
                            style: TextStyle(
                              color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(cardReserver.placeArrive),
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
           // SizedBox(height: screenHeight*0.018),
           /* Container(
              child:  Row(children: [
                Icon(
                  Icons.person,
                  color: Colors.blue,
                  size: 20,
                ),
                Text('3 passagers',style: TextStyle( color: Colors.blue ,  ),)
              ]),
            ),
            
            SizedBox(height: screenHeight * 0.03),*/
      
              ],
          ),
    
    //Divider() الخط هذاك
    
    //The rest of content
    
    
    //]
    ),
    
    
    
    ),
    );

//le 'slider button ' mazel madertouche rani nsiyi fih ki yemchi w yweli kima l ui n7atou 
  }

  @override
  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey [200],
      appBar: AppBar(
        title: Text ('Historique',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20), ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          PageView(
              scrollDirection: Axis.vertical,
              children: cardLancers.map((cardLancer) =>  cardLancerTamplate(cardLancer) ).toList(),
          ),
          PageView(
                  scrollDirection: Axis.vertical,
                  children: cardReservers.map((cardReserver) =>  cardReserverTamplate(cardReserver) ).toList(),
    ),
        ],
      )
    );
  }
}