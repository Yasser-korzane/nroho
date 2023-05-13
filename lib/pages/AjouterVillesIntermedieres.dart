import 'package:appcouvoiturage/AppClasses/Trajet.dart';
import 'package:appcouvoiturage/pages/ChoixVillesIntermedieres.dart';
import 'package:flutter/material.dart';
import 'optionsconducteur.dart';

class AjouterVillesIntermedieres extends StatefulWidget {
  Trajet _trajetLance;
  AjouterVillesIntermedieres(this._trajetLance);

  @override
  State<AjouterVillesIntermedieres> createState() =>
      _AjouterVillesIntermedieresState();
}

class _AjouterVillesIntermedieresState
    extends State<AjouterVillesIntermedieres> {
  List<bool> _checkboxSelected = List.generate(
    5,
    (_) => false,
  );
  List<TextEditingController> _textControllers = List.generate(
    5,
    (_) => TextEditingController(),
  );

  @override
  void dispose() {
    for (var controller in _textControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _handleCheckboxChanged(int index, bool value) {
    setState(() {
      _checkboxSelected[index] = value;
    });
  }
  List<String> listVillesIntermediers = [];
  String ville1 = '' ;
  String ville2 = '' ;
  String ville3 = '' ;
  String ville4 = '' ;
  String ville5 = '' ;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Villes intermédiaires',
          style: TextStyle(fontFamily: 'poppins'),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              child: Icon(Icons.question_mark),
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) {
                    return AlertDialog(
                        content: Text(
                      'En incluant des villes intermédiaires dans votre trajet, vous avez la possibilité de partager votre voyage avec d\'autres passagers dont le trajet se situe sur une portion de votre itinéraire.',
                      style: TextStyle(fontFamily: 'poppins'),
                    ));
                  },
                );
              },
            ),
            SizedBox(
              width: size.width * 0.3,
              height: size.height * 0.048,
              child: FloatingActionButton(
                backgroundColor: Colors.blue,
                child: Text(
                  'Suivant',
                  style: TextStyle(
                      color: Colors.white, fontSize: 16, fontFamily: 'Poppins'),
                ),
                onPressed: () {
                  if (ville1.isNotEmpty) listVillesIntermediers.add(ville1);
                  if (ville2.isNotEmpty) listVillesIntermediers.add(ville2);
                  if (ville3.isNotEmpty) listVillesIntermediers.add(ville3);
                  if (ville4.isNotEmpty) listVillesIntermediers.add(ville4);
                  if (ville5.isNotEmpty) listVillesIntermediers.add(ville5);
                  widget._trajetLance.villeIntermediaires = listVillesIntermediers;
                  widget._trajetLance.afficher();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              optionconduc(widget._trajetLance)));
                },
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.12,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.none,
                        enabled: _checkboxSelected[0],
                        controller: _textControllers[0],
                        onTap: () async{
                            ville1 = await showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return ChoixVillesIntermedieres();
                            },
                          );
                          if (ville1.isNotEmpty) _textControllers[0].text = ville1;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(12)),
                          ),
                          hintText:
                          'Entrer la Ville intermidiaire 1',
                          hintStyle: TextStyle(
                              fontSize: 14, fontFamily: 'Poppins'),
                          fillColor: Colors.grey.shade100,
                          filled: true,
                        )
                    ),
                  ),
                  Hero(tag: '0',
                    child: Checkbox(
                      value: _checkboxSelected[0],
                      onChanged: (value) {
                        _handleCheckboxChanged(0, value!);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                        enabled: _checkboxSelected[1],
                        controller: _textControllers[1],
                        onTap: () async{
                            ville2 = await showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return ChoixVillesIntermedieres();
                            },
                          );
                          if (ville1.isNotEmpty) _textControllers[1].text = ville2;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(12)),
                          ),
                          hintText:
                          'Entrer la Ville intermidiaire 2',
                          hintStyle: TextStyle(
                              fontSize: 14, fontFamily: 'Poppins'),
                          fillColor: Colors.grey.shade100,
                          filled: true,
                        )),
                  ),
                  Hero(tag: '1',
                    child: Checkbox(
                      value: _checkboxSelected[1],
                      onChanged: (value) {
                        _handleCheckboxChanged(1, value!);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                        enabled: _checkboxSelected[2],
                        controller: _textControllers[2],
                        onTap: () async{
                          ville3 = await showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return ChoixVillesIntermedieres();
                            },
                          );
                          if (ville1.isNotEmpty) _textControllers[2].text = ville3;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(12)),
                          ),
                          hintText:
                          'Entrer la Ville intermidiaire 3',
                          hintStyle: TextStyle(
                              fontSize: 14, fontFamily: 'Poppins'),
                          fillColor: Colors.grey.shade100,
                          filled: true,
                        )),
                  ),
                  Hero(tag: '2',
                    child: Checkbox(
                      value: _checkboxSelected[2],
                      onChanged: (value) {
                        _handleCheckboxChanged(2, value!);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                        enabled: _checkboxSelected[3],
                        controller: _textControllers[3],
                        onTap: () async{
                          ville4 = await showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return ChoixVillesIntermedieres();
                            },
                          );
                          if (ville1.isNotEmpty) _textControllers[3].text = ville4;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(12)),
                          ),
                          hintText:
                          'Entrer la Ville intermidiaire 4',
                          hintStyle: TextStyle(
                              fontSize: 14, fontFamily: 'Poppins'),
                          fillColor: Colors.grey.shade100,
                          filled: true,
                        )),
                  ),
                  Hero(tag: '3',
                    child: Checkbox(
                      value: _checkboxSelected[3],
                      onChanged: (value) {
                        _handleCheckboxChanged(3, value!);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                        enabled: _checkboxSelected[4],
                        controller: _textControllers[4],
                        onTap: () async{
                          ville5 = await showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return ChoixVillesIntermedieres();
                            },
                          );
                          if (ville1.isNotEmpty) _textControllers[4].text = ville5;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(12)),
                          ),
                          hintText:
                          'Entrer la Ville intermidiaire 5',
                          hintStyle: TextStyle(
                              fontSize: 14, fontFamily: 'Poppins'),
                          /*color: Colors.grey[800],
                                                    fontSize: 14,fontFamily: 'Poppins'),*/
                          fillColor: Colors.grey.shade100,
                          filled: true,
                        )),
                  ),
                  Hero(tag: '4',
                    child: Checkbox(
                      value: _checkboxSelected[4],
                      onChanged: (value) {
                        _handleCheckboxChanged(4, value!);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),

              RichText(
                text: TextSpan(
                  text:
                      'Vous avez la possibilité d\'ajouter des villes intermédiaires, mais cela reste facultatif. Si vous ne souhaitez pas en ajouter, vous pouvez simplement cliquer sur ',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'poppins',
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: 'suivant',
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 16,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
