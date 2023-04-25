import 'package:appcouvoiturage/pages/Demandes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListDemandePassager extends StatefulWidget {
  const ListDemandePassager({Key? key}) : super(key: key);

  @override
  State<ListDemandePassager> createState() => _ListDemandePassagerState();
}

class _ListDemandePassagerState extends State<ListDemandePassager> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final double defaultPadding = 10;
    return SafeArea(
        child: Scaffold(
          body:
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(defaultPadding),
                              child: Text(
                                'Les passagers',
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    fontFamily: 'Poppins' ,
                                    color: Colors.black,
                                    fontSize: screenWidth * 0.05,
                                    // responsive font size
                                    fontWeight: FontWeight.bold,
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
                                  color: Color(0xFF3FE6FE),
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
                                      color: Colors.black,
                                      size: screenWidth * 0.04, // responsive icon size
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight*0.06,),
                      DemandesPassager(),
                    ],
                  ),
                ),

              ],
            ),
          ),
        )
    );
  }
}
