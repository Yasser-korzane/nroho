import 'package:appcouvoiturage/widgets/customdropdown.dart';
import 'package:appcouvoiturage/widgets/selectabletext.dart';
import 'package:flutter/material.dart';

class options extends StatefulWidget {
  const options({Key? key}) : super(key: key);

  @override
  State<options> createState() => _optionsState();
}

class _optionsState extends State<options> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery
        .of(context)
        .size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final double defaultPadding = 10;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
               //Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: Color(0xff344D59))
        ),
        title: Text('Plus d’informations',
            style: TextStyle(color: Color(0xff344D59))),
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
                  text: 'Acceptez-vous un conducteur qui fume ?'),
              SizedBox(height: screenHeight * 0.03),
              SelectableTextWidget(text: 'Avez vous un bagage volumineux ?'),
              SizedBox(height: screenHeight * 0.03),
              SelectableTextWidget(text: 'Avez vous  des animaux ?'),
              SizedBox(height : screenHeight * 0.03),
              Container(
                  margin: EdgeInsets.fromLTRB(screenHeight * 0.01, 0, screenHeight * 0.01, 0),
                  child: CustomDropdown(options: [1, 2, 3, 4])),
              SizedBox(height: 10.0),
              Container(
                margin: EdgeInsets.fromLTRB(screenHeight * 0.01, 0, screenHeight * 0.01, 0),
                padding: EdgeInsets.fromLTRB(screenHeight * 0.015, 0, screenHeight * 0.01, 0),
                child: TextField(
                      decoration: InputDecoration(
                      fillColor: Colors.grey.shade300,
                      labelText: 'Laisser un commentaire',
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      // i can you only a icon (not prefixeIcon) to show the icons out of the Textfield
                      suffixIcon: Icon(Icons.insert_comment_rounded,
                          color: Colors.black)),
                ),
              ),
              SizedBox(height: screenHeight * 0.1),
              SizedBox(
                  width: screenWidth * 0.5,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue),),
                    child: const Text('Valider',
                        style: TextStyle(color: Colors.white)),
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
