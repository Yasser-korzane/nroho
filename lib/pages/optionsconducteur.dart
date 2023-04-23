import 'package:appcouvoiturage/widgets/selectabletext.dart';
import 'package:flutter/material.dart';

class optionconduc extends StatefulWidget {
  const optionconduc({Key? key}) : super(key: key);

  @override
  State<optionconduc> createState() => _optionconducState();
}

class _optionconducState extends State<optionconduc> {
  List<String> nbPlaces = ['1','2','3','4'];
  String ?selectedNb = '1';
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery
        .of(context)
        .size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              // Navigator.pop(context)
            },
            icon: const Icon(Icons.chevron_left, color: Colors.black)),
        title: Text('Plus d’informations',
          style: TextStyle(fontWeight: FontWeight.normal,
            fontSize: screenHeight*0.035,
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
                SelectableTextWidget(
                    text: 'Etes-vous fumeur ?'),
                SizedBox(height: screenHeight * 0.03),
                SelectableTextWidget(text: ' Acceptez vous un bagages volumineux ?'),
                SizedBox(height: screenHeight * 0.03),
                SelectableTextWidget(text: 'Acceptez vous les animaux ?'),
                SizedBox(height : screenHeight * 0.03),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    //margin: EdgeInsets.fromLTRB(screenHeight * 0.01, 0, screenHeight * 0.01, 0),
                    //child: CustomDropdown(options: [1, 2, 3, 4])),
                    child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              //borderSide: BorderSide(color: Colors.black),
                            )
                        ),
                        value: selectedNb,
                        items: nbPlaces
                            .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(item,style: TextStyle(fontFamily: 'Popping'),),))
                            .toList(),
                        onChanged: (item) => setState(() => selectedNb = item)),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  margin: EdgeInsets.fromLTRB(screenHeight * 0.01, 0, screenHeight * 0.01, 0),
                  padding: EdgeInsets.fromLTRB(screenHeight * 0.015, 0, screenHeight * 0.01, 0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontFamily: 'Popping'),
                    decoration: InputDecoration(
                        fillColor: Colors.grey.shade300,
                        labelText: 'Proposer votre prix',
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        // i can you only a icon (not prefixeIcon) to show the icons out of the Textfield
                        suffixIcon: Icon(Icons.monetization_on,
                            color: Colors.black)),
                  ),
                ),
                SizedBox(height: screenHeight * 0.25),
                SizedBox(
                    width: screenWidth * 0.5,
                    child: ElevatedButton(
                      onPressed: () {
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          side: BorderSide.none,
                          shape: const StadiumBorder()),
                      child: const Text('Valider',
                          style: TextStyle(color: Colors.white,fontFamily: 'Popping')),
                    )
                ),
              ],
            ),
            ]
        ),
      ),
    );
  }
}
