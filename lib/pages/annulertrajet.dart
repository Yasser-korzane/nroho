import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class AnnulerTrajet extends StatefulWidget {
  const AnnulerTrajet({Key? key});

  @override
  State<AnnulerTrajet> createState() => _AnnulerTrajetState();
}

class _AnnulerTrajetState extends State<AnnulerTrajet> {
  final List<String> _raisons = [
    "J'ai changer ma destination.",
    " j'ai fait une erreur de choix de place.",
    "j'ai un probleme avec li kont 7a nro7 m3a",
    "je ne veut pas aller vers ce trajet.",
    "aucune raison.",
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Center(
            child: ElevatedButton(
              child: Text('Annuler Trajet'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(builder: (context, setState) {
                      return !clicked
                          ? AlertDialog(
                              title: Text(
                                  'Pourquoi voulez-vous annuler le trajet?'),
                              content: SizedBox(
                                width: double.maxFinite,
                                child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: _raisons.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
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
                                  child: Text('Annuler'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    setState(
                                      () {
                                        clicked = !clicked;
                                      },
                                    );
                                  },
                                ),
                              ],
                            )
                          : AlertDialog(
                              title: Text('Annuler le trajet',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                              ),),
                              content: Container(
                                height: 250,
                                child: Column(children: [
                                  Center(child: Icon(Icons.warning,
                                  color: Colors.red,
                                  size: 100,
                                  ),),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(child: Text("Est ce que vous etes sur ",    style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 20
                                ),)),
                                  Center(child: Text("d'annuler votre trajet?",    style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 20
                                ),),),
                                SizedBox(
                                  height: 10,
                                ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green
                                        
                                      ),
                                      onPressed: (){}, child: Text('OUI',    style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white
                                ),) ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red
                              
                                      ),
                                      onPressed: (){}, child: Text('NON',    style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white
                                 
                                ),)),
                                  ],)
                                ]),
                              ),
                            );
                    });
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
