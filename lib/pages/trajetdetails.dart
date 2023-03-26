import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Details extends StatelessWidget {
  final String photoUrl;
  final String fullName;
  final double rating;
  final String phoneNumber;
  final String email;
  final String carName;

  Details({
    required this.photoUrl,
    required this.fullName,
    required this.rating,
    required this.phoneNumber,
    required this.email,
    required this.carName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.chevron_left, color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 38.0,
                  backgroundImage: NetworkImage(photoUrl),
                ),
                SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(fullName,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    SizedBox(height: 4.0),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          Icons.star,
                          size: 20.0,
                          color: index < rating.round()
                              ? Colors.yellow
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Text("Numero de Telephone = ",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.green,
                        ),
                      )),
                ),
                Expanded(
                    child: GestureDetector(
                      onTap: (){
                        canLaunchUrlString("tel:$phoneNumber");
                      },
                        child: Text(phoneNumber)
                    ),
                    flex: 4),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text("Email = ",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.green,
                        ),
                      )),
                ),
                Expanded(child: Text(email), flex: 8),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text("Modéle de voiture = ",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.green,
                        ),
                      )),
                ),
                Expanded(child: Text(carName), flex: 5),
              ],
            ),
            SizedBox(height: 30.0),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Icon(Icons.circle,color: Colors.purple),
                      // SizedBox(height: 20),
                      Container(
                        height: 80,
                        width: 1,
                        color: Colors.grey,
                      ),
                      // SizedBox(height: 8),
                      Icon(Icons.circle_outlined,color: Colors.purple,),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Container(
              padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                border: Border.all(color: Colors.grey[400]!),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "28 Fevrier 2023",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "240 DZ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.0),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // handle left button press
                    },
                    icon: Icon(Icons.map_outlined, size: 32),
                    label: Text(
                      'Voir le  trajet  sur la map',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        side: BorderSide.none,
                        shape: StadiumBorder(side: BorderSide())
                    ),
                ),
                ),
                Expanded(
                    flex: 1,
                    child: SizedBox(width: 5,)),
                Expanded(
                  flex: 4,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // handle right button press
                    },
                    icon: Icon(Icons.phone_in_talk_outlined, size: 32),
                    label: Text(
                      'Contacter le chauffeur',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        side: BorderSide.none,
                        shape: StadiumBorder(side: BorderSide())
                    ),
                  ),
                ),
              ],
            )

          ],
        ),
      ),

    );
  }
}
