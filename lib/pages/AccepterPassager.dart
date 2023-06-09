import 'package:nroho/pages/Demandes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListDemandePassager extends StatefulWidget {
  @override
  State<ListDemandePassager> createState() => _ListDemandePassagerState();
}

class _ListDemandePassagerState extends State<ListDemandePassager> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.cancel_outlined) ,
              onPressed:(){
                Navigator.pop(context,false);
              } ,
            ),
            title:  Text(
              'Les passagers',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontFamily: 'Poppins' ,
                  color: Colors.black,
                  fontSize: screenWidth * 0.05,
                  // responsive font size
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.grey.shade300,
          ),
          body: DemandesPassager(),
        )
    );
  }
}
