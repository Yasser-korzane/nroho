import 'package:appcouvoiturage/AppClasses/Utilisateur.dart';
import 'package:appcouvoiturage/pages/detailsconducteur.dart';
import 'package:flutter/material.dart';


class Historique extends StatelessWidget {
  Utilisateur _utilisateur;
  Historique(this._utilisateur);
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery
        .of(context)
        .size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return _utilisateur.Historique.isEmpty ?
    Scaffold(
      appBar: AppBar(
        title:Text('Historique',style: TextStyle(fontFamily: 'poppins'),) ,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),      ),
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
      : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.chevron_left, color: Colors.black)),
        title: Text('Historique',
            style: Theme.of(context).textTheme.titleLarge),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _utilisateur.Historique.length,
        itemBuilder: (context, index) {
          final lancer = _utilisateur.Historique[index];
          return  Padding(
            padding:  EdgeInsets.symmetric(horizontal: screenWidth*0.035,vertical: screenHeight*0.015),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => detailsConducteur(lancer)));
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
                                 ' 21 janvier 2024 a 18:10',
                                style: TextStyle(fontFamily: 'poppins'),
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
                                      '${lancer.dateDepart.hour}'+' : ${lancer.dateDepart.minute}',
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
                                      '${lancer.tempsDePause.hour}'+' : ${lancer.dateDepart.minute}',
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
