import 'dart:convert';

import 'package:nroho/Services/base%20de%20donnee.dart';
import 'package:nroho/pages/Demandes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../AppClasses/Notifications.dart';
import 'package:http/http.dart' as http;


class AnnulerTrajet extends StatefulWidget {
  String uidTrajet ;
  bool lance_reserve ; // if true alors lance else reserve
  AnnulerTrajet(this.uidTrajet,this.lance_reserve);
  @override
  State<AnnulerTrajet> createState() => _AnnulerTrajetState();
}

class _AnnulerTrajetState extends State<AnnulerTrajet> {
  final List<String> _raisons = [
    "J'ai changé ma destination.",
    "J'ai fait une erreur lors de lancement",
    "J'ai un probléme avec le covoitureur",
    "Ce trajet ne m'intéresse plus",
    "Aucune des raisons cités",
  ];
  List<bool> _checked = [
    false,
    false,
    false,
    false,
    false,
  ];
  List<String> _Stringchecked =[];
  TextEditingController _textFieldController = TextEditingController();
  bool clicked = false;
  List<Notifications> _listNot = [];
  BaseDeDonnee _baseDeDonnee = BaseDeDonnee();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
                            height: 4,
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
                    'Pourquoi vous voulez annuler votre trajet ?'),
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
                                if(value==true){
                                  _Stringchecked.add(_raisons[index]);
                                }else{
                                  _Stringchecked.remove(_raisons[index]);
                                }
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
                      print(_Stringchecked);
                      /// if (search in notification if this trajet id exist in notifications with accepter = false)
                      /// delete normally
                      if (widget.lance_reserve) await _baseDeDonnee.annulerTrajetLance(FirebaseAuth.instance.currentUser!.uid,widget.uidTrajet);
                      else await _baseDeDonnee.annulerTrajetReserve(FirebaseAuth.instance.currentUser!.uid,widget.uidTrajet);
                      String text = 'L\'utilisateur ${FirebaseAuth.instance.currentUser!.uid} avec l\'email ${FirebaseAuth.instance.currentUser!.email} a annulé un trajet pour les raisons suivantes :\n';
                      _listNot = await _baseDeDonnee.getNotifications(FirebaseAuth.instance.currentUser!.uid);
                      print(_listNot.isEmpty);
                      for (Notifications n in _listNot){
                        if (n.id_trajetLance == widget.uidTrajet || n.id_trajetReserve == widget.uidTrajet){
                          print("not rhi exist");
                          if (n.accepte_refuse) {
                            print("trajet est valide");
                            int i = 0 ;
                            for (bool b in _checked){
                              if (b) text += _raisons[i]+'\n';
                              i++ ;
                            }
                            text += 'Raison supplémentaire : ${_textFieldController.text}';
                            /// send email to admin and send notification to the next user
                            /// 1) send notification :
                            String fcmToken = '' ;
                            if (n.id_trajetReserve == widget.uidTrajet) fcmToken = await _baseDeDonnee.getFcmTocken(n.id_conducteur);
                            else if (n.id_trajetLance == widget.uidTrajet) fcmToken = await _baseDeDonnee.getFcmTocken(n.id_pasagers);
                            await sendNotification(fcmToken, "Trajet annulé!", 'Votre partenaire avec l\'email ${FirebaseAuth.instance.currentUser!.email} a annulé le trajet');
                            /// 2) send email :
                            sendEmail(FirebaseAuth.instance.currentUser!.email,_Stringchecked.toString());
                            ///
                            break;
                          }
                        }
                      }
                      print('*******************************************************************');
                      print("message = $text");
                      print('*******************************************************************');
                      /// on envoi une notification de l'autre coté beli rah ne7a trajet
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
Future sendEmail(String? from_name,String message) async{
  final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
  const serviceId= "service_5ztocbr";
  const templateId= "template_enemzmj";
  const userId= "5QCdePheDF7vaRWcr";
  final response = await http.post(url,
      headers: {'Content-Type': 'application/json',
        'origin': 'https://localhost'},
      body: json.encode({
        "service_id": serviceId,
        "template_id": templateId,
        "user_id": userId,
        "template_params":{
          "from_name": from_name,
          "message": message,
        }
      })
  );
  print(response.statusCode);
  print(response.body);
  return response.statusCode;
}
