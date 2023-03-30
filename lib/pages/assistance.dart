import 'package:flutter/material.dart';
import 'package:appcouvoiturage/widgets/profilwidget.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter/gestures.dart';

class Assistance extends StatelessWidget {
  const Assistance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery
        .of(context)
        .size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final double defaultPadding = 10;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.chevron_left, color: Colors.black)),
        title: Center(
            child: Text('Assistance      ',
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineMedium)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.03),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.25),
            Profilewidget(
              title: 'Guide',
              icon: Icons.my_library_books,
              onPress: () {},
            ),
            SizedBox(height: screenHeight* 0.02),
            Profilewidget(
              title: 'Contactez nous',
              icon: Icons.call,
              onPress: () {},
            ),
            SizedBox(height: screenHeight* 0.02),
            Profilewidget(
              title: 'Avis',
              icon: Icons.comment,
              onPress: () {},
            ),
            SizedBox(height: screenHeight * 0.3),
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
                    text: ' Click ici',
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
          ],
        ),
      ),
    );
  }
}
