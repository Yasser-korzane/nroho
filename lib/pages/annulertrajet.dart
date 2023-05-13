import 'dart:convert';

import 'package:appcouvoiturage/Services/base%20de%20donnee.dart';
import 'package:appcouvoiturage/pages/home.dart';
import 'package:appcouvoiturage/pages/lancer_reserver.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;

import '../AppClasses/Notifications.dart';

class AnnulerTrajet extends StatefulWidget {
  String uidTrajet ;
  bool lance_reserve ; // if true alors lance else reserve
  AnnulerTrajet(this.uidTrajet,this.lance_reserve);
  @override
  State<AnnulerTrajet> createState() => _AnnulerTrajetState();
}

class _AnnulerTrajetState extends State<AnnulerTrajet> {
  final List<String> _raisons = [
    "J'ai changer ma destination.",
    " J'ai fait une erreur lors de la reservation",
    "J'ai un probleme avec le covoitureur",
    "Ce trajet ne m'intéresse plus",
    "Aucune des raisons cités ci-dessus.",
  ];
  List<bool> _checked = [
    false,
    false,
    false,
    false,
    false,
  ];
  TextEditingController _textFieldController = TextEditingController();
  bool clicked = false;
  List<Notifications> _listNot = [];
  BaseDeDonnee _baseDeDonnee = BaseDeDonnee();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Center(
            child: !clicked ?
                   AlertDialog(
                      title: Text(
                        'Annuler le trajet',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                      content: Container(
                        height: 200,
                        child: Column(children: [
                          Center(
                            child: Icon(
                              Icons.warning,
                              color: Colors.red,
                              size: 100,
                            ),
                          ),
                          Center(
                              child: Text(
                            "Voulez vous annuler ce trajet ?",
                            style:
                                TextStyle(fontFamily: 'Poppins', fontSize: 16),
                          )),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green),
                                  onPressed: () {setState(
                                        () {
                                      clicked = !clicked;
                                    },
                                  );},
                                  child: Text(
                                    'Oui',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white),
                                  )),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red),
                                  onPressed: () {Navigator.pop(context);},
                                  child: Text(
                                    'Non',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white),
                                  )),
                            ],
                          )
                        ]),
                      ),
                    )
                  :AlertDialog(
                title: Text(
                    'Quelle est la raison qui vous pousse à annuler ce trajet ?'),
                content: SizedBox(
                  width: double.maxFinite,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: _raisons.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CheckboxListTile(
                            value: _checked[index],
                            onChanged: (bool? value) {
                              setState(() {
                                _checked[index] = value!;
                              });
                            },
                            title: Text(
                              _raisons[index],
                              style: TextStyle(
                                fontFamily: 'Poppins',
                              ),
                            ),
                          );
                        },
                      ),
                      TextField(
                        controller: _textFieldController,
                        decoration: InputDecoration(
                          hintText: 'Raison supplémentaire...',
                        ),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('OK'),
                    onPressed: () async{
                      /// if (search in notification if this trajet id exist in notifications with accepter = false)
                      /// delete normally
                      if (widget.lance_reserve) await _baseDeDonnee.annulerTrajetLance(FirebaseAuth.instance.currentUser!.uid,widget.uidTrajet);
                      else await _baseDeDonnee.annulerTrajetReserve(FirebaseAuth.instance.currentUser!.uid,widget.uidTrajet);
                      String text = 'L\'utilisateur ${FirebaseAuth.instance.currentUser!.uid} a annuller un trajet pour les raisons suivantes :\n';
                      _listNot = await _baseDeDonnee.getNotifications(FirebaseAuth.instance.currentUser!.uid);
                      for (Notifications n in _listNot){
                        if (n.id_trajet == widget.uidTrajet){
                          if (n.accepte_refuse) {
                            int i = 0 ;
                            for (bool b in _checked){
                              if (b) text += _raisons[i]+'\n';
                              i++ ;
                            }
                            text += 'Raison supplémentaire : ${_textFieldController.text}';
                            /// send email to admin and send notification to the next user
                            /// 1) send notification :
                            /// 2) send email
                            break;
                          }
                        }
                      }
                      print('*******************************************************************');
                      print("message = $text");
                      print('*******************************************************************');
                      /// else : soit envoier un email de nous et nous va supprimer ce trajet et on contact les autres
                      /// ou on le laise le supprimer et on envoi une notification de l'autre coté beli rah ne7a trajet
                      Navigator.pop(context,true);
                    },
                  ),
                ],
              ),
          ),
        ),
      ),
    );
  }
}
