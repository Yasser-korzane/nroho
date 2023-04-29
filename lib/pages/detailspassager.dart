import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';
class detailsPassager extends StatelessWidget {
  const detailsPassager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final double defaultPadding = 10;

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                defaultPadding,
                defaultPadding * 2,
                defaultPadding,
                defaultPadding * 2,
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(defaultPadding),
                    decoration: BoxDecoration(
                      color: Color(0xFFBAF1F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Text(
                            'Informations de la course',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenWidth * 0.05,
                                  // responsive font size
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins'
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // Add your logic here to navigate back to the previous page
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(defaultPadding),
                              child: InkWell(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.cancel,
                                  color: Colors.white,
                                  size: screenWidth * 0.04, // responsive icon size
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Date et Heure',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Icon(Icons.calendar_month_outlined)),
                            Expanded(
                              child: Text('Mardi 31 février 2005 ',style: TextStyle(fontFamily: 'Poppins'),),
                              flex: 5,
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Row(
                          children: [
                            Expanded(flex: 1, child: Icon(Icons.access_time)),
                            Expanded(
                              child: Text('13:20 ',style: TextStyle(fontFamily: 'Poppins'),),
                              flex: 5,
                            ),
                          ],
                        ),
                        Divider(color: Colors.black, thickness: 1),
                        Row(
                          children: [
                            Text(
                              'Itinéraire',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Image.network(
                          'https://assets.website-files.com/5e832e12eb7ca02ee9064d42/5f7db426b676b95755fb2844_Group%20805.jpg',
                          height: screenHeight * 0.25,
                          width: screenWidth * 0.9,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  Icon(Icons.circle, color: Colors.purple),
                                  // SizedBox(height: screenHeight * 0.03),
                                  Container(
                                    height: screenHeight * 0.05,
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  // SizedBox(height: screenHeight * 0.03),
                                  Icon(
                                    Icons.circle_outlined,
                                    color: Colors.purple,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 9,
                              child: Column(
                                children: [
                                  Container(
                                    child: ListTile(
                                      title: Text(
                                        'OUED Smar',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins'),
                                      ),
                                      onTap: () {
                                        // handle onTap event
                                      },
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.005),
                                  Container(
                                    child: ListTile(
                                      title: Text(
                                        'BAROUAGHIA Medea',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,fontFamily: 'Poppins'),

                                      ),
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
                        Divider(color: Colors.black, thickness: 1),
                        Row(
                          children: [
                            Text(
                              'Le chauffeur/Le passagé :',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: CircleAvatar(
                                radius: 30.0,
                                backgroundImage: NetworkImage(
                                    'https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1031&q=80'),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              flex: 8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("HICHEM Boulacheb",
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins'
                                        ),
                                      )),
                                  SizedBox(height: 4.0),
                                  OutlinedButton(
                                    onPressed: () {
                                      launchUrlString("tel:+213 65498325");// Handle button press
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          side: BorderSide(color: Colors.blue),
                                        ),
                                      ),
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                      foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blue),
                                    ),
                                    child: Padding(
                                      padding:
                                      EdgeInsets.all(defaultPadding * 0.005),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.phone_in_talk_outlined,
                                            color: Colors.blue,
                                          ),
                                          SizedBox(width: defaultPadding * 0.5),
                                          Text(
                                            '+213 65498325',
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Poppins'
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(color: Colors.black, thickness: 1),
                        Row(
                          children: [
                            Text(
                              'Prix : ',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Text(
                                '400 DA',
                                style: TextStyle(
                                  // fontWeight: FontWeight.w400,
                                  fontSize: 16.0,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.1),
                        Divider(color: Colors.black, thickness: 1),
                        Row(
                          children: [
                            Text(
                              'Besoin d’aide ?',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.0,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        Center(
                          child: Flexible(
                            child: Text.rich(
                              TextSpan(
                                text: 'Si vous avez un problème avec ce trajet, contactez notre service client pour plus d’aide ou signalez directement par ',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16.0,
                                  fontFamily: 'Poppins',
                                ),
                                children: [
                                  TextSpan(
                                    text: 'ici',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16.0,
                                      fontFamily: 'Poppins',
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        launchUrlString('https://tresor.cse.club/');
                                      },
                                  )
                                ],
                              ),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                              maxLines: null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}