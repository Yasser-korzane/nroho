import 'cardLancer.dart';
import 'cardReserver.dart';
import 'package:flutter/material.dart';



void main () => runApp(MaterialApp(
  home: cardLancerList(),
));

class cardLancerList extends StatefulWidget{
  @override
  _cardLancerListeState createState()=> _cardLancerListeState();
} 
class _cardLancerListeState extends State<cardLancerList> {
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
                padding: const EdgeInsets.all(10.0),
                child: Divider(
                  height: 3,
                  thickness: 2,
                  color: Colors.black,
                ),
              ),    
               SizedBox(height: screenHeight*0.04),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Icon(Icons.circle, color: Colors.purple),
                      // SizedBox(height: 20),
                      Container(
                        height: screenHeight* 0.09,
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
                      SizedBox(height: screenHeight*0.03),
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
            SizedBox(height: screenHeight*0.018),
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
            
            SizedBox(height: screenHeight * 0.03),
      
              ],
          ),
    
    //Divider() الخط هذاك
    
    //The rest of content
    
    
    //]
    ),
    
    
    
    ),
    );
  }
  @override
  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey [200],
      appBar: AppBar(
        title: Text ('Mes tragets',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20), ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: PageView(
              scrollDirection: Axis.vertical,
              children: cardLancers.map((cardLancer) =>  cardLancerTamplate(cardLancer) ).toList(),
    )
    );
  }
}