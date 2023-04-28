import 'package:appcouvoiturage/pages/trajetsLances.dart';
import 'package:appcouvoiturage/pages/trajetsReserves.dart';
import 'package:flutter/material.dart';



class Trajets extends StatefulWidget {
  const Trajets({Key? key}) : super(key: key);

  @override
  State<Trajets> createState() => _TrajetsState();
}

class _TrajetsState extends State<Trajets> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery
        .of(context)
        .size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    const double defaultPadding = 10;

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
            cardLancerList(),
            cardReserverList(),
          ],
        ),
      ),
    );
  }
}
