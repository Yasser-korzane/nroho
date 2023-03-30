import 'package:flutter/material.dart';



class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Color(0xff344D59),
            ),
            onPressed: () {},
          ),
          title: Container(
            margin: EdgeInsets.only(bottom: 20.0, top: 60.0),
            child: Text(
              'Contactez Nous',
              style: TextStyle(color: Color(0xff344D59)),
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/images.jfif"),
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
              top: 150.0,
              left: 60.0,
              child: CircleAvatar(
                radius: 25.0,
                backgroundImage: AssetImage("assets/images/mailProfilePicture.jpg"),
              ),
            ),
            Positioned(
              top: 160.0,
              left: 30.0,
              right: 20.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Mohamed Grine',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Etudiant 2CP à ESI Alger',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Developpeur mobile (Flutter , Java , Kotlin)',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Chef d’equipe',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 400,
              left: 20.0,
              child: Row(
                children: [
                  Icon(
                    Icons.mail,
                    size: 50,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    'lm_grine@esi.dz',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 500.0,
              left: 20.0,
              child: Row(
                children: [

                  new Tab(icon: new Image.asset("assets/images/linkedInLogo.png"),),
                  SizedBox(width: 10.0),
                  Text(
                    'LinkedIn',
                    style: TextStyle(fontSize: 16),
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
