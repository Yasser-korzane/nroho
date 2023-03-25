import 'package:appcouvoiturage/pages/options.dart';
import 'package:appcouvoiturage/pages/profilepage.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(40.0),
        child: Column(
          children: [
            Expanded(
              flex: 60,
              child: Container(
                child: Image(image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1rQHFnPgfrAPafybbwk4OOaD69m2bBM5Lqqm-t1RM_A&s)'),
                  // TODO: add the map here
                ),
              ),
            ),
            Expanded(
              flex: 30,
              child: Container(
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Entrer la place de depart',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          prefixIcon: Icon(Icons.my_location, color: Colors.blue)),
                    ),
                    SizedBox(height: 15.0),
                    TextField(
                      decoration: InputDecoration(
                          labelText: 'Entrer la place d arivee',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          // i can you only a icon (not prefixeIcon) to show the icons out of the Textfield
                          prefixIcon:
                          Icon(Icons.location_on_outlined, color: Colors.blue)),
                    ),
                    SizedBox(height: 25.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [RideTypeSelector()],
                    ),
                  ],
                )
              ),
            ),


          ],
        ),
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (index) => setState(() => this.index = index),
        height: 60,
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
              },
            ),
            selectedIcon: Icon(Icons.directions_car_filled),
            label: 'Trajets',
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
    return ToggleButtons(
      isSelected: _isSelected,
      onPressed: (int index) {
        setState(() {
          _isSelected[index] = !_isSelected[index];
          _isSelected[1 - index] = !_isSelected[1 - index];
        });
      },
      selectedColor: Colors.white,
      fillColor: Colors.blue,
      disabledColor: Colors.black,
      borderRadius: BorderRadius.circular(20.0),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
          child: Text('Take a ride'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
          child: Text('Announce a ride'),
        ),
      ],
    );
  }
}
