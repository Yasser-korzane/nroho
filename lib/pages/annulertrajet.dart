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
                                  'Quelle est la raison qui vous pousse à annuler ce trajet ?'),
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
                                  Center(child: Text("Êtes vous sur  ",    style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 20
                                ),)),
                                  Center(child: Text("de vouloir annuler ce trajet?",    style: TextStyle(
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
                                      onPressed: (){}, child: Text('Oui',    style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white
                                ),) ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red
                              
                                      ),
                                      onPressed: (){}, child: Text('Non',    style: TextStyle(
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
