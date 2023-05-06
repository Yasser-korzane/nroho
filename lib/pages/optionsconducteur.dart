import 'package:appcouvoiturage/Services/base%20de%20donnee.dart';
import 'package:appcouvoiturage/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../AppClasses/Trajet.dart';

class optionconduc extends StatefulWidget {
  Trajet trajetLance ;
  optionconduc(this.trajetLance);
  @override
  State<optionconduc> createState() => _optionconducState();
}

class _optionconducState extends State<optionconduc> {
  List<String> nbPlaces = ['1','2','3','4'];
  String ?selectedNb = '1';
    TextEditingController _coutController = TextEditingController();
    BaseDeDonnee _baseDeDonnee = BaseDeDonnee();
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              // Navigator.pop(context)
            },
            icon: const Icon(Icons.chevron_left, color: Colors.black)),
        title: Text('Plus d\’informations',
          style: TextStyle(fontWeight: FontWeight.normal,
            fontFamily: 'Poppins',),),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(screenWidth*0.03, 0, 10, screenWidth*0.03),
        child: ListView(
            children:[ Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.1),
                //SelectableTextWidget(text: 'Etes-vous fumeur ?'),
                Card(color: Colors.white60,margin: EdgeInsets.all(16),
                  shape:   RoundedRectangleBorder(
                    side:  BorderSide(color: Colors.grey,width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(15)
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                           Text('Etes-vous fumeur ?',
                          style: TextStyle(
                            fontSize: screenHeight*0.017,
                            fontFamily: 'Poppins',
                          ),),
                        //SizedBox(width: screenWidth*0.35,),
                           Checkbox(
                            value: widget.trajetLance.plusInformations.fumeur,
                            onChanged: (value) {
                              setState(() {
                                widget.trajetLance.plusInformations.fumeur = value ?? false; // Update 'yes' with the selected value or false if value is null
                              });
                            },
                            activeColor: Colors.blue, // Optional: change the color of the checkbox when selected
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.002),
                Card(color: Colors.white60,margin: EdgeInsets.all(16),
                  shape:   RoundedRectangleBorder(
                    side:  BorderSide(color: Colors.grey,width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(15)
                    ),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Acceptez vous les bagages volumineux ?',
                          style: TextStyle(
                            fontSize: screenHeight*0.013,
                            fontFamily: 'Poppins',
                          ),),
                        Checkbox(
                          value: widget.trajetLance.plusInformations.bagage,
                          onChanged: (value) {
                            setState(() {
                              widget.trajetLance.plusInformations.bagage = value ?? false; // Update 'yes' with the selected value or false if value is null
                            });
                          },
                          activeColor: Colors.blue, // Optional: change the color of the checkbox when selected
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.002),
                Card(color: Colors.white60,margin: EdgeInsets.all(16),
                  shape:   RoundedRectangleBorder(
                    side:  BorderSide(color: Colors.grey,width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(15)
                    ),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Acceptez vous les animaux ?',
                          style: TextStyle(
                            fontSize: screenHeight*0.017,
                            fontFamily: 'Poppins',
                          ),),
                        Checkbox(
                          value: widget.trajetLance.plusInformations.animaux,
                          onChanged: (value) {
                            setState(() {
                              widget.trajetLance.plusInformations.animaux = value ?? false; // Update 'yes' with the selected value or false if value is null
                            });
                          },
                          activeColor: Colors.blue, // Optional: change the color of the checkbox when selected
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.002),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    //margin: EdgeInsets.fromLTRB(screenHeight * 0.01, 0, screenHeight * 0.01, 0),
                    //child: CustomDropdown(options: [1, 2, 3, 4])),
                    child:
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(),
                      ),
                      value: selectedNb,
                      items: nbPlaces
                          .map(
                            (item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                        ),
                      )
                          .toList(),
                      onChanged: (item) {
                        setState(() {
                          selectedNb = item;
                          widget.trajetLance.plusInformations.nbPlaces = int.parse(item!);
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  margin: EdgeInsets.fromLTRB(screenHeight * 0.01, 0, screenHeight * 0.01, 0),
                  padding: EdgeInsets.fromLTRB(screenHeight * 0.015, 0, screenHeight * 0.01, 0),
                  child: TextFormField(
                    controller: _coutController ,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(fontFamily: 'Poppins'),
                    decoration: InputDecoration(
                        fillColor: Colors.grey.shade300,
                        hintText: 'Entrer votre prix',
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        // i can you only a icon (not prefixeIcon) to show the icons out of the Textfield
                        suffixIcon: Icon(Icons.monetization_on,
                            color: Colors.black)),
                  ),
                ),
                SizedBox(height: screenHeight * 0.094),
              ],
            ),
            ]
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: size.width * 0.51,
          height: size.height * 0.048,
          child: ElevatedButton(
            onPressed: () async {
              if (_coutController.text.isNotEmpty) {
                widget.trajetLance.coutTrajet = double.parse(_coutController.text);
              } else {
                widget.trajetLance.coutTrajet = 0.0;
              }
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => home()),
                    (Route<dynamic> route) => false,
              );
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Trajet lance"),
                    content: Text("Votre trajet a ete bien lance"),
                    actions: <Widget>[
                      TextButton(
                        child: Text("OK"),
                        onPressed: () async {
                          Navigator.pop(context);
                          await _baseDeDonnee.saveTrajetLanceAsSubcollection(FirebaseAuth.instance.currentUser!.uid, widget.trajetLance);
                        },
                      ),
                    ],
                  );
                },
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
            ),
            child: const Text(
              'Valider',
              style: TextStyle(
                  color: Colors.white, fontSize: 16, fontFamily: 'Poppins'),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
