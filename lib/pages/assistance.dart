import 'package:appcouvoiturage/pages/contactezNous.dart';
import 'package:appcouvoiturage/widgets/profilwidget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animations/animations.dart';
class Assistance extends StatelessWidget {
  const Assistance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
            child: Text(
          'Assistance',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: screenHeight*0.035,
            fontFamily: 'Poppins',
          ),
        )),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.03),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.25),
              Profilewidget(
                title: 'Guide',
                icon: Icons.my_library_books,
                onPress: () {},
              ),
              SizedBox(height: screenHeight * 0.02),
              Profilewidget(
                title: 'Contactez nous',
                icon: Icons.call,
                onPress: () {
                  /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactUs(),
                      ));*/
                      	Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation, secondaryAnimation) => ContactUs(),
                                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                          var begin = Offset(1.0, 0.0);
                                          var end = Offset.zero;
                                           var curve = Curves.ease;

                                           var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                     },
                                   ),
                                );

                },
              ),
              SizedBox(height: screenHeight * 0.02),
              Profilewidget(
                title: 'Avis',
                icon: Icons.comment,
                onPress: () {},
              ),
              SizedBox(height: screenHeight * 0.25),
              Text.rich(
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
                          launch('https://karimiarkane.github.io/QuestionNroho.github.io/');
                        },
                    )
                  ],
                ),
                softWrap: true,
                overflow: TextOverflow.visible,
                maxLines: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
