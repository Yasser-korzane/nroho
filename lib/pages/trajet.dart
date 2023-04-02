import 'package:flutter/material.dart';
import 'package:appcouvoiturage/widgets/date_time.dart';


class OuAllezVous extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xff344D59),
          ),
          onPressed: () {},
        ),
        title: Text(
          'Où allez-vous ?',
          style: TextStyle(color: Color(0xff344D59), fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child :Container(
        child: Column(
          children: <Widget>[
            // Zone de recherche pour le départ
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:[ Column(
                  children: [
                    Icon(Icons.gps_fixed),
                    // SizedBox(height: screenHeight * 0.03),
                    Container(
                      height: 32,
                      width: 1,
                      color: Colors.grey,
                    ),
                    // SizedBox(height: screenHeight * 0.03),
                    Icon(
                      Icons.location_on,

                    ),
                  ],
                ),


                  Column(children:[ SizedBox(
                    width: 285,
                    height: 42,

                    child: TextField(

                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        fillColor: Colors.grey,
                        filled: true,
                        hintText: 'Départ',
                      ),
                    ),
                  ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 285,
                      height: 42,

                      child: TextField(

                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          fillColor: Colors.grey,
                          filled: true,
                          hintText: 'Arrivée',
                        ),
                      ),

                    ),
                  ]
                  ),

                ]
            ),


            SizedBox(height: 10),
            DateTimePickerRow(),
            SizedBox(height: 30),
            Divider(
              color: Colors.blueGrey,
              thickness: 2,
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.location_on,

                  ),
                  onPressed: () {},
                ),
                Text('choisir sur la map',style: TextStyle(color: Color(0xff344D59), fontSize: 20),),
              ],
            ),  Divider(
              color: Colors.blueGrey,
              thickness: 1,
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.gps_fixed,

                  ),
                  onPressed: () {},
                ),
                Text('Utiliser ma position',style: TextStyle(color: Color(0xff344D59), fontSize: 20),),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Container(
                color: Colors.grey,
                child:  Text('Historique des recherches',style: TextStyle(color: Color(0xff344D59), fontSize: 23, backgroundColor: Colors.grey ),),
              ),
            ),


            Divider(
              color: Colors.blueGrey,
              thickness: 1,
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.location_on,

                  ),
                  onPressed: () {},
                ),
                Text('Maoklane - Setif',style: TextStyle(color: Color(0xff344D59), fontSize: 20),),
              ],
            ),
            Divider(
              color: Colors.blueGrey,
              thickness: 1,
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.location_on,

                  ),
                  onPressed: () {},
                ),
                Text('Oued Smar - Alger',style: TextStyle(color: Color(0xff344D59), fontSize: 20),),
              ],
            ),
            SizedBox(
              height: 150,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 210,
                height: 43,
                  child: ElevatedButton(
                    onPressed: () {},

                    child: Text('Valider', style: TextStyle( fontSize: 20),),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  )

              ),
            ),
          ],
        ),
      ),

      ),
      );

  }
}
// Ajout SingleChildScrollView