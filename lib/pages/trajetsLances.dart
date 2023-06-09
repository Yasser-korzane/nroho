import 'package:nroho/Services/base%20de%20donnee.dart';
import 'package:nroho/pages/detailsTrajetLancer.dart';
import 'package:nroho/pages/home.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import '../AppClasses/Trajet.dart';
class cardLancerList extends StatelessWidget {
  List<Trajet> trajetsLances ;
  cardLancerList(this.trajetsLances, {super.key});
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return trajetsLances.isEmpty ?
      const Scaffold(
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
      : Scaffold(
      body: ListView.builder(
        itemCount: trajetsLances.length,
        itemBuilder: (context, index) {
          final lancer = trajetsLances[index];
          return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.035,
                  vertical: screenHeight * 0.015),
              child: GestureDetector(
                onTap: () async{
                  final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => detailsTrajetLancer(lancer)));
                  if (result != null){
                    if (result){
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        SnackBar(
                          duration:
                          const Duration(seconds: 3),
                          content: AwesomeSnackbarContent(
                            title: 'Succés!',
                            message:
                            'Le trajet a été annulée avec succès',

                            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                            contentType: ContentType.success,
                            // to configure for material banner
                            inMaterialBanner: true,
                          ),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                      );
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => home(),));
                    }
                  }
                },
                child: Card(
                  color: Colors.white,
                  elevation: 8,
                  margin: EdgeInsets.symmetric(
                      horizontal: screenHeight * 0.01,
                      vertical: screenWidth * 0.001),
                  borderOnForeground: true,
                  shape: const RoundedRectangleBorder(
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
                                  '${BaseDeDonnee().reglerTemps(lancer.dateDepart.day)} ${BaseDeDonnee().moisAuChaine(lancer.dateDepart.month)} ${lancer.dateDepart.year}',
                                  style: const TextStyle(fontFamily: 'poppins'),
                                ),
                                Column(children: [
                                  const Text(
                                    'Le coût',
                                    style: TextStyle(fontFamily: 'Poppins'),
                                  ),
                                  Text(
                                    '${lancer.coutTrajet} DA',
                                    style: const TextStyle(fontFamily: 'Poppins'),
                                  ),
                                ])
                              ]),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10),
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
                                  const Icon(Icons.circle, color: Colors.purple),
                                  // SizedBox(height: 20),
                                  Container(
                                    height: screenHeight * 0.05,
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  // SizedBox(height: 8),
                                  const Icon(
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
                                        '${BaseDeDonnee().reglerTemps(lancer.dateDepart.hour)}:${BaseDeDonnee().reglerTemps(lancer.dateDepart.minute)}',
                                        style: const TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            fontFamily: 'Poppins'),
                                      ),
                                      subtitle: Text(
                                        lancer.villeDepart,
                                        style: const TextStyle(fontFamily: 'Poppins'),
                                      ),
                                    ),
                                  ),
                                  //SizedBox(height: screenHeight*0.03),
                                  Container(
                                    child: ListTile(
                                      title: Text(
                                        '${BaseDeDonnee().reglerTemps(lancer.tempsDePause.hour)}:${BaseDeDonnee().reglerTemps(lancer.tempsDePause.minute)} (estimation)',
                                        style: const TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            fontFamily: 'Poppins'),
                                      ),
                                      subtitle: Text(
                                        lancer.villeArrivee,
                                        style: const TextStyle(fontFamily: 'Poppins'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10),
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
                                  style: const TextStyle(
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
              )
          );
        },
      ),
    );
  }
}
