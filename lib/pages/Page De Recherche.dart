import 'package:appcouvoiturage/AppClasses/Trajet.dart';
import 'package:flutter/material.dart';

import '../Services/base de donnee.dart';
import 'choisirchauffeur.dart';

class PageDeRecherche extends StatefulWidget {
  Trajet trajetReserve;

  PageDeRecherche(this.trajetReserve);

  @override
  State<PageDeRecherche> createState() => _PageDeRechercheState();
}

class _PageDeRechercheState extends State<PageDeRecherche> {
  late ConducteurTrajet c;
  List<ConducteurTrajet> monListe = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.trajetReserve.afficher();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Page de Recherche'),
              ElevatedButton(onPressed: (){
                //monListe = await baseDeDonnee.chercherConductuersPossibles('', widget.trajetReserve);
                c = ConducteurTrajet(BaseDeDonnee().creerUtilisateurVide(), widget.trajetReserve);
                c.utilisateur.nom = 'Grine';
                c.utilisateur.prenom = 'Mohammed';
                c.utilisateur.numeroTelephone = '07782470';
                monListe.add(c);
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => DriverListPage(monListe)));

              }, child: Text('Page de conducteurs possibles'))
            ],
          )
      ),
    );
  }
}
