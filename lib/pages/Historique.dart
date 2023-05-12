import 'package:appcouvoiturage/AppClasses/Utilisateur.dart';
import 'package:flutter/material.dart';
import 'package:appcouvoiturage/pages/HistoriqueLancer.dart';
import 'package:appcouvoiturage/pages/HistoriqueReserver.dart';

class Historique extends StatelessWidget {
  Utilisateur _utilisateur;
  Historique(this._utilisateur);
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery
        .of(context)
        .size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.chevron_left, color: Colors.black)),
          title: Text('Historique',
              style: Theme.of(context).textTheme.titleLarge),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.blue,
            labelColor: Colors.blue.shade700,
            unselectedLabelColor: Colors.blueGrey[900],
            tabs: [
              Tab(text: 'Trajet lancé',),
              Tab(text: 'Trajet reservé'),
            ],
          ),
        ),
        body:TabBarView(
          children: [
            cardLancerListH(_utilisateur.Historique),
            cardReserverListH(_utilisateur.Historique),
          ],
        ),
      ),
    );
  }
}
