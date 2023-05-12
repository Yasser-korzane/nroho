import 'package:appcouvoiturage/AppClasses/Trajet.dart';
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
              for (var i = 0; i < 5; i++)
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                              enabled: _checkboxSelected[i],
                              controller: _textControllers[i],
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                                hintText:
                                    'Entrer la Ville intermidiaire ${i + 1}',
                                hintStyle: TextStyle(
                                    fontSize: 14, fontFamily: 'Poppins'),
                                /*color: Colors.grey[800],
                                                    fontSize: 14,fontFamily: 'Poppins'),*/
                                fillColor: Colors.grey.shade100,
                                filled: true,
                              )),
                        ),
                        Checkbox(
                          value: _checkboxSelected[i],
                          onChanged: (value) {
                            _handleCheckboxChanged(i, value!);
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    )
                  ],
                ),
              SizedBox(
                height: size.height * 0.07,
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
