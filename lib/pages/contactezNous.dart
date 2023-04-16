import 'package:flutter/material.dart';
import 'package:appcouvoiturage/pages/assistance.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.142),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Color(0xff344D59),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Assistance()),
              );
            },
          ),
          title: Container(
            margin: EdgeInsets.only(
              bottom: screenHeight * 0.0224,
              top: screenHeight * 0.0674,
            ),
            child: Text(
              'Contactez Nous',
              style: TextStyle(color: Color(0xff344D59)),
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/contactUsBackground.png"),
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.4),
              BlendMode.modulate,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: screenHeight * 0.168,
              left: screenWidth * 0.146,
              child: CircleAvatar(
                radius: screenWidth * 0.06,
                backgroundImage:
                AssetImage("assets/images/mailProfilePicture.jpg"),
              ),
            ),
            Positioned(
              top: screenHeight * 0.179,
              left: screenWidth * 0.073,
              right: screenWidth * 0.0485,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Mohamed Grine',
                    style: TextStyle(
                        fontSize: screenWidth * 0.0583,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: screenHeight * 0.0112),
                  Text(
                    'Etudiant 2CP à ESI Alger',
                    style: TextStyle(fontSize: screenWidth * 0.0286),
                  ),
                  Text(
                    'Developpeur mobile (Flutter , Java , Kotlin)',
                    style: TextStyle(fontSize: screenWidth * 0.0286),
                  ),
                  Text(
                    'Chef d’equipe',
                    style: TextStyle(fontSize: screenWidth * 0.0286),
                  ),
                ],
              ),
            ),
            Positioned(
              top: screenHeight * 0.448,
              left: screenWidth * 0.0485,
              child: Row(
                children: [
                  Icon(
                    Icons.mail,
                    size: screenWidth * 0.1214,
                  ),
                  SizedBox(width: screenWidth * 0.0244),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'lm_grine@esi.dz',
                      style: TextStyle(
                          color: Colors.black, fontSize: screenWidth * 0.0388),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: screenHeight * 0.561,
              left: screenWidth * 0.0495,


              child: Row(
                children: [

                  new Tab(icon: new Image.asset("assets/images/linkedInLogo.png"),),
                  SizedBox( width:screenWidth * 0.0244),
                  TextButton(
                    onPressed:(){},
                    child:Text(
                    'LinkedIn',
                    style: TextStyle( color: Colors.black, fontSize: screenWidth * 0.0388),
                  ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
