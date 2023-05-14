import 'package:appcouvoiturage/AppClasses/Trajet.dart';
import 'package:appcouvoiturage/Services/base%20de%20donnee.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Rating extends StatefulWidget {
  Trajet _trajet;

  Rating(this._trajet);

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  int currentRating = 0;
  final TextEditingController _userFeedbackController = TextEditingController();
  final TextEditingController _routeFeedbackController = TextEditingController();
  BaseDeDonnee baseDeDonnee=new BaseDeDonnee();

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: AlertDialog(
              title: Align(child: Text('Fin du trajet!',style: TextStyle(fontFamily: 'Poppins'),),alignment: Alignment.center,),
              content: Column(
                  children: [
                      SizedBox(height: 20,),
                      Text('Évaluez votre partenaire du trajet :',style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                        ),
                      ),
                    SizedBox(height:8),
                    Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: List.generate(5, (index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                currentRating = index + 1;
                              });
                            },
                            child: Icon(
                              Icons.star,
                              color: index < currentRating
                                  ? Colors.yellow
                                  : Colors.grey,
                              size: 40,
                            ),
                          );
                        }),
                      ),
                    SizedBox(height:16),
                    Divider(color: Colors.black54,),
                    SizedBox(height:16),
                        Text(
                          'Donnez votre avis sur votre partenaire du trajet',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextField(
                          controller: _userFeedbackController,
                          decoration: InputDecoration(
                            hintText: 'Avis sur le partenaire',
                            hintStyle: TextStyle(fontFamily: 'Poppins'),
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Text(
                          'Donnez votre avis sur le trajet parcouru',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextField(
                          controller: _routeFeedbackController,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontFamily: 'Poppins'),
                            hintText: 'Avis sur le trajet',
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text('En cas de litige ou de problème vous pouvez aller vers le site et signaler votre partenaire du trajet',style: TextStyle(fontFamily: 'Poppins'),),
                        SizedBox(height: 6.0),
                        Center(
                          child: MaterialButton(
                            elevation: 10,
                            color: Colors.red[200],
                            onPressed: (){
                              /// incrementer nbSignalement
                              launch('https://karimiarkane.github.io/NrohoSignaler.github.io/');
                            },
                            child: Text('Signaler',style: TextStyle(fontFamily: 'Poppins',color: Colors.red[400]),),
                          ),
                        ),
                  ],
                ),
              actions: <Widget>[
                TextButton(
                  child: Text('Terminer'),
                  onPressed: () {
                    widget._trajet.avis=_routeFeedbackController.text;
                    baseDeDonnee.saveHistoriqueAsSubcollection(FirebaseAuth.instance.currentUser!.uid, widget._trajet);
                    Navigator.pop(context);
                    // Do something with the rating
                  },
                ),
              ],
            ),
    );
  }


}
