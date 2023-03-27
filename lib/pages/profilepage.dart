import 'package:appcouvoiturage/pages/Password.dart';
import 'package:appcouvoiturage/pages/profilmodification.dart';
import 'package:appcouvoiturage/pages/signup.dart';
import 'package:appcouvoiturage/pages/trajetdetails.dart';
import 'package:flutter/material.dart';
import 'package:appcouvoiturage/widgets/profilwidget.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({Key? key}) : super(key: key);

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
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
              child: Text('Profile       ',
                  style: Theme.of(context).textTheme.headlineMedium)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding:  EdgeInsets.all(screenWidth * 0.03),
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                        width: screenHeight *0.15,
                        height: screenHeight *0.15,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: const Image(
                                image: NetworkImage(
                                    'https://www.google.com/url?sa=i&url=https%3A%2F%2Funsplash.com%2Fs%2Fphotos%2Fprofile&psig=AOvVaw1RZ-njENZw_1IL8D25HljV&ust=1680019595580000&source=images&cd=vfe&ved=0CA8QjRxqFwoTCLi1m-u-_P0CFQAAAAAdAAAAABAE')))),
                  ],
                ),
                 SizedBox(height: screenHeight * 0.015),
                Text('data', style: Theme.of(context).textTheme.headline4),
                 RatingWidget(color: Colors.yellow,rating: 3.5,size: screenWidth*0.05),
                SizedBox(height: screenHeight * 0.005),
                Text('mohammedgrine@weal.harach',
                    style: Theme.of(context).textTheme.bodyMedium),
                 SizedBox(height: screenHeight * 0.02),
                SizedBox(
                    width: screenWidth * 0.5,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ModifierProfilePage(),));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          side: BorderSide.none,
                          shape: const StadiumBorder()),
                      child: const Text('Modifier Profile',
                          style: TextStyle(color: Colors.white)),
                    )),
                 SizedBox(height: screenHeight * 0.04),
                const Divider(),
                 SizedBox(height: screenHeight * 0.01 ),

                //  Menu
                Profilewidget(
                  title: 'Mes Courses',
                  icon: Icons.navigation_rounded,
                  onPress: () {

                  },
                ),
                SizedBox(height: screenHeight * 0.008 ),
                Profilewidget(
                  title: 'Mot de passe',
                  icon: Icons.key_outlined,
                  onPress: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MotdePasse(),));
                  },
                ),
                SizedBox(height: screenHeight * 0.008 ),
                Profilewidget(
                  title: 'Deconnexion',
                  icon: Icons.logout,
                  onPress: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'begin')));
                  },
                  endIcon: false,
                  textColor: Colors.redAccent,
                ),
              ],
            ),
          ),
        ));
  }
}



class RatingWidget extends StatelessWidget {
  final double rating;
  final Color color;
  final double size;

  const RatingWidget({super.key, this.rating = 0.0, this.color = Colors.amber, this.size = 24.0});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
            (index) => Icon(
          index < rating.floor() ? Icons.star : Icons.star_border,
          size: size,
          color: color,
        ),
      ),
    );
  }
}
