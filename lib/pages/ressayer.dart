import 'package:nroho/Services/wrapper.dart';
import 'package:flutter/material.dart';

class ressayer extends StatefulWidget {
  const ressayer({Key? key}) : super(key: key);

  @override
  State<ressayer> createState() => _ressayerState();
}

class _ressayerState extends State<ressayer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Vous n'êtes pas connecté à Internet",style: TextStyle(fontFamily: 'Poppins'),),
        ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Wrapper(),));
    // Réessayer la connexion en rappelant la fonction de vérification de la connectivité
         },
          child: Text("Réessayer",style: TextStyle(fontFamily: 'Poppins'),),
    ),
    ],
    ) ,
    ),
)   ;
  }
}
