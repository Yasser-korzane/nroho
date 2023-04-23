import 'package:flutter/material.dart';
import 'package:appcouvoiturage/pages/assistance.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final String subject = "Contactez_nous";
    final String linkedInProfileUrl ='linkedin.com/in/grine-mohammed-205b01238';
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'lm_grine@esi.dz',
      queryParameters: {'subject': subject},
    );
    void _launchEmail(Uri emailUri)async {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        throw 'Could not launch email';
      }
    }
    void _launchLinkedIn(String linkedInProfileUrl) async {
      /*final Uri url = Uri.parse(linkedInProfileUrl);
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch LinkedIn';
      }*/
    }
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
            onPressed: () {// l'icone retour en haut a gauche nous permttra de revenir vers la page d'avant(Assistance)
              Navigator.pop(
                context
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
              style: TextStyle(color: Color(0xff344D59),fontFamily: 'Popping'),
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
                NetworkImage('https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1031&q=80'),
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
                    '  Grine Mohammed',
                    style: TextStyle(
                        fontSize: screenWidth * 0.0583,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Popping'),
                  ),
                  SizedBox(height: screenHeight * 0.0112),
                  Text(
                    'Etudiant 2CP à ESI Alger',
                    style: TextStyle(fontSize: screenWidth * 0.04,fontFamily: 'Popping'),
                  ),
                  Text(
                      'Développeur mobile (Flutter , Java , Kotlin)',
                    style: TextStyle(fontSize: screenWidth * 0.04,fontFamily: 'Popping'),
                  ),
                  Text(
                    'Chef d’équipe de l\'application Nro7o',
                    style: TextStyle(fontSize: screenWidth * 0.04,fontFamily: 'Popping'),
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
                    onPressed: () {_launchEmail(_emailLaunchUri);},
                    child: Text(
                      'lm_grine@esi.dz',
                      style: TextStyle(
                          color: Colors.black, fontSize: screenWidth * 0.0388,fontFamily: 'Popping'),
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
                    onPressed:(){_launchLinkedIn(linkedInProfileUrl);},
                    child:Text(
                    'LinkedIn',
                    style: TextStyle( color: Colors.black, fontSize: screenWidth * 0.0388,fontFamily: 'Popping'),
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
