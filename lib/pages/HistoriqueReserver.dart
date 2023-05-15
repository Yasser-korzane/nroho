import '../AppClasses/Trajet.dart';
import 'package:flutter/material.dart';
import '../Services/base de donnee.dart';
import 'detailsconducteur.dart';

class cardReserverListH extends StatelessWidget{
  List<Trajet> _trajetReserves;
  cardReserverListH(this._trajetReserves);
  @override
  Widget build (BuildContext context){
    final Size screenSize = MediaQuery
        .of(context)
        .size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return _trajetReserves.isEmpty ?
    Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Text(
              "Aucun trajet parcourus pour l'instant",
              style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),
            )))
      :Scaffold(
      body: ListView.builder(
        itemCount: _trajetReserves.length,
        itemBuilder: (context, index) {
          final reserve = _trajetReserves[index];
          return  Padding(
              padding:  EdgeInsets.symmetric(horizontal: screenWidth*0.035,vertical: screenHeight*0.015),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => detailsConducteur(reserve,false),));
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
                                Text(
                                  '${reserve.dateDepart.day} ${BaseDeDonnee().moisAuChaine(reserve.dateDepart.month)} ${reserve.dateDepart.year}',
                                  style: TextStyle(fontFamily: 'poppins'),
                                ),
                                Column(
                                    children : [
                                      Text('Coût',style: TextStyle(fontFamily: 'Poppins',fontWeight: FontWeight.bold),),
                                      Text(  '${reserve.coutTrajet} DA',style: TextStyle(fontFamily: 'Poppins',fontWeight: FontWeight.bold),),
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
                                        '${BaseDeDonnee().reglerTemps(reserve.dateDepart.hour)}:${BaseDeDonnee().reglerTemps(reserve.dateDepart.minute)}',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                            fontFamily: 'Poppins'
                                        ),
                                      ),
                                      subtitle: Text(reserve.villeDepart,style: TextStyle(fontFamily: 'Poppins'),),
                                    ),
                                  ),
                                  //SizedBox(height: screenHeight*0.03),
                                  Container(
                                    child: ListTile(
                                      title: Text(
                                        '${reserve.tempsDePause.hour}:${reserve.tempsDePause.minute} (estimation)',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                            fontFamily: 'Poppins'
                                        ),
                                      ),
                                      subtitle: Text(reserve.villeArrivee,style: TextStyle(fontFamily: 'Poppins'),),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
          );
        },
        ),
    );
  }
}