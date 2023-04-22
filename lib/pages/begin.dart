import 'package:appcouvoiturage/pages/connexion.dart';
import 'package:appcouvoiturage/pages/signup1.dart';
import 'package:flutter/material.dart';

class Commancer extends StatefulWidget {
  @override
  State<Commancer> createState() => _CommancerState();
}

class _CommancerState extends State<Commancer> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final double defaultPadding = 10;
    return Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/welcome.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding:  EdgeInsets.symmetric(vertical: screenHeight*0.001,horizontal: screenWidth*0.06),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'NRO7OO',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenHeight*0.001),
                        Text(
                          'La premiere et la mailleur app de couvoiturage dans l''ALGERIE',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding:  EdgeInsets.fromLTRB(screenWidth*0.06, screenHeight*0.31, screenWidth*0.06, screenHeight*0.15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: screenWidth*0.9,
                          height: screenHeight*0.055,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Color(0xff202e59)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Connexin(),));
                            },
                            child: Center(child: Text('Connexion', style: TextStyle(color: Colors.white))),
                          ),
                        ),
                        Container(
                          width: screenWidth*0.9,
                          height: screenHeight*0.055,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Sinup()));
                            },
                            child: Center(child: Text('creater un compte', style: TextStyle(color: Color(0xff202e59)))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
