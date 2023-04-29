import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Details extends StatelessWidget {
  final String photoUrl;
  final String fullName;
  final double rating;
  final String phoneNumber;
  final String email;
  final String carName;

  final List<String> commentaires = [
    'allah akbar allah akbar allah akbar allah akbar allah akbar allah akbar',
    'allah akbar allah akbar allah akbar allah akbar allah akbar allah akbar',
    'allah akbar allah akbar allah akbar allah akbar allah akbar allah akbar',
  ];
  final List<String> Viles = [
    'allah akbar',
    'allah akbar ',
    'allah akbar ',

  ];


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
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final double defaultPadding = 10;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin:
            EdgeInsets.fromLTRB(screenWidth * 0.025, 0, screenWidth * 0.025, 0),
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.04,
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
            SizedBox(height: screenHeight * 0.025),
            Row(
              children: [
                TextButton(
                 onPressed: () {
                      showModalBottomSheet(
                          isDismissible: true,
                          context: context,
                          builder: (context) => Builder(
                        builder: (context) {
                          if (Viles.isEmpty) {
                            // If the list is empty, display a message
                            return Center(
                                child: Text(
                                    'Il y a pas de ville intermidiere'));
                          } else {
                            // If the list is not empty, display the commentaires in a ListView
                            return ListView.separated(
                              separatorBuilder: (context, index) => Divider(
                                thickness: 1.0,
                                color: Colors.grey[300],
                              ),
                              itemCount: Viles.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    leading: Icon(Icons.location_on_outlined),
                                    title: Text(
                                     Viles[index],
                                      style: TextStyle(
                                        fontFamily: 'poppins',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      )
                      );
                    },
                    child: Text('Villes intermedieres',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff137c8b),
                          ),
                        )
                    )
                )
              ],
            ),
            // SizedBox(height: screenHeight * 0.014),
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
            SizedBox(height: screenHeight * 0.014),
            Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Text("Marque de voiture = ",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff137c8b),
                        ),
                      )),
                ),
                Expanded(child: Text(carName), flex: 5),
              ],
            ),
            SizedBox(height: screenHeight * 0.014),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text("Matricule = ",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff137c8b),
                        ),
                      )),
                ),
                Expanded(child: Text(carName), flex: 5),
              ],
            ),
            SizedBox(height: screenHeight * 0.04),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Icon(Icons.circle, color: Colors.purple),
                      // SizedBox(height: 20),
                      Container(
                        height: screenHeight * 0.09,
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
                      SizedBox(height: screenHeight * 0.03),
                      Container(
                        child: ListTile(
                          title: Text(
                            '20 : 30 PM',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('BAROUAGHIA Media'),
                          onTap: () {
                            // handle onTap event
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Column(
                  children: [
                    Container(
                      height: screenHeight * 0.13,
                    ),
                    IconButton(
                      icon: Icon(Icons.comment_outlined),
                      iconSize: 30,
                      onPressed: () {
                        showModalBottomSheet(
                          isDismissible: true,
                          context: context,
                          builder: (context) => Builder(
                            builder: (context) {
                              if (commentaires.isEmpty) {
                                // If the list is empty, display a message
                                return Center(
                                    child: Text(
                                        'This conducteur has no commentaires'));
                              } else {
                                // If the list is not empty, display the commentaires in a ListView
                                return ListView.separated(
                                  separatorBuilder: (context, index) => Divider(
                                    thickness: 1.0,
                                    color: Colors.grey[300],
                                  ),
                                  itemCount: commentaires.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        commentaires[index],
                                        style: TextStyle(
                                          fontFamily: 'poppins',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ))
              ],
            ),
            SizedBox(height: screenHeight * 0.04),
            Container(
              padding: EdgeInsets.fromLTRB(
                  screenWidth * 0.03,
                  screenHeight * 0.016,
                  screenWidth * 0.03,
                  screenHeight * 0.016),
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
                  flex: 4,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // handle left button press
                    },
                    icon: Icon(Icons.map_outlined, size: 32),
                    label: Text(
                      'Voir le rajet sur la carte',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff137c8b)),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffb8cbd0),
                        side: BorderSide.none,
                        shape: StadiumBorder(side: BorderSide())),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: 5,
                    )),
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
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff137cb8)),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffb8cbd0),
                        side: BorderSide.none,
                        shape: StadiumBorder(side: BorderSide())),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.06,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(4.0),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(
                        vertical: screenHeight * 0.001,
                        horizontal: screenWidth * 0.23)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xff137c8b)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              child: Text(
                'Demander un trajet',
                style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(0.0),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(
                        vertical: screenHeight * 0.001,
                        horizontal: screenWidth * 0.20)),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.transparent),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              child: const Text('Annulez le trajet',
                  style: TextStyle(color: Colors.red, fontFamily: 'Poppins')),
            )
          ],
        ),
      ),
    );
  }
}