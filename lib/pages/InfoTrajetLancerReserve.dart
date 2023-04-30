import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class detailsPassagerConducteurHis extends StatelessWidget {
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
                              fontFamily: 'Poppins'),
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
                            onTap: () {
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
                          'Date et Heure de depart',
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
                          child: Text(
                            'Mardi 31 février 2005 ',
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                          flex: 5,
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      children: [
                        Expanded(flex: 1, child: Icon(Icons.access_time)),
                        Expanded(
                          child: Text(
                            '13:20 ',
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                          flex: 5,
                        ),
                      ],
                    ),
                    Divider(color: Colors.black, thickness: 1),
                    Row(
                      children: [
                        Text(
                          'Date et Heure d arrivee',
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
                          child: Text(
                            'Mardi 31 février 2005 ',
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                          flex: 5,
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      children: [
                        Expanded(flex: 1, child: Icon(Icons.access_time)),
                        Expanded(
                          child: Text(
                            '13:20 ',
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                          flex: 5,
                        ),
                      ],
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
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins'),
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
