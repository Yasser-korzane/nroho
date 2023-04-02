import 'package:appcouvoiturage/pages/assistance.dart';
import 'package:appcouvoiturage/pages/details.dart';
import 'package:appcouvoiturage/pages/options.dart';
import 'package:appcouvoiturage/pages/profilepage.dart';
import 'package:appcouvoiturage/pages/trajet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
void main(){
  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'Poppins'),
    home: home(),
  ));
}

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery
        .of(context)
        .size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final double defaultPadding = 10;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image(
              image: NetworkImage(
                  'https://assets.website-files.com/5e832e12eb7ca02ee9064d42/5f7db426b676b95755fb2844_Group%20805.jpg'),
              fit: BoxFit.cover, // Cover the whole stack with the image
              height: double.infinity,
              width: double.infinity,
            ),
            // Your main page content goes here
            Container(
              child: Column(
                children: [
                  Expanded(flex: 60,child: Container()),
                  Expanded(flex: 40 ,child: Container(
                    padding: EdgeInsets.all(screenWidth * 0.1),
                    // use 10% of screen width as padding
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(screenWidth *
                                0.05), // use 5% of screen width as border radius
                          ),
                          child: GestureDetector(
                            onTap: (){
                              Get.to(()=>OuAllezVous(),transition: Transition.fade);
                            },
                            child: TextField(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => OuAllezVous(),));
                              },
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: 'Choisir un point de depart',
                                floatingLabelBehavior:
                                FloatingLabelBehavior.auto,
                                border: InputBorder.none,
                                // remove the border of the TextField
                                prefixIcon: Icon(Icons.my_location,
                                    color: Colors.blue),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        // use 3% of screen height as space between text fields
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(screenWidth *
                                0.05), // use 5% of screen width as border radius
                          ),
                          child: GestureDetector(
                            onTap: (){
                              Get.to(()=>OuAllezVous(),transition: Transition.fade);
                            },
                            child: TextField(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => OuAllezVous(),));
                              },
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: 'Choisir une destination',
                                floatingLabelBehavior:
                                FloatingLabelBehavior.auto,
                                border: InputBorder.none,
                                // remove the border of the TextField
                                prefixIcon: Icon(Icons.location_on_outlined,
                                    color: Colors.blue),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.025),
                        // use 4% of screen height as space between text fields and row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RideTypeSelector(),
                          ],
                        ),
                      ],
                    ),
                  ),
                  )
                ],
              ),
            ),
            Positioned(
              top: screenHeight*0.03,
              right: screenWidth*0.04,
              child: InkWell(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => details()));
                },
                child: Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.blue,
                  size: 50,

                ),
              ),
            ),
          ],
        ),

        bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() => this.index = index),
          height: screenHeight * 0.06,
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Actuel',
            ),

            NavigationDestination(
              icon: GestureDetector(
                child: Icon(Icons.directions_car_filled_outlined),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => options()));
                  Get.to(() => options(),transition: Transition.fade);

                },
              ),
              selectedIcon: Icon(Icons.directions_car_filled),
              label: 'Trajets',
            ),
            NavigationDestination(
              icon: GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Assistance()));
                  Get.to(() => Assistance(),transition: Transition.fade);

                },
                  child: Icon(Icons.question_answer_outlined)),
              selectedIcon: Icon(Icons.question_answer),
              label: 'Assistane',
            ),
            NavigationDestination(
              icon: GestureDetector(
                child: Icon(Icons.account_circle_outlined),
                onTap: () {
                  // Navigate to profile page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profilepage()),
                  );
                  Get.to(() => Profilepage(),transition: Transition.leftToRightWithFade);

                },
              ),
              selectedIcon: Icon(
                Icons.account_circle,
              ),
              label: 'Profile',
            ),
          ],
        ),

        // body: FlutterMap(
        //   options:  new MapOptions(
        //     center: new LatLng(36.7167, 3.13333),
        //       minZoom: 17.0
        //   ),
        //     layers : [
        //       new tilLayersOptions
        //     ]
        //   ),
      ),
    );
  }
}

class RideTypeSelector extends StatefulWidget {

  @override
  _RideTypeSelectorState createState() => _RideTypeSelectorState();
}

class _RideTypeSelectorState extends State<RideTypeSelector> {
  List<bool> _isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      child: ToggleButtons(
        isSelected: _isSelected,
        onPressed: (int index) {
          setState(() {
            _isSelected[index] = !_isSelected[index];
            _isSelected[1 - index] = !_isSelected[1 - index];
          });
        },
        selectedColor: Colors.white,
        disabledBorderColor: Colors.blue,
        fillColor: Colors.blue,
        borderRadius: BorderRadius.circular(20.0),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
            child: Text('Passager'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
            child: Text('Conducteur'),
          ),
        ],
        disabledColor: Colors.white,
      ),
    );
  }
}
