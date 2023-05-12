import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Detailspassaer extends StatelessWidget {
  final String photoUrl;
  final String fullName;
  final double rating;
  final String phoneNumber;
  final String email;
  final String carName;

  Detailspassaer({
    required this.photoUrl,
    required this.fullName,
    required this.rating,
    required this.phoneNumber,
    required this.email,
    required this.carName,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery
        .of(context)
        .size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
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
        margin: EdgeInsets.fromLTRB(screenWidth * 0.025, 0, screenWidth * 0.025, 0),
        padding:  EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight*0.03,
            ),
            Row(
              children: [
                /*CircleAvatar(
                  radius: 38.0,
                  backgroundImage: NetworkImage(photoUrl),
                ),*/
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
            SizedBox(height: screenHeight*0.025),
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Text("Numéro de téléphone = ",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff137c8b),
                        ),
                      )),
                ),
                Expanded(
                    child: GestureDetector(
                        onTap: () {
                          canLaunchUrlString("tel:$phoneNumber");
                        },
                        child: Text(phoneNumber)),
                    flex: 4),
              ],
            ),
            SizedBox(height: screenHeight*0.014),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text("Email = ",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff137c8b),
                        ),
                      )),
                ),
                Expanded(child: Text(email), flex: 8),
              ],
            ),
            SizedBox(height: screenHeight*0.014),
            SizedBox(height: screenHeight*0.04),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Icon(Icons.circle, color: Colors.purple),
                      // SizedBox(height: 20),
                      Container(
                        height: screenHeight* 0.09,
                        width: 1,
                        color: Colors.grey,
                      ),
                      // SizedBox(height: 8),
                      Icon(
                        Icons.circle_outlined,
                        color: Colors.purple,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Container(
                        child: ListTile(
                          title: Text(
                            '18 : 30 PM',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('OUED Smar'),
                          onTap: () {
                            // handle onTap event
                          },
                        ),
                      ),
                      SizedBox(height: screenHeight*0.03),
                      Container(
                        child: ListTile(
                          title: Text(
                            '20 : 30 PM',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('  BAROUAGHIA Media'),
                          onTap: () {
                            // handle onTap event
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: screenHeight*0.018),
            Container(
              padding: EdgeInsets.fromLTRB(screenWidth*0.03, screenHeight*0.016, screenWidth*0.03, screenHeight*0.016),
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
            SizedBox(height: screenHeight * 0.03),

            Row(
              children: [
                Expanded(
                    flex: 5,
                    child: SizedBox(width: 5,)),
                Expanded(
                  flex: 4,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // handle right button press
                    },
                    icon: Icon(Icons.phone_in_talk_outlined, size: 32),
                    label: Text(
                      'Contacter le passager',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,color: Color(0xff137cb8)),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffb8cbd0),
                        side: BorderSide.none,
                        shape: StadiumBorder(side: BorderSide())
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight*0.045,),
            ElevatedButton(
              onPressed: () {
              },

              style:  ButtonStyle(
                elevation: MaterialStateProperty.all<double>(4.0),
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: screenHeight*0.001,horizontal:screenWidth*0.20)),
                backgroundColor: MaterialStateProperty.all<Color>( Color(0xff137c8b)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              child: const Text('Accepter la demande',
                  style: TextStyle(color: Colors.white,fontFamily: 'Poppins')),
            ),
            ElevatedButton(
              onPressed: () {
              },
              style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(0.0),
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: screenHeight*0.001,horizontal:screenWidth*0.23)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              child: const Text('Refuser la demande',
                  style: TextStyle(color: Colors.red,fontFamily: 'Poppins')),
            )

          ],
        ),
      ),

    );
  }
}

