import 'package:firebase_auth/firebase_auth.dart';
import 'package:nroho/Services/base%20de%20donnee.dart';
import 'package:nroho/pages/Demandes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListDemandePassager extends StatefulWidget {
  bool ilYaUneNotification ;
  ListDemandePassager(this.ilYaUneNotification);
  @override
  State<ListDemandePassager> createState() => _ListDemandePassagerState();
}

class _ListDemandePassagerState extends State<ListDemandePassager> {
  @override
  void initState() {
    super.initState();
    if (widget.ilYaUneNotification){
      BaseDeDonnee().updateUtilisateurilYaUneNotification(FirebaseAuth.instance.currentUser!.uid, false);
    }
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
              onPressed:()async{
                if (widget.ilYaUneNotification){
                  await BaseDeDonnee().updateUtilisateurilYaUneNotification(FirebaseAuth.instance.currentUser!.uid, false);
                }
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
          body: DemandesPassager(widget.ilYaUneNotification),
        )
    );
  }
}
