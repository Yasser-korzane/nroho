import 'package:appcouvoiturage/pages/HistoriqueLancer.dart';
import 'package:appcouvoiturage/pages/HistoriqueReserver.dart';
import 'package:appcouvoiturage/pages/trajetsLances.dart';
import 'package:appcouvoiturage/pages/trajetsReserves.dart';
import 'package:flutter/material.dart';



class Historique extends StatefulWidget {
  const Historique({Key? key}) : super(key: key);

  @override
  State<Historique> createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historique> {
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
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
              Tab(text: 'Trajet lancer',),
              Tab(text: 'Trajet reserver'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            cardLancerListH(),
            cardReserverListH(),
          ],
        ),
      ),
    );
  }
}
