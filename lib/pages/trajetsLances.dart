import 'package:appcouvoiturage/Services/base%20de%20donnee.dart';
import 'package:appcouvoiturage/pages/InfoTrajetLancerReserve.dart';
import 'package:flutter/material.dart';
import '../AppClasses/Trajet.dart';
class cardLancerList extends StatelessWidget {
  List<Trajet> trajetsLances ;
  cardLancerList(this.trajetsLances);
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return Scaffold(
      body: ListView.builder(
        itemCount: trajetsLances.length,
        itemBuilder: (context, index) {
          final lancer = trajetsLances[index];
          return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.035,
                  vertical: screenHeight * 0.015),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => detailsPassagerConducteurHis(lancer)));
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
                                  '${lancer.dateDepart.day} ${BaseDeDonnee().moisAuChaine(lancer.dateDepart.month)} ${lancer.dateDepart.year}',
                                  style: TextStyle(fontFamily: 'poppins'),
                                ),
                                Column(children: [
                                  Text(
                                    'Le cout',
                                    style: TextStyle(fontFamily: 'Poppins'),
                                  ),
                                  Text(
                                    lancer.coutTrajet.toString() + ' DA',
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
                                        '${lancer.dateDepart.hour}:${lancer.dateDepart.minute}',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            fontFamily: 'Poppins'),
                                      ),
                                      subtitle: Text(
                                        lancer.villeDepart,
                                        style: TextStyle(fontFamily: 'Poppins'),
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
                                            fontFamily: 'Poppins'),
                                      ),
                                      subtitle: Text(
                                        lancer.villeArrivee,
                                        style: TextStyle(fontFamily: 'Poppins'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: screenWidth * 0.08),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Row(children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.blue,
                                  size: screenHeight * 0.03,
                                ),
                                Text(
                                  '${lancer.plusInformations.nbPlaces} passagers',
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
