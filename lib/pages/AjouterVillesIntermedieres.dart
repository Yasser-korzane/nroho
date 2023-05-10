import 'package:appcouvoiturage/AppClasses/Trajet.dart';
import 'package:flutter/material.dart';
import 'optionsconducteur.dart';
class AjouterVillesIntermedieres extends StatefulWidget {
  Trajet _trajetLance ;
  AjouterVillesIntermedieres(this._trajetLance);
  @override
  State<AjouterVillesIntermedieres> createState() => _AjouterVillesIntermedieresState();
}

class _AjouterVillesIntermedieresState extends State<AjouterVillesIntermedieres> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Villes intermdières'),
      leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () { Navigator.pop(context); },),),
      floatingActionButton: FloatingActionButton(child: Center(child: Text('Suivant')),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>  optionconduc(widget._trajetLance)));
        },
      ),
      body: Center(

      ),
    );
  }
}
