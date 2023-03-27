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
              // Navigator.pop(context)
            },
            icon: const Icon(Icons.chevron_left, color: Colors.black)),
        title: Text('Plus d’informations',
            style: Theme.of(context).textTheme.headline6),
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
                SizedBox(height: screenHeight * 0.02),
                SelectableTextWidget(text: ' Acceptez vous un bagages volumineux ?'),
                SizedBox(height: screenHeight * 0.02),
                SelectableTextWidget(text: 'Acceptez vous les animaux ?'),
                SizedBox(height : screenHeight * 0.02),
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
                        labelText: 'Proposer votre prix',
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        // i can you only a icon (not prefixeIcon) to show the icons out of the Textfield
                        suffixIcon: Icon(Icons.insert_comment_rounded,
                            color: Colors.black)),
                  ),
                ),
                SizedBox(height: screenHeight * 0.25),
                SizedBox(
                    width: screenWidth * 0.5,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          side: BorderSide.none,
                          shape: const StadiumBorder()),
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
