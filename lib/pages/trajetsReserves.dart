import 'package:appcouvoiturage/pages/Info%20de%20trajet%20reserve.dart';

import '../AppClasses/Trajet.dart';
import '../Services/base de donnee.dart';
import 'package:flutter/material.dart';

import 'home.dart';
class cardReserverList extends StatelessWidget{
  List<Trajet> trajetsReserve ;
  cardReserverList(this.trajetsReserve);
  @override
  Widget build (BuildContext context){
    final Size screenSize = MediaQuery
        .of(context)
        .size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    Trajet trajet = BaseDeDonnee().creerTrajetVide();
    trajetsReserve.add(trajet);
    return trajetsReserve.isEmpty ?
    Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Text(
              "Aucune trajet reservé pour l'instant",
              style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),
            )))
      : Scaffold(
      body: ListView.builder(
        itemCount: trajetsReserve.length,
        itemBuilder: (context, index) {
          final lancer = trajetsReserve[index];
          return  Padding(
              padding:  EdgeInsets.symmetric(horizontal: screenWidth*0.035,vertical: screenHeight*0.015),
              child: GestureDetector(
                onTap: () async{
                  final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => detailsTrajetReserver(lancer)));
                  if (result) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => home(),));
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
                          padding:  EdgeInsets.all(screenWidth*0.04),
                          child: Text(
                            '${lancer.dateDepart.day} ${BaseDeDonnee().moisAuChaine(lancer.dateDepart.month)} ${lancer.dateDepart.year}',
                            style: TextStyle(fontFamily: 'poppins'),
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
                                        '${lancer.dateDepart.hour}:${lancer.dateDepart.minute}',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                            fontFamily: 'Poppins'
                                        ),
                                      ),
                                      subtitle: Text(lancer.villeDepart,style: TextStyle(fontFamily: 'Poppins'),
                                      ),
                                    ),
                                  ),
                                  //SizedBox(height: screenHeight*0.03),
                                  Container(
                                    child: ListTile(
                                      title: Text(
                                        '${lancer.tempsDePause.hour}:${lancer.tempsDePause.minute}',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                            fontFamily: 'Poppins'
                                        ),
                                      ),
                                      subtitle: Text(lancer.villeArrivee,style: TextStyle(fontFamily: 'Poppins'),
                                      ),
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
        },),
    );
  }
}