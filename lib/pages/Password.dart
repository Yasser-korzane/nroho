import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MotdePasse extends StatelessWidget {
  const MotdePasse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final double defaultPadding = 10;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                // Navigator.pop(context)
              },
              icon: const Icon(Icons.chevron_left, color: Color(0xff344d59))),
          title: Text('Mot de passe',
              style: Theme.of(context).textTheme.titleLarge),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.all(screenWidth*0.08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight*0.04,),
                Center(child: Text('changer le mot de passe ',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)),
                SizedBox(height: screenHeight*0.1),
                Text('Ancien mot de passe',
                  style: TextStyle(fontWeight: FontWeight.bold),),

                TextField(

                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Entrez votre ancien mot de passe',

                  ),
                  obscureText: true,
                ),


                SizedBox(height: screenHeight*0.07),
                Text('Nouveau mot de passe ',
                  style: TextStyle(fontWeight: FontWeight.bold),),

                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Entrez votre nouveau mot de passe',

                  ),
                ),
                SizedBox(height: screenHeight*0.1),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue),),
                  onPressed: (){
                  },
                  child: Center(child: Text('Valider les modifications',style: TextStyle(color: Colors.white),)),

                ),
                SizedBox(height: screenHeight*0.17),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: 'besoin d’aide? ',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16.0,
                        fontFamily: 'Poppins',
                      ),
                      children: [
                        TextSpan(
                          text: ' Cliquez ici',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16.0,
                            fontFamily: 'Poppins',
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launchUrlString('https://tresor.cse.club/');
                            },
                          // ),
                          // TextSpan(
                          //   text: ' .',
                          // ),
                        )
                      ],
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    maxLines: null,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
