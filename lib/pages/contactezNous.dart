import 'package:flutter/material.dart';
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
              style: TextStyle(color: Color(0xff344D59),fontFamily: 'Poppins'),
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
              top: screenHeight * 0.15,
              left: screenWidth * 0.073,
              right: screenWidth * 0.0485,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Grine Mohammed',
                    style: TextStyle(
                        fontSize: screenWidth * 0.0583,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  ),



                  Text(
                    'Chef d’équipe de l\'application nroho',
                    style: TextStyle(fontSize: screenWidth * 0.04,fontFamily: 'Poppins'),
                  ),
                ],
              ),
            ),
            Positioned(
              top: screenHeight * 0.22,
              left: screenWidth * 0.0485,
              child: Row(
                children: [
                  Icon(
                    Icons.mail,
                    size: screenWidth * 0.09,
                  ),
                  SizedBox(width: screenWidth * 0.0244),
                  TextButton(
                    onPressed: () {_launchEmail(_emailLaunchUri);},
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Text(
                        'lm_grine@esi.dz',
                        style: TextStyle(
                            color: Colors.black, fontSize: screenWidth * 0.035,fontFamily: 'Poppins'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: screenHeight * 0.22,
              left: screenWidth * 0.595,


              child: Row(
                children: [
                  new Tab(icon: new Image.asset("assets/images/linkedInLogo.png"),height: 35,),
                  SizedBox( width:screenWidth * 0.0244),
                  TextButton(
                    onPressed:(){
                      launch('https://www.linkedin.com/in/grine-mohammed-205b01238/');
                    },
                    child:Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Text(
                      'LinkedIn',
                      style: TextStyle( color: Colors.black, fontSize: screenWidth * 0.035,fontFamily: 'Poppins'),
                  ),
                    ),
                  ),
                ],
              ),
            ),Positioned(
              top: screenHeight * 0.31,
              left: screenWidth * 0.073,
              right: screenWidth * 0.0485,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Challal Riad',
                    style: TextStyle(
                        fontSize: screenWidth * 0.0583,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  ),
]
              ),
            ),
            Positioned(
              top: screenHeight * 0.35,
              left: screenWidth * 0.0485,
              child: Row(
                children: [
                  Icon(
                    Icons.mail,
                    size: screenWidth * 0.09,
                  ),
                  SizedBox(width: screenWidth * 0.0244),
                  TextButton(
                    onPressed: () {_launchEmail(_emailLaunchUri);},
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Text(
                        'lr_challal@esi.dz',
                        style: TextStyle(
                            color: Colors.black, fontSize: screenWidth * 0.035,fontFamily: 'Poppins'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: screenHeight * 0.35,
              left: screenWidth * 0.595,


              child: Row(
                children: [
                  new Tab(icon: new Image.asset("assets/images/linkedInLogo.png"),height: 35,),
                  SizedBox( width:screenWidth * 0.0244),
                  TextButton(
                    onPressed:(){
                      launch('https://www.linkedin.com/in/riad-challal-06891222b');
                    },
                    child:Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Text(
                      'LinkedIn',
                      style: TextStyle( color: Colors.black, fontSize: screenWidth * 0.035,fontFamily: 'Poppins'),
                  ),
                    ),
                  ),
                ],
              ),
            ),Positioned(
              top: screenHeight * 0.45,
              left: screenWidth * 0.073,
              right: screenWidth * 0.0485,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Korzane Yasser',
                    style: TextStyle(
                        fontSize: screenWidth * 0.0583,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  ),
]
              ),
            ),
            Positioned(
              top: screenHeight * 0.49,
              left: screenWidth * 0.0485,
              child: Row(
                children: [
                  Icon(
                    Icons.mail,
                    size: screenWidth * 0.09,
                  ),
                  SizedBox(width: screenWidth * 0.0244),
                  TextButton(
                    onPressed: () {_launchEmail(_emailLaunchUri);},
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Text(
                        'ly_korzane@esi.dz',
                        style: TextStyle(
                            color: Colors.black, fontSize: screenWidth * 0.035,fontFamily: 'Poppins'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: screenHeight * 0.49,
              left: screenWidth * 0.595,


              child: Row(
                children: [
                  new Tab(icon: new Image.asset("assets/images/linkedInLogo.png"),height: 35,),
                  SizedBox( width:screenWidth * 0.0244),
                  TextButton(
                    onPressed:(){
                      launch('https://www.linkedin.com/in/yasser-korzane-154720243/');
                    },
                    child:Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Text(
                      'LinkedIn',
                      style: TextStyle( color: Colors.black, fontSize: screenWidth * 0.035,fontFamily: 'Poppins'),
                  ),
                    ),
                  ),
                ],
              ),
            ),Positioned(
              top: screenHeight * 0.59,
              left: screenWidth * 0.073,
              right: screenWidth * 0.0485,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Boulacheb Hichem',
                    style: TextStyle(
                        fontSize: screenWidth * 0.0583,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  ),
]
              ),
            ),
            Positioned(
              top: screenHeight * 0.63,
              left: screenWidth * 0.0485,
              child: Row(
                children: [
                  Icon(
                    Icons.mail,
                    size: screenWidth * 0.09,
                  ),
                  SizedBox(width: screenWidth * 0.0244),
                  TextButton(
                    onPressed: () {_launchEmail(_emailLaunchUri);},
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Text(
                        'lh_boulacheb@esi.dz',
                        style: TextStyle(
                            color: Colors.black, fontSize: screenWidth * 0.035,fontFamily: 'Poppins'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: screenHeight * 0.63,
              left: screenWidth * 0.595,


              child: Row(
                children: [
                  new Tab(icon: new Image.asset("assets/images/linkedInLogo.png"),height: 35,),
                  SizedBox( width:screenWidth * 0.0244),
                  TextButton(
                    onPressed:(){
                      launch('https://www.linkedin.com/in/grine-mohammed-205b01238/');
                    },
                    child:Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Text(
                      'LinkedIn',
                      style: TextStyle( color: Colors.black, fontSize: screenWidth * 0.035,fontFamily: 'Poppins'),
                  ),
                    ),
                  ),
                ],
              ),
            ),Positioned(
              top: screenHeight * 0.73,
              left: screenWidth * 0.073,
              right: screenWidth * 0.0485,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Iarkane Abdelkarim',
                    style: TextStyle(
                        fontSize: screenWidth * 0.0583,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  ),
]
              ),
            ),
            Positioned(
              top: screenHeight * 0.77,
              left: screenWidth * 0.0485,
              child: Row(
                children: [
                  Icon(
                    Icons.mail,
                    size: screenWidth * 0.09,
                  ),
                  SizedBox(width: screenWidth * 0.0244),
                  TextButton(
                    onPressed: () {_launchEmail(_emailLaunchUri);},
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Text(
                        'la_iarkane@esi.dz',
                        style: TextStyle(
                            color: Colors.black, fontSize: screenWidth * 0.035,fontFamily: 'Poppins'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: screenHeight * 0.77,
              left: screenWidth * 0.595,


              child: Row(
                children: [
                  new Tab(icon: new Image.asset("assets/images/linkedInLogo.png"),height: 35,),
                  SizedBox( width:screenWidth * 0.0244),
                  TextButton(
                    onPressed:(){
                      launch('https://www.linkedin.com/in/karim-iarkane-737b3622b/');
                    },
                    child:Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Text(
                      'LinkedIn',
                      style: TextStyle( color: Colors.black, fontSize: screenWidth * 0.035,fontFamily: 'Poppins'),
                  ),
                    ),
                  ),
                ],
              ),
            ),Positioned(
              top: screenHeight * 0.87,
              left: screenWidth * 0.073,
              right: screenWidth * 0.0485,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Dahmani Amira',
                    style: TextStyle(
                        fontSize: screenWidth * 0.0583,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  ),
]
              ),
            ),
            Positioned(
              top: screenHeight * 0.91,
              left: screenWidth * 0.0485,
              child: Row(
                children: [
                  Icon(
                    Icons.mail,
                    size: screenWidth * 0.09,
                  ),
                  SizedBox(width: screenWidth * 0.0244),
                  TextButton(
                    onPressed: () {_launchEmail(_emailLaunchUri);},
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Text(
                        'la_dahmani@esi.dz',
                        style: TextStyle(
                            color: Colors.black, fontSize: screenWidth * 0.035,fontFamily: 'Poppins'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: screenHeight * 0.91,
              left: screenWidth * 0.595,


              child: Row(
                children: [
                  new Tab(icon: new Image.asset("assets/images/linkedInLogo.png"),height: 35,),
                  SizedBox( width:screenWidth * 0.0244),
                  TextButton(
                    onPressed:(){
                      launch('https://www.linkedin.com/in/grine-mohammed-205b01238/');
                    },
                    child:Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Text(
                      'LinkedIn',
                      style: TextStyle( color: Colors.black, fontSize: screenWidth * 0.035,fontFamily: 'Poppins'),
                  ),
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
