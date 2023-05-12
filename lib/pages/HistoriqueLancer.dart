import '../AppClasses/Trajet.dart';
import 'package:flutter/material.dart';

import 'detailsconducteur.dart';
class cardLancerListH extends StatelessWidget{
  List<Trajet> _trajetLances;
  cardLancerListH(this._trajetLances);
  @override
  Widget build (BuildContext context){
    final Size screenSize = MediaQuery
        .of(context)
        .size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return _trajetLances.isEmpty ?
    Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Text(
              "Aucune trajet lancé pour l'instant",
              style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),
            )))
        :Scaffold(
      body: ListView.builder(
        itemCount: _trajetLances.length,
        itemBuilder: (context, index) {
          final lancer = _trajetLances[index];
          return  Padding(
              padding:  EdgeInsets.symmetric(horizontal: screenWidth*0.035,vertical: screenHeight*0.015),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => detailsConducteur(lancer),));
                },
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget> [
                                //Image،
                                Container(
                                  height: screenHeight*0.06,
                                  width: screenHeight*0.06,
                                  child: CircleAvatar(
                                    //backGrounndImage: AssetImage('your image path'),
                                    backgroundImage: NetworkImage('https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1031&q=80'),
                                    radius: 50,
                                  ),
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text('nom',style: TextStyle(fontFamily: 'Poppins'),),
                                        Text('prenom',style: TextStyle(fontFamily: 'Poppins'),),
                                        SizedBox(
                                          height: 1,
                                          width: 50,
                                        )
                                      ],
                                    ),
                                    Row(
                                      //crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.star , color: Colors.amber[600] ,),
                                        Text('4',style: TextStyle(fontFamily: 'Poppins'),),
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
                                      Text('Coût',style: TextStyle(fontFamily: 'Poppins',fontWeight: FontWeight.bold),),
                                      Text(  '${lancer.coutTrajet} DA',style: TextStyle(fontFamily: 'Poppins',fontWeight: FontWeight.bold),),
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
                                        '${lancer.dateDepart}',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                            fontFamily: 'Poppins'
                                        ),
                                      ),
                                      subtitle: Text(lancer.villeDepart,style: TextStyle(fontFamily: 'Poppins'),),
                                    ),
                                  ),
                                  //SizedBox(height: screenHeight*0.03),
                                  Container(
                                    child: ListTile(
                                      title: Text(
                                        '${lancer.tempsDePause}',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                            fontFamily: 'Poppins'
                                        ),
                                      ),
                                      subtitle: Text(lancer.villeArrivee,style: TextStyle(fontFamily: 'Poppins'),),
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
                                  Text('${lancer.plusInformations.nbPlaces} passagers',style: TextStyle( color: Colors.blue , fontFamily: 'Poppins' ),)
                                ]),
                          ),
                        ),
                        // SizedBox(height: screenHeight * 0.03),
                      ],
                    ),
                  ),
                ),
              ),
          );
        },),
    );
  }
}