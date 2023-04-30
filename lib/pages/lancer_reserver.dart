import 'package:appcouvoiturage/pages/trajetsLances.dart';
import 'package:appcouvoiturage/pages/trajetsReserves.dart';
import 'package:flutter/material.dart';



class Trajets extends StatefulWidget {
  const Trajets({Key? key}) : super(key: key);

  @override
  State<Trajets> createState() => _TrajetsState();
}

class _TrajetsState extends State<Trajets> {
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Mes Trajets',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontFamily: 'Poppins',
              ),),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          bottom: TabBar(
            labelStyle: TextStyle(fontFamily: 'Poppins'),
            indicatorColor: Colors.blue,
            labelColor: Colors.blue.shade700,
            unselectedLabelColor: Colors.blueGrey[900],
              tabs: [
                Tab(text: 'Trajet lancer',
                ),
                Tab(text: 'Trajet reserver'),
              ],
          ),
        ),
        body: TabBarView(
          children: [
            cardLancerList(),
            cardReserverList(),
          ],
        ),
      ),
    );
  }
}
